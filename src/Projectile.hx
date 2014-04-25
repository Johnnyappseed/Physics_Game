package;
import box2D.dynamics.B2Body;
import flash.display.Sprite;
import flash.display.Bitmap;
import openfl.Assets;
import box2D.collision.shapes.B2CircleShape;
import Math;
import flash.text.TextField;
import flash.text.TextFormat;

/**
 * ...
 * @author Tara Moses
 */
class Projectile extends Sprite 
{
	var sprite:Sprite;
	var circle:B2Body;
	
	//text stuff
	var textField:TextField;
	var textFormat:TextFormat;
	
	public function new(x:Int, y:Int) 
	{
		super();
		
		//create dynamic circle
		circle = Main.game.createCircle(x, y, 12, true);
		
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
		
		//add whimsical words to rock
		textField = new TextField();
		textFormat = new TextFormat();
		
		textFormat.font = "Comic Sans MS";
		textFormat.size = 15;
		textFormat.color = 0xFF0000;
		
		textField.text = 'kill me';
		textField.setTextFormat(textFormat);
		sprite.addChild(textField);
		
		textField.x = 4;
		textField.y = -14;
	}
	
	public function act()
	{
		this.x = circle.getPosition().x / Main.PHYSICS_SCALE;
		this.y = circle.getPosition().y / Main.PHYSICS_SCALE;
		this.rotation = circle.getAngle() * 180.0 / Math.PI;
	}
	
}