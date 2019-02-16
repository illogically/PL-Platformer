package entities;

import flixel.FlxG.keys in k;
import flixel.FlxSprite;
import flixel.*;
import flixel.math.*;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite 
{
	var SPEED:Float = 200;
	var JUMP:Float = -400;
	var GRAVITY:Float;
	var lastPressed:String;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		GRAVITY = JUMP * -1.5;
		
		drag.x = SPEED * 3.2;
		drag.y = JUMP * -3;
		acceleration.y = GRAVITY;
	}
	
	override public function update(elapsed:Float){
		updateMove(elapsed);
		super.update(elapsed);
	}
	
	var jumpTmr:Float = 0;
	
	function updateMove(elapsed){
		facing = FlxObject.RIGHT;
		
		var _right:Bool = k.anyPressed([RIGHT, D]);
		var _left:Bool = k.anyPressed([LEFT, A]);
		var _jump:Bool = k.anyPressed([UP, Z]);
		
		var lastPressed:String = null;

		var va:Float = 0;
		
		FlxG.watch.add(this, "lastPressed", "Last Pressed");
		
		
		if(_left || _right){
			if (_left){
				lastPressed = "left";
				facing = FlxObject.LEFT;
				va = 180;
				velocity.x = -SPEED;
			} else if (_right){
				lastPressed = "right";
				facing = FlxObject.RIGHT;
				va = 0;
				velocity.x = SPEED;
			}
			if (_left && _right){
				switch lastPressed{
					case "right": velocity.x = -SPEED;
					case "left": velocity.x = SPEED;
				}
			}
		}
		
		if (_jump){
			jumpTmr += elapsed;
			if (isTouching(0x1000) && jumpTmr <= 0.033){
				acceleration.y = 0;
				velocity.y = JUMP;
			} else if (jumpTmr >= 0.5){
				acceleration.y = GRAVITY;
			}
		} else {
			acceleration.y = GRAVITY;
			jumpTmr = 0;
		}
	}
}