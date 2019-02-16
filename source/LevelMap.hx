package;

import flixel.FlxG;
import flixel.addons.editors.tiled.TiledLayer;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledMap.FlxTiledMapAsset;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.tile.FlxTile;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author ...
 */
class LevelMap extends TiledMap 
{

	public var platforms(default,null):TiledLayer;
	
	public function new(data:FlxTiledMapAsset, state:PlayState) 
	{
		super(data)
		FlxG.camera.setScrollBoundsRect(0, 0, fullWidth, fullWidth, true);
		
		for (layer in layers){
			var tileLayer:FlxTilemap = cast layer;
			
			var tileSet:TiledTileSet = null;
		}
	}
	
}