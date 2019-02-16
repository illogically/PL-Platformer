package;

import entities.Player;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.util.FlxColor in Color;

class PlayState extends FlxState
{

	var player:Player;
	var platforms:FlxTypedGroup<FlxSprite>;
	var scrPerX:Float;
	var scrPerY:Float;

	override public function create():Void
	{
		super.create();
		FlxG.worldBounds.set(0, 0, 100000, 9999);
		player = new Player(FlxG.width / 2, FlxG.height / 2);
		platforms = new FlxTypedGroup<FlxSprite>();
		scrPerX = FlxG.width / 100;
		scrPerY = FlxG.height / 100;
		initTPlatforms();
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER, 1);
		FlxG.camera.maxScrollY = FlxG.height;
		
		add(player);
		add(platforms);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(player, platforms);
		FlxG.watch.add(player, "x");
		FlxG.watch.add(player, "y");
	}

	function initTPlatforms()
	{
		var sqr1:FlxSprite = new FlxSprite(0, scrPerY * 60, FlxGraphic.fromRectangle(600, 50, Color.GREEN, false));
		var sqr2:FlxSprite = new FlxSprite(650, scrPerY * 60, FlxGraphic.fromRectangle(600, 50, Color.BLUE, false));
		var sqr3:FlxSprite = new FlxSprite(1300, scrPerY * 60, FlxGraphic.fromRectangle(600, 50, Color.BLUE, false));
		platforms.add(sqr1);
		platforms.add(sqr2);
		platforms.add(sqr3);
		for (platform in platforms){
			platform.immovable = true;
		}
	}
} 
