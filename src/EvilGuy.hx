package;
import flash.display.Sprite;

/**
 * ...
 * @author Tara Moses
 */
class EvilGuy extends Sprite 
{
	var evilGuyIconName:String;
	var sprite:Sprite;
	
	public function new(x:Int, y:Int, type:Int) 
	{
		if (type == 1) evilGuyIconName = "aliveEvilGuyIcon.png";
		else evilGuyIconName = "deadEvilGuyIcon.png";
		
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
		this.x = circle.getPosition().x / Main.PHYSICS_SCALE;
		this.y = circle.getPosition().y / Main.PHYSICS_SCALE;
		this.rotation = circle.getAngle() * 180.0 / Math.PI;
	}
	
}