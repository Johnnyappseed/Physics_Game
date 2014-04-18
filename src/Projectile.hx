package;
import flash.display.Sprite;
import flash.display.Bitmap;
import openfl.Assets;
import box2D.collision.shapes.B2CircleShape;

/**
 * ...
 * @author Tara Moses
 */
class Projectile extends Sprite 
{
	var sprite:Sprite;
	
	public function new(x:Int, y:Int) 
	{
		super();
		
		//create sprite
		var projectileIcon = new Bitmap(Assets.getBitmapData("img/projectileIcon.png"));
		sprite = new Sprite();
		sprite.addChild(projectileIcon);
		sprite.x = -projectileIcon.width / 2;
		sprite.y = -projectileIcon.height / 2;
		this.addChild(sprite);
		
		//put sprite on screen
		this.x = x;
		this.y = y;
	}
	
}