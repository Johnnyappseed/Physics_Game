package ;

import Math;
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
import openfl.Assets;
import flash.display.Bitmap;
//http://www.emanueleferonato.com/2009/10/05/basic-box2d-rope/

/**
 * ...
 * @author John
 */
class Launcher extends Sprite
{
	var logSprite:Sprite;
	var weightSprite:Sprite;
	var ropeSprite:Sprite;
	
	var log:B2Body;
	var staticCircle:B2Body;
	var wieght:B2Body;
	var link:B2Body;
	var body:B2Body;
	var wieghtJointDef:B2RevoluteJointDef;
	var wieghtJoint:B2Joint;
	var logJointDef:B2RevoluteJointDef;
	var logJoint:B2Joint;
	var ropeJointsDef:B2RevoluteJointDef;
	var ropeJoint:B2Joint;
	var projectileJointDef:B2RevoluteJointDef;
	var projectileJoint:B2Joint;
	
	var ropeLinks:List<B2Body>;
	var ropeJoints:List<B2Joint>;
	
	var joint:B2Vec2; 
	
	var ammo:Projectile;

	
	public function new(x:Int, y:Int) 
	{
		var logWidth:Int = 180;
		super();
		//trace(Main.game.gameCanvas);
		//make it to where when you press play that it starts up the launcher and whatnot
		
		ropeLinks = new List<B2Body>();
		ropeJoints = new List<B2Joint>();
		//center point 
		staticCircle = Main.game.createCircle(x, y, 10, false, 10);
		//log and angle
		log = Main.game.createBox( x - Math.sqrt((((logWidth * (2 / 3)) - (logWidth / 2))*((logWidth * (2 / 3)) - (logWidth / 2))) / 2), y + Math.sqrt((((logWidth * (2 / 3)) - (logWidth / 2))*((logWidth * (2 / 3)) - (logWidth / 2))) / 2), logWidth, 20, false, 1.0);
		log.setAngle( -0.7853981633974483);
		//jointed log to center
		logJointDef = Main.game.revoluteJointFunction(staticCircle, log, staticCircle.getWorldCenter());
		logJoint = Main.World.createJoint(logJointDef);
		//wieght, jointed to log
		wieght = Main.game.createBox(x + Math.sqrt((((logWidth -(logWidth * (2 / 3)))* (2/3)) * ((logWidth -(logWidth * (2 / 3)))* (2/3))) / 2), y + 35/2, 35, 35, true, 55.0);
		joint = new B2Vec2((x+Math.sqrt((((logWidth -(logWidth * (2 / 3)))* (2/3)) * ((logWidth -(logWidth * (2 / 3)))* (2/3))) / 2)) * Main.PHYSICS_SCALE,(y-Math.sqrt((((logWidth -(logWidth * (2 / 3)))* (2/3)) * ((logWidth -(logWidth * (2 / 3)))* (2/3))) / 2)) * Main.PHYSICS_SCALE);
		wieghtJointDef = Main.game.revoluteJointFunction(log, wieght, joint);
		wieghtJoint = Main.World.createJoint(wieghtJointDef);
		link = log;
		//rope
		var ammoLinkCount:Int = 0;
		for (i in 0...8)
		{
			body = Main.game.createRope(x - Math.sqrt(((logWidth * (2 / 3)) * (logWidth * (2 / 3))) / 2) + (i * 10) + 5, y + Math.sqrt(((logWidth * (2 / 3)) * (logWidth * (2 / 3))) / 2) , 10, 5, true, 1.0, 0.2);
			ropeJointsDef = Main.game.revoluteJointFunction(link, body, new B2Vec2((x - Math.sqrt(((logWidth * (2 / 3)) * (logWidth * (2 / 3))) / 2) + (i * 10) - 5)*Main.PHYSICS_SCALE,(y+Math.sqrt(((logWidth * (2 / 3)) * (logWidth * (2 / 3))) / 2))*Main.PHYSICS_SCALE));
			ropeJoint = Main.World.createJoint(ropeJointsDef);
			link = body;
			ropeLinks.add(link);
			ropeJoints.add(ropeJoint);
			ammoLinkCount++;
		}
		//add ammo and link to rope
		ammo = new Projectile(x - Math.sqrt(((logWidth * (2 / 3)) * (logWidth * (2 / 3))) / 2) + (ammoLinkCount * 10) + 10, y + Math.sqrt(((logWidth * (2 / 3)) * (logWidth * (2 / 3))) / 2));
		Main.game.gameCanvas.ammoBelt.push(ammo);
		//trace(Main.game.gameCanvas.ammoBelt);
		Main.game.gameCanvas.addChild(ammo);
		body = ammo.circle;
		projectileJointDef = Main.game.revoluteJointFunction(link, body, new B2Vec2((x - Math.sqrt(((logWidth * (2 / 3)) * (logWidth * (2 / 3))) / 2) + (ammoLinkCount * 10) + 10) * Main.PHYSICS_SCALE, (y + Math.sqrt(((logWidth * (2 / 3)) * (logWidth * (2 / 3))) / 2)) * Main.PHYSICS_SCALE));
		projectileJoint = Main.World.createJoint(projectileJointDef);
		
		//add sprite to log
		var logIcon = new Bitmap(Assets.getBitmapData("img/logIcon.png"));
		logIcon.width = logWidth;
		logSprite = new Sprite();
		logSprite.addChild(logIcon);
		logSprite.x = -logIcon.width / 2; 
		logSprite.y = -logIcon.height / 2;
		this.addChild(logSprite);
		
		//put sprite on screen
		//logSprite.x = x;
		//logSprite.y = y;
		
		//add sprite to weight
		var weightIcon = new Bitmap(Assets.getBitmapData("img/weightIcon.png"));
		weightSprite = new Sprite();
		weightSprite.addChild(weightIcon);
		weightSprite.x = -weightIcon.width / 2; 
		weightSprite.y = -weightIcon.height / 2;
		this.addChild(weightSprite);
		
		//put sprite on screen
		//weightSprite.x = x;
		//weightSprite.y = y;
	}
	
	public function increaseTheVelocityOfOurProjectileSoThatItMayInduceTheMaximumAmountOfDamageOnOurOpponents()
	{
		log.setType(B2Body.b2_dynamicBody);
	}
	
	public function firer()
	{
		Main.World.destroyJoint(projectileJoint);
	}
	
	public function destroy()
	{
		Main.World.destroyJoint(wieghtJoint);
		Main.World.destroyJoint(logJoint);
		for (i in ropeJoints)
		{
			ropeJoints.remove(i);
			Main.World.destroyJoint(i);
		}
		for (i in ropeLinks)
		{
			ropeLinks.remove(i);
			Main.World.destroyBody(i);
		}
		Main.World.destroyBody(wieght);
		Main.World.destroyBody(log);
		Main.World.destroyBody(staticCircle);
		
	}
	
	public function act() 
	{
		logSprite.x = (log.getPosition().x-0) / Main.PHYSICS_SCALE;
		logSprite.x -= 90;
		logSprite.y = (log.getPosition().y-0) / Main.PHYSICS_SCALE;
		logSprite.y -= 10; 
		logSprite.rotation = log.getAngle() * 180.0 / Math.PI;
		
		weightSprite.x = (wieght.getPosition().x - 0) / Main.PHYSICS_SCALE;
		weightSprite.y = (wieght.getPosition().y - 0) / Main.PHYSICS_SCALE;
		weightSprite.rotation = wieght.getAngle() * 180.0 / Math.PI;
		
		//for (r in ropeLinks)
		//{
			//r.x = log.getPosition().x / Main.PHYSICS_SCALE;
			//r.y = log.getPosition().y / Main.PHYSICS_SCALE;
			//r.rotation = log.getAngle() * 180.0 / Math.PI;
		//}
	}
	
	
}