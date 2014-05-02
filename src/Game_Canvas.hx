package ;

import box2D.dynamics.B2Body;
import flash.display.Sprite;
import openfl.Assets;
import flash.Lib;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.KeyboardEvent;
import motion.Actuate;

/**
 * ...
 * @author Tara
 * @author John
 */
class Game_Canvas extends Sprite
{
	
	//projectiles
	public var catapult:Launcher;
	public var grass:B2Body;
	
	//castle blocks
	public var topBlock:Castle_Block;
	public var leftBlock:Castle_Block;
	public var rightBlock:Castle_Block;
	
	//lists
	var keys:Array<Int>;
	
	public var lookingAtLauncher:Bool;
	public var launching:Bool;
	public var fired:Bool;
	
	public var ammoBelt:Array<Projectile>;
	public var ammo:Projectile;
	
	public var castle:Castle_1;
	
	public var gg:Bool;
	

	public function new() 
	{
		super();
		keys = new Array<Int>();
		lookingAtLauncher = false;
		launching = false;
		fired = false;
		gg = false;
		
		//initialize things
		ammoBelt = new Array();
		
		//create grass
		grass = Main.game.createBox(600, 480, 6000, 7, false, 1.0);
		
		//create sprite for grass
		var grassIcon = new Bitmap(Assets.getBitmapData("img/grassIcon.png"));
		var grassSprite = new Sprite();
		grassSprite.addChild(grassIcon);
		grassSprite.x = -grassIcon.width / 2;
		grassSprite.y = -grassIcon.height / 2;
		this.addChild(grassSprite);
		
		//put grass sprite on screen
		grassSprite.x = 0;
		grassSprite.y = 472;
	}
	
	public function destroyAmmo()
	{
		for (i in ammoBelt)
		{
			Main.World.destroyBody(i.circle);
			ammoBelt.remove(i);
			trace("aaa");
			this.removeChild(i);
			trace("aaaaa");
		}
	}
	
	public function keyDown(e:KeyboardEvent):Void
	{
		//if (! keyCheck(e.keyCode)) keys.push(e.keyCode);
		if (e.keyCode == 65)
		{
			gg = true;
		}
		if (e.keyCode==32)
		{
			if (lookingAtLauncher)
			{
				catapult.increaseTheVelocityOfOurProjectileSoThatItMayInduceTheMaximumAmountOfDamageOnOurOpponents();
				if (launching == true) 
				{
					catapult.firer();
					fired = true;
					lookingAtLauncher = false;
					launching = false;
				}
				else 
				{
					launching = true;
				}
			}
			else 
			{
				catapultReset();
				catapult = new Launcher(400, 300);
				this.addChild(catapult);
				fired = false;
				lookingAtLauncher = true;
				Actuate.tween(Main.game, 1, { x : 0, y : 0 } );
			}
		}
	}

	public function keyUp(e:KeyboardEvent):Void
	{
		keys.remove(e.keyCode);
	}

	public function keyCheck(v:Int):Bool
	{
		for (item in keys)
		{
			if (item == v) return true;
		}
		return false;
	}
	
	public function catapultReset()
	{
		catapult.destroy();
		this.removeChild(catapult);
	}
	
	public function creation()
	{
		catapult = new Launcher(400, 300);
		this.addChild(catapult);
		var a:Projectile = ammoBelt.pop();
		this.removeChild(a);
		Main.World.destroyBody(a.circle);
		castle = new Castle_1();
	}
	
	public function act()
	{
		for (a in ammoBelt) a.act();
		castle.act();
		if (castle.enemies.length == 0)
		{
			gg = true;
		}
	}
	
	public function disable()
	{
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
	}

	public function enable()
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
	}
}