package entities;

import org.flixel.FlxSprite;

/**
 * ...
 * @author adrien
 */
class Crate extends FlxSprite
{
	
	public function new (pX: Int, pY: Int) 
	{	
		super(pX, pY, "gfx/crate.png");
		height = height - 1;
		acceleration.y = 400;
		drag.x = 200;
	}		

}
