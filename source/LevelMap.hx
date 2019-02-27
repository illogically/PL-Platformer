package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.editors.tiled.TiledLayer;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledMap.FlxTiledMapAsset;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledTileSet;
import flixel.addons.tile.FlxTilemapExt;
import flixel.group.FlxGroup;
import haxe.io.Path;

/**
 * ...
 * @author ...
 */
class LevelMap extends TiledMap 
{

	public var platforms(default, null):TiledLayer;
	inline static var c_PATH_LEVEL_TILESHEETS = "assets/images/tilesets/";
	
	public var foregroundTiles:FlxGroup;
	public var objectsLayer:FlxGroup;
	
	public function new(data:FlxTiledMapAsset, state:PlayState) 
	{
		foregroundTiles = new FlxGroup();
		objectsLayer = new FlxGroup();
		
		super(data);
		FlxG.camera.setScrollBoundsRect(0, 0, fullWidth, fullWidth, true);
		
		for (layer in layers){
			var tileLayer:TiledTileLayer = cast layer;
			
			var tileSheetName:String = tileLayer.properties.get("tilesheet");
			
			
			
			if (tileSheetName == null){
				throw "tilesheet property not found or defined for tile layer" + tileLayer.name;
			}
			
			var tileSet:TiledTileSet = null;
			
			for (ts in tilesets){
				if (ts.name == tileSheetName){
					tileSet = ts;
					break;
				}
			}
			
			var imagePath = new Path(tileSet.imageSource);
			var processedPath = c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;
			FlxG.log.add(processedPath);
			
			var tilemap = new FlxTilemapExt();
			tilemap.loadMapFromArray(tileLayer.tileArray, width, height, processedPath,
										tileSet.tileWidth, tileSet.tileHeight, OFF, tileSet.firstGID, 1, 1);
			
			foregroundTiles.add(tilemap);
		}
		
	}
	
	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool{
		if (FlxG.overlap(foregroundTiles, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate))
			{
				return true;
			}
		return false;
	}
	
}