package entities;

import flixel.FlxG.keys in k;
import flixel.FlxSprite;
import flixel.*;
import flixel.math.*;
import flixel.system.debug.watch.Tracker.TrackerProfile;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite 
{
	var SPEED:Float = 200;
	var JUMP:Float = -600;
	var GRAVITY:Float;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		GRAVITY = JUMP * -3;
		
		drag.y = JUMP * -5;
		acceleration.y = GRAVITY;
		maxVelocity.x = 600;
	}
	
	override public function update(elapsed:Float){	
		updateMove(elapsed);
		super.update(elapsed);
	}
	
	var jumpTmr:Float = 0;
	
	function updateMove(elapsed){
		var _right:Bool = k.anyPressed([RIGHT, D]);
		var _left:Bool = k.anyPressed([LEFT, A]);
		var _jump:Bool = k.anyPressed([UP, Z]);
		
		FlxG.debugger.addTrackerProfile(new TrackerProfile(Player, ["acceleration","velocity"]));
		FlxG.debugger.track(this, "Hero");
		
		
		if(_right || _left){
			if (_left && !_right){
				if (velocity.x > 0){
					drag.x = SPEED * 11;
				} else {
					acceleration.x = -SPEED;
				}
			}
			if (_right && !_left){
				if (velocity.x < 0){
					drag.x = SPEED * 11;
				} else {
					acceleration.x = SPEED;
				}
			}
		} else {
			acceleration.x = 0;
			if (isTouching(0x1000)){
				drag.x = SPEED * 9;
			} else {
				drag.x = SPEED * 8.5;
			}
		}
		
		if (_jump){
			jumpTmr += elapsed;
			if (isTouching(0x1000) && jumpTmr <= 0.02){
				acceleration.y = 0;
				velocity.y = JUMP;
			} else if (jumpTmr >= 0.02){
				acceleration.y = GRAVITY;
			}
		} else {
			acceleration.y = GRAVITY;
			jumpTmr = 0;
		}
	}
}