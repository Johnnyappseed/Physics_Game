package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.Lib;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import box2D.dynamics.joints.B2RevoluteJointDef;
import box2D.dynamics.joints.B2RevoluteJoint;
import box2D.dynamics.joints.B2Joint;
//http://www.emanueleferonato.com/2009/10/05/basic-box2d-rope/

/**
 * ...
 * @author John
 */
class Launcher extends Sprite
{
	var log:B2Body;
	var staticCircle:B2Body;
	var wieght:B2Body;
	var link:B2Body;
	var body:B2Body;
	var wieghtJointDef:B2RevoluteJointDef;
	var logJointDef:B2RevoluteJointDef;
	var fillerJointsDef:B2RevoluteJointDef;
	var projectileJointDef:B2RevoluteJointDef;
	var projectileJoint:B2Joint;
	
	var ropeLinks:Array;
	var ropeJoints:Array;
	
	var joint:B2Vec2; 
	var LOG_X:Int;
	var LOG_Y:Int;
	var LOG_ANGLE:Float;
	var WIEGHT_X:Int;
	var WIEGHT_Y:Int;
	var ROPE_Y:Int;

	public function new(x:Int, y:Int) 
	{
		super();
		ropeLinks = new Array[13];
		//center point
		staticCircle = Main.game.createCircle(x, y, 15, false);
		//log and angle
		log = Main.game.createBox( LOG_X = (x - 35), LOG_Y = (y + 35), 300, 20, false, 1.0);
		log.setAngle( LOG_ANGLE = (-0.7853981633974483));
		//jointed log to center
		logJointDef = Main.game.revoluteJointFunction(staticCircle, log, staticCircle.getWorldCenter());
		Main.World.createJoint(logJointDef);
		//wieght, jointed to log
		wieght = Main.game.createBox(WIEGHT_X = (x + 50), WIEGHT_Y = (y), 45, 40, true, 20.0);
		joint = new B2Vec2((x+50) * Main.PHYSICS_SCALE,(y-50) * Main.PHYSICS_SCALE);
		wieghtJointDef = Main.game.revoluteJointFunction(log, wieght, joint);
		Main.World.createJoint(wieghtJointDef);
		link = log;
		//rope
		for (i in 1...13)
		{
			body = Main.game.createRope(x - 141 + (i*10) - 5,ROPE_Y = (y+141), 10, 4, true, 1.0, 0.2);
			fillerJointsDef = Main.game.revoluteJointFunction(link, body, new B2Vec2((x - 141 + (i * 10) - 10)*Main.PHYSICS_SCALE,(y+141)*Main.PHYSICS_SCALE));
			Main.World.createJoint(fillerJointsDef);
			link = body;
		}
		//add ammo and link to rope
		
		body = Game_Canvas.game_Canvas.ammo.circle;
		projectileJointDef = Main.game.revoluteJointFunction(link, body, new B2Vec2((x - 141 + (13 * 10) + 10) * Main.PHYSICS_SCALE, (y + 141) * Main.PHYSICS_SCALE));
		projectileJoint=Main.World.createJoint(projectileJointDef);
	}
	public function increaseTheVelocityOfOurProjectileSoThatItMayInduceTheMaximumAmountOfDamageOnOurOpponents()
	{
		log.setType(B2Body.b2_dynamicBody);
	}
	public function firer()
	{
		Main.World.destroyJoint(projectileJoint);
	}
	public function reset()
	{
		Main.World.destroyBody(
	}
	
	
}