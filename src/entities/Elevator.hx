package entities;

import org.flixel.FlxSprite;

/**
 * ...
 * @author adrien
 */
class Elevator extends FlxSprite 
{

	private var _y : Float;
	private var _height : Float;
	
	public function new (pX: Int, pY:Int, pHeight: Int) 
	{
		super(pX, pY, "gfx/elevator.png");
		width = 48;
		_y = pY;
		_height = pHeight;
		immovable = true;
		velocity.y = 40;
	}		

	override public function update():Void
	{
		//Update the elevator's motion
		super.update();
			
		//Turn around if necessary
		if(y > _y + _height)
		{
			y = _y + _height;
			velocity.y = -velocity.y;
		}
		else if(y < _y)
		{
			y = _y; 
			velocity.y = -velocity.y;
		}
	}

}
