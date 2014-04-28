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
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * ...
 * @author Tara 
 * @author John
 */

class Main extends Sprite 
{
	//miscellaneous
	var inited:Bool;
	public static var game;
	public static var PHYSICS_SCALE:Float = 1.0 / 30;
	private var PhysicsDebug:Sprite;
	public static var World:B2World;
	var gameStarted:Bool = false;
	
	//game canvas, menus, buttons, etc.
	public var gameCanvas:Game_Canvas;
	var startMenu:Sprite;
	var playButton:Sprite;
	
	var goodToLaunch:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		game = this;
		PhysicsDebug = new Sprite ();
		addChild (PhysicsDebug);
		World = new B2World(new B2Vec2 (0, 10.0), true);
		
		goodToLaunch = false;
		
		gameCanvas = new Game_Canvas();
		this.addChild(gameCanvas);
		
		//create+add start menu and buttons
		startMenu = createMenu("startMenuIcon.png");
		this.addChild(startMenu);
		playButton = createButtonAt(300, 300, "playButtonIcon.png", startMenu);
		
		
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		debugDraw.setFlags (B2DebugDraw.e_centerOfMassBit + B2DebugDraw.e_aabbBit + B2DebugDraw.e_shapeBit );// + B2DebugDraw.e_aabbBit);
		
		//shows fancy physics objects (remove before game is finished)
		World.setDebugDraw(debugDraw);
		
		//event listeners
		playButton.addEventListener(MouseEvent.CLICK, startGame);
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}

	/* SETUP */
	
	public function startGame(e) 
	{
		this.removeChild(startMenu);
		gameStarted = true;
		gameCanvas.enable();
	}

	public function createBox(x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool, density:Float):B2Body
	{
		//create body definition
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
		if (dynamicBody) bodyDefinition.type = B2Body.b2_dynamicBody;
		
		//create fixture definition
		var fixtureDefinition = new B2FixtureDef ();
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((width / 2) * PHYSICS_SCALE, (height / 2) * PHYSICS_SCALE);
		fixtureDefinition.shape = polygon;
		fixtureDefinition.density = density;
		fixtureDefinition.friction = 1;
		
		//put fixture+body def into a body to return
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
	
	public function createRope (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool, density:Float, friction:Float):B2Body
	{
		//create body definition
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
		if (dynamicBody) bodyDefinition.type = B2Body.b2_dynamicBody;
		
		//create fixture definition
		var fixtureDefinition = new B2FixtureDef ();
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((width / 2) * PHYSICS_SCALE, (height / 2) * PHYSICS_SCALE);
		fixtureDefinition.shape = polygon;
		fixtureDefinition.density = density;
		fixtureDefinition.friction = friction;
		
		//put fixture+body def into a body to return
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
	public function createCircle (x:Float, y:Float, radius:Float, dynamicBody:Bool):B2Body 
	{
		//create body definition
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);
		if (dynamicBody) bodyDefinition.type = B2Body.b2_dynamicBody;
		
		//create fixture definition
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = new B2CircleShape (radius * PHYSICS_SCALE);
		fixtureDefinition.density = 1;
		fixtureDefinition.friction = 1;
		
		//put fixture+body def into a body that can be returned
		var body = World.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
	
	public function createMenu(imgName:String)
	{
		var menuIcon = new Bitmap(Assets.getBitmapData("img/"+imgName));
		var menu = new Sprite();
		menu.addChild(menuIcon);
		
		return menu;
	}
	
	public function createButtonAt(placeX:Int, placeY:Int, imgName:String, menu:Sprite)
	{
		var buttonIcon = new Bitmap(Assets.getBitmapData("img/"+imgName));
		var button = new Sprite();
		button.addChild(buttonIcon);
		
		menu.addChild(button);
		
		button.x = placeX;
		button.y = placeY;
		
		return button;
	}
	
	private function this_onEnterFrame(event:Event)
	{
		/*//topBlock.applyForce(new B2Vec2(-10,0),topBlock.getPosition());
		//apply forces
		var b = World.getBodyList();
		while (b!=null)
		{
			//trace(b);
			var p = b.getPosition().copy();
			
			//p.subtract(new B2Vec2(cgx * PHYSICS_SCALE, cgy * PHYSICS_SCALE));
			p.normalize();
			p.multiply(-cga * b.getMass());
			b.applyForce(p, b.getPosition());
			//b.applyForce(
			b = b.m_next;
		}
		
		World.step (1 / Lib.current.stage.frameRate, 1, 1);
		World.clearForces ();
		//dude.act();
		World.drawDebugData ();*/
		
		World.step (1 / Lib.current.stage.frameRate, 10, 10);
		//dude.update();
		World.clearForces ();
		World.drawDebugData ();
		
		if (gameStarted) {
			gameCanvas.rock.act();
			for (b in gameCanvas.castleBlocks) b.act();
			if (gameCanvas.keyCheck(32)) 
			{
				gameCanvas.catapult.increaseTheVelocityOfOurProjectileSoThatItMayInduceTheMaximumAmountOfDamageOnOurOpponents();
				//if (goodToLaunch = true) gameCanvas.catapult.firer();
				goodToLaunch = true;
			}
		}
	}
	
	public function revoluteJointFunction(first:B2Body, second:B2Body, point:B2Vec2)
	{
		var revoluteJointDef:B2RevoluteJointDef = new  B2RevoluteJointDef();
		revoluteJointDef.initialize(first, second, point);
		
		revoluteJointDef.maxMotorTorque = 1.0;
		revoluteJointDef.enableMotor = true;
		return revoluteJointDef;
	}
	
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
