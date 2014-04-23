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

	public function new(x:Int, y:Int, radius:Int) 
	{
		super();
		
		staticCircle = Main.game.createCircle (x, y, radius, false);
		log = Main.game.createBox (405, 0, 300, 75, true);
		
		var revoluteJointDef:B2RevoluteJointDef = Main.game.revoluteJointFunction(staticCircle, log);
		
		Main.game.World.createJoint(revoluteJointDef);
	}
	
}