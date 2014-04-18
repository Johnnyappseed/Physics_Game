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

/**
 * ...
 * @author John
 */
class Launcher extends Sprite
{
	var log:B2Body;
	var staticCircle:B2Body;
	var wieght:B2Body;

	public function new(x:Int, y:Int) 
	{
		super();
		staticCircle = Main.game.createCircle (x, y, 20, false);
		log = Main.game.createBox (x - 50, y, 300, 30, false, 1.0);
		var jointLog:B2RevoluteJointDef = Main.game.revoluteJointFunction(staticCircle, log, staticCircle.getWorldCenter());
		Main.game.World.createJoint(jointLog);
		wieght = Main.game.createBox(x + 50, y + 50, 50, 50, true, 1.0);
		var joint:B2Vec2; 
		joint = new B2Vec2(x+50,y);
		var jointWieght:B2RevoluteJointDef = Main.game.revoluteJointFunction(log, wieght, log.getWorldPoint(joint));//i think i need to apply the world physics scale to this
		Main.game.World.createJoint(jointWieght);
		//log.setAngle(-45);
		
		
		
	}
	
}