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
	public var topTopBlock:Castle_Block;
	public var leftTopBlock:Castle_Block;
	public var rightTopBlock:Castle_Block;
	
	public var firstEnemy:EvilGuy;
	public var firstTopEnemy:EvilGuy;
	
	//lists
	public var castleBlocks:List<Castle_Block>;
	public var enemies:List<EvilGuy>;
	public var deadEnemies:List<EvilGuy>;
	
	public var avgX:Float;
	
	public function new() 
	{
		super();
		var refX:Int = 2000;
		var refY:Int = 475;
		castleBlocks = new List<Castle_Block>();
		enemies = new List<EvilGuy>();
		deadEnemies = new List<EvilGuy>();
		
		leftBlock = new Castle_Block(refX+15, refY-120, 3, true);
		castleBlocks.add(leftBlock);
		this.addChild(leftBlock);
		
		rightBlock = new Castle_Block(refX+120, refY-255, 3, false);
		castleBlocks.add(rightBlock);
		this.addChild(rightBlock);
		
		firstEnemy = new EvilGuy(refX + 120, refY - 20, 1);
		enemies.add(firstEnemy);
		this.addChild(firstEnemy);
		
		topBlock = new Castle_Block(refX+225, refY-120, 3, true);
		castleBlocks.add(topBlock);
		this.addChild(topBlock);
		
		//      
		
		leftTopBlock = new Castle_Block(refX+15, refY-120-240-20, 3, true);
		castleBlocks.add(leftTopBlock);
		this.addChild(leftTopBlock);
		
		rightTopBlock = new Castle_Block(refX+120, refY-255-240-20, 3, false);
		castleBlocks.add(rightTopBlock);
		this.addChild(rightTopBlock);
		
		firstTopEnemy = new EvilGuy(refX + 120, refY -240-20-30, 1);
		enemies.add(firstTopEnemy);
		this.addChild(firstTopEnemy);
		
		topTopBlock = new Castle_Block(refX+225, refY-120-240-20, 3, true);
		castleBlocks.add(topTopBlock);
		this.addChild(topTopBlock);
		
		var xx:Float = 0.0;
		var lengthh:Float = 0.0;
		for (b in castleBlocks) 
		{
			xx += b.x;
			lengthh++;
		}
		for (c in enemies) 
		{
			xx += (c.x);
			lengthh++;
		}
		avgX = xx / lengthh;
	}
	
	public function act()
	{
		var x:Float = 0;
		var lengthh:Int = 0;
		for (b in castleBlocks) 
		{
			b.act();
			x += b.x;
			lengthh++;
		}
		for (c in enemies) 
		{
			c.act();
			if (c.block.getAngle() > 0.0272664625997165 || c.block.getAngle() < -0.0272664625997165)
			{
				c.iHaveBeenHitJimmyAndItBurnsLikeTheDickens();
				deadEnemies.add(c);
				enemies.remove(c);
			}
			x += c.x;
			lengthh++;
		}
		for (d in deadEnemies)
		{
			d.act();
		}
		avgX = x / lengthh;
	}
	public function destroy()
	{
		for (b in castleBlocks) 
		{
			Main.World.destroyBody(b.block);
			this.removeChild(b);
		}
		for (c in enemies) 
		{
			Main.World.destroyBody(c.block);
			this.removeChild(c);
		}
		for (d in deadEnemies) 
		{
			Main.World.destroyBody(d.block);
			this.removeChild(d);
		}
	}
	
}