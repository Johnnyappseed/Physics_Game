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

	public function new(x:Int, y:Int, radius:Int) 
	{
		super();
		staticCircle = Main.game.createCircle (x, y, 15, false);
		log = Main.game.createBox (x - 35, y+35, 300, 20, true, 1.0);
		log.setAngle(-0.7853981633974483);
		var jointLog:B2RevoluteJointDef = Main.game.revoluteJointFunction(staticCircle, log, staticCircle.getWorldCenter());
		Main.game.World.createJoint(jointLog);
		wieght = Main.game.createBox(x + 35, y, 45, 40, true, 30.0);
		var joint:B2Vec2; 
		joint = new B2Vec2((x+35) * Main.PHYSICS_SCALE,(y-35) * Main.PHYSICS_SCALE);
		var jointWieght:B2RevoluteJointDef = Main.game.revoluteJointFunction(log, wieght, joint);
		Main.game.World.createJoint(jointWieght);
		
		}
	
}