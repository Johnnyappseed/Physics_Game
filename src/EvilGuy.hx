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
	var evilGuyIcon:Bitmap;
	var sprite:Sprite;
	var h:Int;
	var w:Int;
	
	public function new(x:Int, y:Int, type:Int) 
	{
		super();
		
		if (type == 1) evilGuyIconName = "aliveEvilGuyIcon.png";
		else evilGuyIconName = "deadEvilGuyIcon.png";
		
		block = Main.game.createCircle(x, y, 20, true, 1);
		
		//create sprite
		evilGuyIcon = new Bitmap(Assets.getBitmapData("img/" + evilGuyIconName));
		evilGuyIcon.width = 40;
		evilGuyIcon.height = 40;
		sprite = new Sprite();
		sprite.addChild(evilGuyIcon);
		sprite.x = -evilGuyIcon.width / 2;
		sprite.y = -evilGuyIcon.height / 2;
		this.addChild(sprite);
		
		//put sprite on screen
		this.x = x;
		this.y = y;
	}
	
	public function iHaveBeenHitJimmyAndItBurnsLikeTheDickens()
	{
		evilGuyIconName = "deadEvilGuyIcon.png";
		sprite.addChild(evilGuyIcon);
		evilGuyIcon = new Bitmap(Assets.getBitmapData("img/" + evilGuyIconName));
		evilGuyIcon.width = 40;
		evilGuyIcon.height = 40;
		sprite.addChild(evilGuyIcon);
		
	}
	
	public function act()
	{
		this.x = block.getPosition().x / Main.PHYSICS_SCALE;
		this.y = block.getPosition().y / Main.PHYSICS_SCALE;
		this.rotation = block.getAngle() * 180.0 / Math.PI;
	}
	
}