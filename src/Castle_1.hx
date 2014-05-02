package ;

import box2D.dynamics.B2Body;
import flash.display.Sprite;
import openfl.Assets;
import flash.Lib;
import flash.display.Bitmap;
import flash.events.Event;
import flash.events.KeyboardEvent;
import motion.Actuate;

/**
 * ...
 * @author Tara
 * @author John
 */
class Castle_1 extends Sprite
{
	
	//castle blocks
	public var topBlock:Castle_Block;
	public var leftBlock:Castle_Block;
	public var rightBlock:Castle_Block;
	
	//lists
	public var castleBlocks:List<Castle_Block>;
	
	

	public function new() 
	{
		super();
		var refX:Int = 2000;
		var refY:Int = 470;
		castleBlocks = new List<Castle_Block>();
		
		leftBlock = new Castle_Block(refX+15, refY-120, 3, true);
		castleBlocks.add(leftBlock);
		this.addChild(leftBlock);
		rightBlock = new Castle_Block(refX+120, refY-255, 3, false);
		castleBlocks.add(rightBlock);
		this.addChild(rightBlock);
		topBlock = new Castle_Block(refX+225, refY-120, 3, true);
		castleBlocks.add(topBlock);
		this.addChild(topBlock);
	}
	
}