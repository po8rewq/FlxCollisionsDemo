package ;

import org.flixel.FlxState;
import org.flixel.FlxG;
import org.flixel.FlxButton;
import org.flixel.FlxTilemap;
import org.flixel.FlxSprite;

import org.flixel.tmx.TmxMap;
import org.flixel.tmx.TmxObjectGroup;
import org.flixel.tmx.TmxObject;
import org.flixel.FlxEmitter;
import org.flixel.FlxGroup;
import org.flixel.FlxText;

import entities.Player;
import entities.Elevator;
import entities.Pusher;
import entities.Crate;

/**
 * ...
 * @author adrien
 */
class GameState extends FlxState 
{
	private var _player  : FlxSprite;
	private var _tilemap : FlxTilemap;
	private var _dispenser : FlxEmitter;
	
	private var _crates : FlxGroup;
	
	private var _qte : Int;
	
	// touch interface
	public static var leftButton:FlxButton;
	public static var rightButton:FlxButton;
	public static var jumpButton:FlxButton;
	
	override public function create():Void
	{
		#if !neko
		FlxG.bgColor = 0xffacbcd7;
		#else
		FlxG.bgColor = {rgb: 0xacbcd7, a: 0xff};
		#end
		
		var decoration:FlxSprite = new FlxSprite(256,159, "gfx/bg.png");
		//decoration.loadGraphic("gfx/bg.png", false, false, 256, 159, false);
		decoration.moves = false;
		decoration.solid = false;
		add(decoration);
		add(new FlxText(32,36,96,"collision").setFormat(null,16,0x778ea1,"center"));
		add(new FlxText(32,60,96,"DEMO").setFormat(null,24,0x778ea1,"center"));
		
		_crates = new FlxGroup();
		add(_crates);
		
		//add( new FlxButton(10, 10, 'Hello World', click) );
		
		var tmx : TmxMap = new TmxMap( nme.Assets.getText('levels/map01.tmx') );
		
		//create the flixel implementation of the objects specified in the ObjectGroup 'objects'
		var group : TmxObjectGroup = tmx.getObjectGroup('objects');
		for(object in group.objects)
			spawnObject(object);
		
		// Basic level structure
		_tilemap = new FlxTilemap();
		
		// Generate a CSV from the layer 'map' with all the tiles from the TileSet 'tiles'
		var mapCsv:String = tmx.getLayer('map').toCsv( tmx.getTileSet('tiles') );
		
		_tilemap.loadMap(mapCsv, "gfx/tiles.png", 8, 8, FlxTilemap.OFF);
	//	_tilemap.follow();
		add(_tilemap);
		
		leftButton = new FlxButton(325, 10, 'left');
		add(leftButton);
		
		rightButton = new FlxButton(325, 35, 'right');
		add(rightButton);
		
		jumpButton = new FlxButton(325, 60, 'jump');
		add(jumpButton);
	}
	
	override public function update()
	{
	
		super.update();
		
		FlxG.collide();
		/*
		if( FlxG.mouse.pressed())
		{
			_dispenser.on = !_dispenser.on;
		}*/
	}
	
	private function spawnObject(obj:TmxObject):Void
	{
		//Add game objects based on the 'type' property
		switch(obj.type)
		{
			case "elevator":
				add(new Elevator(obj.x, obj.y, obj.height));
				return;
			case "pusher":
				add(new Pusher(obj.x, obj.y, obj.width));
				return;
			case "player":
				_player = new Player(obj.x,obj.y);
				add(_player);
			case "crate":
				_crates.add(new Crate(obj.x,obj.y));
				return;
		}
		
		//This is the thing that spews nuts and bolts
		if(obj.type == "dispenser")
		{
			_dispenser = new FlxEmitter(obj.x,obj.y);
			_dispenser.setSize(obj.width,obj.height);
			
			_dispenser.setXSpeed( Std.parseInt(obj.custom.resolve('minvx')), Std.parseInt(obj.custom.resolve('maxvx')) );
			_dispenser.setYSpeed( Std.parseInt(obj.custom.resolve('minvy')), Std.parseInt(obj.custom.resolve('maxvy')) );
			
			_dispenser.gravity = 350;
			_dispenser.bounce = 0.5;
			
			_qte = Std.parseInt(obj.custom.resolve('quantity'));
			
			_dispenser.makeParticles("gfx/gibs.png", 50, 16, true, 0.8);
			_dispenser.start(false, _qte );
			add(_dispenser);
		}
	}

}
