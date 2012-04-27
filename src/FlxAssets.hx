package ;
import nme.display.Bitmap;
import nme.media.Sound;
import nme.Assets;

/**
 * ...
 * @author Adrien
 */

class FlxAssets 
{

	public static var imgGibs:Class<Bitmap> = ImgGibs;
	public static var imgCursor:Class<Bitmap> = ImgCursor;
	
}

class ImgGibs extends Bitmap
{
	public function new() { super(Assets.getBitmapData("gfx/gibs.png")); }
}

class ImgCursor extends Bitmap
{
	public function new() { super(Assets.getBitmapData("gfx/cursor.png")); }
}