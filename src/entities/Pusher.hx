package entities;

import org.flixel.FlxSprite;

/**
 * ...
 * @author adrien
 */
class Pusher extends FlxSprite 
{
	private var _x:Float;
	private var _width:Float;
	
	public function new (pX: Int, pY: Int, pWidth: Int) 
	{
		super(pX, pY, "gfx/pusher.png");
		_x = pX;				//The starting height
		_width = pWidth;		//How far over to travel
		immovable = true;		//We want the pusher to be "solid" and not shift during collisions
		velocity.x = 40;	//Basic pusher speed
	}		
	
	override public function update():Void
	{
		//Update the elevator's motion
		super.update();
		
		//Turn around if necessary
		if(x > _x + _width)
		{
			x = _x + _width;
			velocity.x = -velocity.x;
		}
		else if(x < _x)
		{
			x = _x;
			velocity.x = -velocity.x;
		}
	}

}
