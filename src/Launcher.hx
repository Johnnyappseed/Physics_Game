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

	public function new(x:Int, y:Int) 
	{
		super();
		//center point
		staticCircle = Main.game.createCircle(x, y, 15, false);
		//log and angle
		log = Main.game.createBox(x - 35, y + 35, 300, 20, false, 1.0);
		//log.setType(B2Body.b2_dynamicBody);
		log.setAngle( -0.7853981633974483);
		//jointed log to center
		logJointDef = Main.game.revoluteJointFunction(staticCircle, log, staticCircle.getWorldCenter());
		Main.World.createJoint(logJointDef);
		//wieght, jointed to log
		wieght = Main.game.createBox(x + 50, y, 45, 40, true, 20.0);
		var joint:B2Vec2; 
		joint = new B2Vec2((x+50) * Main.PHYSICS_SCALE,(y-50) * Main.PHYSICS_SCALE);
		wieghtJointDef = Main.game.revoluteJointFunction(log, wieght, joint);
		Main.World.createJoint(wieghtJointDef);
		link = log;
		//rope
		for (i in 1...13)
		{
			body = Main.game.createRope(x - 141 + (i*10) - 5, y+141, 10, 4, true, 1.0, 0.2);
			fillerJointsDef = Main.game.revoluteJointFunction(link, body, new B2Vec2((x - 141 + (i * 10) - 10)*Main.PHYSICS_SCALE,(y+141)*Main.PHYSICS_SCALE));
			Main.World.createJoint(fillerJointsDef);
			link = body;
		}
		//add rock and link to rope
		
		body = Game_Canvas.game_Canvas.rock.circle;
		projectileJointDef = Main.game.revoluteJointFunction(link, body, new B2Vec2((x - 141 + (13 * 10) + 10) * Main.PHYSICS_SCALE, (y + 141) * Main.PHYSICS_SCALE));
		projectileJoint=Main.World.createJoint(projectileJointDef);
		//Main.World.destroyJoint(projectileJoint);
	}
	
}