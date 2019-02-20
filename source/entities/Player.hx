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
	var SPEED:Float = 500;
	var JUMP:Float = -600;
	var GRAVITY:Float;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		GRAVITY = JUMP * -3;
		
		drag.y = JUMP * -5;
		acceleration.y = GRAVITY;
		maxVelocity.x = 350;
	}
	
	override public function update(elapsed:Float){	
		updateMove(elapsed);
		super.update(elapsed);
	}
	
	var jumpTmr:Float = 0;
	var jumpNum:Int = 0;
	
	function updateMove(elapsed){
		var _right:Bool = k.anyPressed([RIGHT, D]);
		var _left:Bool = k.anyPressed([LEFT, A]);
		var _jump:Bool = k.anyPressed([UP, Z]);
		
		FlxG.debugger.addTrackerProfile(new TrackerProfile(Player, ["acceleration","velocity"]));
		FlxG.debugger.track(this, "Hero");
		
		
		if(_right || _left){
			if (_left && !_right){
				if (velocity.x > 225){
					drag.x = SPEED * 20;
					acceleration.x = 0;
				} else {
					acceleration.x = -SPEED;
				}
			}
			if (_right && !_left){
				if (velocity.x < -225){
					drag.x = SPEED * 20;
					acceleration.x = 0;
				} else {
					acceleration.x = SPEED;
				}
			}
		} else {
			acceleration.x = 0;
			if (isTouching(0x1000)){
				drag.x = SPEED * 10;
			} else {
				drag.x = SPEED * 3;
			}
		}
		
		if (_jump){
			jumpTmr += elapsed;
			if (isTouching(0x1000) && jumpTmr <= 0.02){
				velocity.y = JUMP;
				jumpNum++;
				FlxG.log.add(jumpNum);
			} else if (jumpTmr >= 0.25){
				acceleration.y = GRAVITY;
				FlxG.log.add(jumpNum);
			}
		} else {
			acceleration.y = GRAVITY;
			jumpTmr = 0;
			jumpNum = 0;
		}
	}
}