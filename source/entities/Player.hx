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
	var JUMP:Float = -350;
	var GRAVITY:Float;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		GRAVITY = JUMP * -5;
		
		drag.y = JUMP * -10;
		acceleration.y = GRAVITY;
		maxVelocity.x = 350;
		maxVelocity.y = 700;
	}
	
	override public function update(elapsed:Float){	
		updateMove(elapsed);
		if (k.anyJustPressed([R])){
			FlxG.log.clear();
		}
		super.update(elapsed);
	}
	
	var jumpTmr:Float = 0;
	var jumpState:Int = 0;
	
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
			if (isTouching(0x1000) && jumpState == 0){
				jumpState = 1;
				jumpTmr = 0;
				FlxG.log.add("Init Jump");
			}
			if (jumpTmr >= 2){
				jumpState = -1;
				FlxG.log.add("Jump Time Out");
			}
			if (jumpState == -1){
				FlxG.log.add("Jump End");
				acceleration.y = GRAVITY;
				if (isTouching(0x1000)){
					jumpTmr = 0;
				}
			}
			
			if (jumpState == 1 ){
				if (jumpTmr <= 0.3){
					velocity.y = JUMP;	
					FlxG.log.add("Small Jump");
				} else {
					drag.y = JUMP * -10 * jumpTmr;
					FlxG.log.add("Extended Jump");
				}
			}
			
		} else {
			jumpState = 0;
			acceleration.y = GRAVITY;
			jumpTmr = 0;
			jumpState = 0;
		}
	}
}