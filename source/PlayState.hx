package;

import entities.Player;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor in Color;

class PlayState extends FlxState
{

	var player:Player;
	var platforms:FlxTypedGroup<FlxSprite>;
	var scrPerX:Float;
	var scrPerY:Float;
	var _map:LevelMap;

	override public function create():Void
	{
		super.create();
		player = new Player(50, 60);
		//platforms = new FlxTypedGroup<FlxSprite>();
		scrPerX = FlxG.width / 100;
		scrPerY = FlxG.height / 100;
		
		_map = new LevelMap(AssetPaths.test_2__tmx, this);
		
		
		
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER, 1);
		//FlxG.camera.maxScrollY = FlxG.height;
		
		//add(platforms);
		add(_map.foregroundTiles);
		add(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		_map.collideWithLevel(player);
		FlxG.watch.add(player, "x");
		FlxG.watch.add(player, "y");
	}

	function initTPlatforms()
	{
		var sqr1:FlxSprite = new FlxSprite(0, scrPerY * 60, FlxGraphic.fromRectangle(600, 50, Color.GREEN, false));
		var sqr2:FlxSprite = new FlxSprite(600, scrPerY * 60, FlxGraphic.fromRectangle(600, 50, Color.BLUE, false));
		var sqr3:FlxSprite = new FlxSprite(1200, scrPerY * 60 - 50, FlxGraphic.fromRectangle(600, 100, Color.WHITE, false));
		var sqr4:FlxSprite = new FlxSprite(1800, scrPerY * 60 - 50, FlxGraphic.fromRectangle(600, 100, Color.PURPLE, false));
		var sqr5:FlxSprite = new FlxSprite(2100, scrPerY * 60 - 100, FlxGraphic.fromRectangle(600, 150, Color.RED, false));
		var sqr6:FlxSprite = new FlxSprite(-600, scrPerY * 60, FlxGraphic.fromRectangle(600, 50, Color.YELLOW, false));
		var sqr7:FlxSprite = new FlxSprite(-1200, scrPerY * 60, FlxGraphic.fromRectangle(600, 50, Color.CYAN, false));
		platforms.add(sqr1);
		platforms.add(sqr2);
		platforms.add(sqr3);
		platforms.add(sqr4);
		platforms.add(sqr5);
		platforms.add(sqr6);
		platforms.add(sqr7);
		for (platform in platforms){
			platform.immovable = true;
		}
	}
} 
