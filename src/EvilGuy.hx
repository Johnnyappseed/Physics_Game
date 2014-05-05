package;
import box2D.dynamics.B2Body;
import flash.display.Sprite;
import openfl.Assets;
import flash.display.Bitmap;

/**
 * ...
 * @author Tara Moses
 */
class EvilGuy extends Sprite 
{
	public var block:B2Body;
	var evilGuyIconName:String;
	var sprite:Sprite;
	var h:Int;
	var w:Int;
	
	public function new(x:Int, y:Int, type:Int) 
	{
		super();
		
		w = 30;
		h = 30;
		if (type == 1) evilGuyIconName = "aliveEvilGuyIcon.png";
		else evilGuyIconName = "deadEvilGuyIcon.png";
		
		block = Main.game.createBox(x, y, w, h, true, 1.0);
		
		//create sprite
		var evilGuyIcon = new Bitmap(Assets.getBitmapData("img/"+evilGuyIconName));
		sprite = new Sprite();
		sprite.addChild(evilGuyIcon);
		sprite.x = -evilGuyIcon.width / 2;
		sprite.y = -evilGuyIcon.height / 2;
		this.addChild(sprite);
		
		//put sprite on screen
		this.x = x;
		this.y = y;
	}
	
	public function act()
	{
		this.x = block.getPosition().x / Main.PHYSICS_SCALE;
		this.y = block.getPosition().y / Main.PHYSICS_SCALE;
		this.rotation = block.getAngle() * 180.0 / Math.PI;
	}
	
}