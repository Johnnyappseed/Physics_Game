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
import motion.Actuate;

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
	
	//screen positioning var'sss
	var xv:Float;
	var yv:Float;
	
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		//initial values
		if (inited) return;
		inited = true;
		game = this;
		PhysicsDebug = new Sprite ();
		xv = 0.0;
		yv = 0.0;
		
		addChild (PhysicsDebug);
		World = new B2World(new B2Vec2 (0, 10.0), true);
		
		gameCanvas = new Game_Canvas();
		this.addChild(gameCanvas);
		
		//create+add start menu and buttons
		loadStartMenu();
		
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit);// + B2DebugDraw.e_centerOfMassBit + B2DebugDraw.e_aabbBit);// + B2DebugDraw.e_aabbBit);
		
		//shows fancy physics objects (remove before game is finished)
		World.setDebugDraw(debugDraw);
		
		//event listeners
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}

	/* SETUP */
	
	public function clearWorld()
	{
		gameCanvas.destroyAmmo();
		gameCanvas.catapultDestroy();
		gameCanvas.castle.destroy();
		gameCanvas.removeChild(gameCanvas.castle);
		gameCanvas.lookingAtLauncher = false;
		gameCanvas.fired = false;
		gameCanvas.launching = false;
		gameCanvas.disable();
	}
	
	public function loadStartMenu()
	{
		startMenu = createMenu("startMenuIcon.png");
		playButton = createButtonAt(300, 300, "playButtonIcon.png", startMenu);
		this.addChild(startMenu);
		playButton.addEventListener(MouseEvent.CLICK, startGame);
	}
	
	public function startGame(e) 
	{
		gameCanvas.enable();
		gameCanvas.creation();
		this.x = -gameCanvas.castle.avgX+400;
		playButton.removeEventListener(MouseEvent.CLICK, startGame);
		this.removeChild(startMenu);
		gameStarted = true;
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
		
		//game act'ions
		if (gameStarted) 
		{
			gameCanvas.act();
			if (gameCanvas.ammoBelt.isEmpty() == false)
			{
				var b:Projectile = gameCanvas.ammoBelt.first();
				//screen movement
				if (b.x < 0)
				{
					this.x = this.x * 0.95;
				}
				else if (b.x > 3000 && gameCanvas.fired == true )
				{
					//xv value should be the average position of all the castle blocks plus/minus half the screen
					xv = (-gameCanvas.castle.avgX+400) - this.x;
					this.x += xv * 0.1;
				}
				//else if (b.circle.get)
				//{
					//
				//}
				else if (gameCanvas.fired)
				{
					xv = (-b.x)+400 - (this.x);
					this.x += xv * 0.1;
				}
				//when the ammo collides witht he blocks the focus of x should be the average of all the castle blocks
				else 
				{
					this.x = this.x * 0.95;
				}
				
				if ((( -b.y) + 240 > 0) && b.x > 0 && gameCanvas.fired == true && b.x < 3000)
				{
					yv = (-b.y)+240 - (this.y);
					this.y += yv * 0.1;
				}
				else 
				{
					this.y = this.y * 0.89;
				}
			}
			if (gameCanvas.gg == true)
			{
				this.x = 0;
				this.y = 0;
				clearWorld();
				loadStartMenu();
				gameCanvas.gg = false;
				gameStarted = false;
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
