package ;

import box2D.dynamics.B2Body;
import flash.display.Sprite;
import openfl.Assets;
import flash.display.Bitmap;

/**
 * ...
 * @author Tara
 * @author John
 */
class Game_Canvas extends Sprite
{
	public var catapult:Launcher;
	public var rock:Projectile;
	public var grass:B2Body;

	public function new() 
	{
		super();
		
		catapult = new Launcher(400, 240, 50);
		this.addChild(catapult);
		
		rock = new Projectile(100, 240);
		this.addChild(rock);
		
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
	}
	
}