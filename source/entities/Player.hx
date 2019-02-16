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
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		drag.x = SPEED * 3.2;
		drag.y = JUMP * -5;
		acceleration.y = JUMP * -2;
	}
	
	override public function update(elapsed:Float){
		updateMove(elapsed);
		super.update(elapsed);
	}
	
	function updateMove(elapsed){
		facing = FlxObject.RIGHT;
		
		var _right:Bool = k.anyPressed([RIGHT, D]);
		var _left:Bool = k.anyPressed([LEFT, A]);
		var _jump:Bool = k.anyPressed([UP, Z]);
		
		var lastPressed:String = null;
		
		var va:Float = 0;
		
		if (_left && _right){
			
		}
		
		if(_left || _right){
			if (_left){
				lastPressed = "left";
				facing = FlxObject.LEFT;
				va = 180;
				velocity.x = -SPEED;
			}
		
			if (_right){
				lastPressed = "right";
				facing = FlxObject.RIGHT;
				va = 0;
				velocity.x = SPEED;
			}
		}
		
		var jumpTmr:Float = 0; 
			
		if (_jump){
			if (isTouching(0x1000)){
				acceleration.y = 0;	
				velocity.y = JUMP;
				jumpTmr += FlxG.elapsed;
				FlxG.log.add(jumpTmr);
			}
			
			if (jumpTmr >= 0.5){
				acceleration.y = JUMP * -2;
				FlxG.log.add(jumpTmr);
				jumpTmr = 0;
			}
		} else {
			acceleration.y = JUMP * -2;
			jumpTmr = 0;
		}
	}
}