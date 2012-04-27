package;

import nme.Lib;
import org.flixel.FlxGame;
	
class Game extends FlxGame
{
	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		var ratioX:Float = stageWidth / 320;
		var ratioY:Float = stageHeight / 240;
		var ratio:Float = Math.min(ratioX, ratioY);
		
		super(Math.floor(stageWidth / ratio), Math.floor(stageHeight / ratio), GameState, ratio, 60, 60);
		
		forceDebugger = true;
	}
	
}
