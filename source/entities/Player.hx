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
	var JUMP:Float = -300;
	var GRAVITY:Float;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		
		
		GRAVITY = JUMP * -3;
		
		drag.y = JUMP * -10;
		acceleration.y = GRAVITY;
		maxVelocity.x = 250;
		maxVelocity.y = 700;
	}
	
	override public function update(elapsed:Float){	
		updateMove(elapsed);
		
		super.update(elapsed);
	}
	
	var jumpTmr:Float = 0;
	var jumpState:Int = 0;
	var jumpBuffer:Float = 0;
	
	function updateMove(elapsed){
		var _right:Bool = k.anyPressed([RIGHT, D]);
		var _left:Bool = k.anyPressed([LEFT, A]);
		var _jump:Bool = k.anyPressed([UP, Z]);
		var _run:Bool = k.anyPressed([SHIFT]);
		
		FlxG.debugger.addTrackerProfile(new TrackerProfile(Player, ["acceleration","velocity"]));
		FlxG.debugger.track(this, "Hero");
		
		
		if (_right || _left){
			if (_run){
				SPEED = 400;
				maxVelocity.x = 450;
			} else {
				SPEED= 200;
				maxVelocity.x = 250;
			}
			if (_left && !_right){
				if (velocity.x > maxVelocity.x - 105){
					drag.x = SPEED * 40;
					acceleration.x = 0;
				} else {
					acceleration.x = -SPEED;
				}
			}
			if (_right && !_left){
				if (velocity.x < -maxVelocity.x + 105){
					drag.x = SPEED * 40;
					acceleration.x = 0;
				} else {
					acceleration.x = SPEED;
				}
			}
		} else {
			acceleration.x = 0;
			if (isTouching(0x1000)){
				drag.x = SPEED * 20;
			} else {
				drag.x = SPEED * 10;
			}
		}
		
		
		
		if (isTouching(0x1000)){
			jumpBuffer = 0;
		} else {
			jumpBuffer += elapsed;
		}
			
		if (_jump){
			jumpTmr += elapsed;
			if (jumpState == 0 && jumpBuffer <= 0.09){
				FlxG.log.add(jumpBuffer);
				jumpState = 1;
				jumpTmr = 0;
				FlxG.log.add("Init Jump");
			}
			if (jumpTmr >= 0.4){
				jumpState = -1;
				FlxG.log.add("Jump Time Out");
			}
			if (jumpState == -1){
				FlxG.log.add("Jump End");
				acceleration.y = GRAVITY;
				if (isTouching(0x1000)){
					jumpTmr = 0;
					jumpBuffer = 0;
				}
			}
			
			if (jumpState == 1 ){
				jumpBuffer = 0.33;
				if (jumpTmr <= 0.20){
					velocity.y = JUMP;	
				} else {
					drag.y = (JUMP * -2) * Math.abs(jumpTmr * 0.001);
				}
			}
			
		} else {
			drag.y = JUMP * -10;
			jumpState = 0;
			acceleration.y = GRAVITY;
			jumpTmr = 0;
			jumpState = 0;
		}
	}
}