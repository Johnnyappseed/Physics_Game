package ;

import box2D.dynamics.B2Body;
import flash.display.Sprite;

/**
 * ...
 * @author Tara
 * @author John
 */
class Game_Canvas extends Sprite
{
	public var catapult:Launcher;
	public var rock:Projectile;
	public var ground:B2Body;

	public function new() 
	{
		super();
		
		catapult = new Launcher(400, 240, 50);
		this.addChild(catapult);
		
		rock = new Projectile(100, 240);
		this.addChild(rock);
		
		ground = Main.game.createBox(400, 480, 800, 10, false);
	}
	
}