package ;

import flash.display.Sprite;

/**
 * ...
 * @author tj
 */
class Game_Canvas extends Sprite
{
	var catapult:Launcher;

	public function new() 
	{
		super();
		
		catapult = new Launcher();
		this.addChild(catapult);
	}
	
}