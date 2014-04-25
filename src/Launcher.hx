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
	var link:B2Body;
	var body:B2Body;

	public function new(x:Int, y:Int, radius:Int) 
	{
		super();
		staticCircle = Main.game.createCircle (x, y, 15, false);
		log = Main.game.createBox (x - 35, y + 35, 300, 20, true, 1.0);
		log.setAngle(-0.7853981633974483);
		Main.game.revoluteJointFunction(staticCircle, log, staticCircle.getWorldCenter());
		wieght = Main.game.createBox(x + 50, y, 45, 40, true, 30.0);
		var joint:B2Vec2; 
		joint = new B2Vec2((x+50) * Main.PHYSICS_SCALE,(y-50) * Main.PHYSICS_SCALE);
		Main.game.revoluteJointFunction(log, wieght, joint);
		link = log;
		for (i in 1...15)
		{
			body = Main.game.createRope(x - 141 + (i*10) - 5, y+141, 10, 4, true, 1.0, 0.2);
			Main.game.revoluteJointFunction(link, body, new B2Vec2(((x - 141 + (i * 10) - 10))*Main.PHYSICS_SCALE,(y+141)*Main.PHYSICS_SCALE));
			link = body;
		}
	}
	
}