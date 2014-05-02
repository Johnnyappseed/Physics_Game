package;
import box2D.dynamics.B2Body;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import box2D.collision.shapes.B2CircleShape;

/**
 * ...
 * @author Tara Moses
 */
class Castle_Block extends Sprite 
{
	public var sprite:Sprite;
	public var block:B2Body;
	var blockIconName:String;
	var h:Int;
	var w:Int;
	
	public function new(x:Int, y:Int, size:Int, isVertical:Bool) 
	{
		super();
		
		if (size == 1) blockIconName = "small";
		else if (size == 2) blockIconName = "med";
		else blockIconName = "large";
		
		//create dynamic block
		if (isVertical) {
			w = 30;
			blockIconName += "VerticalBlockIcon.png";
			if (size == 1) h = 4 * w;
			else if (size == 2) h = 6 * w;
			else h = 8 * w;
		}
		else {
			h = 30;
			blockIconName += "HorizontalBlockIcon.png";
			if (size == 1) w = 4 * h;
			else if (size == 2) w = 6 * h;
			else w = 8 * h;
		}
		
		block = Main.game.createBox(x, y, w, h, true, 1);
		
		//create sprite
		var blockIcon = new Bitmap(Assets.getBitmapData("img/"+blockIconName));
		sprite = new Sprite();
		sprite.addChild(blockIcon);
		sprite.x = -blockIcon.width / 2;
		sprite.y = -blockIcon.height / 2;
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