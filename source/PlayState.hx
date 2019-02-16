package;

import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.system.debug.watch.Tracker.TrackerProfile;
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
		player = new Player(FlxG.width / 2, FlxG.height / 2);
		platforms = new FlxTypedGroup<FlxSprite>();
		scrPerX = FlxG.width / 100;
		scrPerY = FlxG.height / 100;
		initTPlatforms();
		add(player);
		add(platforms);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(player, platforms);
	}
	
	function initTPlatforms(){
		var sqr1:FlxSprite = new FlxSprite(0, scrPerY * 60, FlxGraphic.fromRectangle(600, 50, Color.GREEN, false));
		sqr1.immovable = true;
		platforms.add(sqr1);
	}
}
