package;
import flash.display.Sprite;

/**
 * ...
 * @author Tara Moses
 */
class Castle_Block extends Sprite 
{
	public var sprite:Sprite;
	
	public function new(x:Int, y:Int, size:Int, isVertical:Bool) 
	{
		super();
		
		//create dynamic block
		if (isVertical) {
			w = 10;
			if (size == 1) h = 2 * w;
			else if (size == 2) h = 3 * w;
			else h = 4 * w;
		}
		else {
			h = 10;
			if (size == 1) w = 2 * h;
			else if (size == 2) w = 3 * h;
			else w = 4 * h;
		}
		
		block = Main.game.createBox(x, y, w, h, true, 1);
		
		//create sprite
		if (w < h) var blockIconName = "verticalBlockIcon.png";
		else var blockIconName = "horizontalBlockIcon.png";
		
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
	
}