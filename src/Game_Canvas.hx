package ;

import box2D.dynamics.B2Body;
import flash.display.Sprite;
import openfl.Assets;
import flash.Lib;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.KeyboardEvent;

/**
 * ...
 * @author Tara
 * @author John
 */
class Game_Canvas extends Sprite
{
	public static var game_Canvas;
	
	//projectiles
	public var catapult:Launcher;
	public var grass:B2Body;
	public var rock:Projectile;
	
	//castle blocks
	public var topBlock:Castle_Block;
	public var leftBlock:Castle_Block;
	public var rightBlock:Castle_Block;
	
	//lists
	public var castleBlocks:List<Castle_Block>;
	var keys:Array<Int>;

	public function new() 
	{
		super();
		keys = new Array<Int>();
		game_Canvas = this;
		
		//initialize things
		castleBlocks = new List<Castle_Block>();
		
		//create projectiles
		rock = new Projectile(400 - 141 + (13 * 10) + 10, 300+141);
		this.addChild(rock);
		
		//create catapult
		catapult = new Launcher(400, 300);
		this.addChild(catapult);
		
		//create grass
		grass = Main.game.createBox(600, 480, 2000, 7, false, 1.0);
		
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
		
		//create castle blocks!
		leftBlock = new Castle_Block(550, 300, 2, false);
		castleBlocks.add(leftBlock);
		this.addChild(leftBlock);
		rightBlock = new Castle_Block(520, 400, 1, true);
		castleBlocks.add(rightBlock);
		this.addChild(rightBlock);
		topBlock = new Castle_Block(580, 400, 1, true);
		castleBlocks.add(topBlock);
		this.addChild(topBlock);
	}
	
	public function keyDown(e:KeyboardEvent):Void
	{
		if (! keyCheck(e.keyCode)) keys.push(e.keyCode);
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