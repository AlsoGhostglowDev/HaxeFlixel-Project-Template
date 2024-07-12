package backend;

import flixel.graphics.frames.FlxFrame.FlxFrameAngle;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxRect;

import openfl.display.BitmapData;
import openfl.display3D.textures.RectangleTexture;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;
import openfl.system.System;
import openfl.geom.Rectangle;

import lime.utils.Assets;
import flash.media.Sound;

import haxe.Json;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;
	inline public static var VIDEO_EXT = "mp4";

	static function returnSound(?library:String = 'sounds', key:String) return 'assets/$library/$key.$SOUND_EXT';

	inline static public function xml(key:String, ?library:String = 'images') 
        return 'assets/$library/$key.xml';

	inline static public function json(key:String) 
        return 'assets/data/$key.json';

	inline static public function video(key:String) 
        return 'assets/videos/$key.$VIDEO_EXT';

	inline static public function sound(key:String) 
        return returnSound('sounds', key);
	
    inline static public function soundRandom(key:String, min:Int, max:Int) 
        return sound(key + FlxG.random.int(min, max));
	
    inline static public function music(key:String) 
        return returnSound('music', key);

	public static var currentTrackedAssets:Map<String, FlxGraphic> = [];
	static public function image(key:String, ?library:String = null):FlxGraphic
	{
		var bitmap:BitmapData = null;
		var file:String = null;

		if (currentTrackedAssets.exists(file)) {
			return currentTrackedAssets.get(file);
		}
		else if (FileSystem.exists(file))
			bitmap = BitmapData.fromFile(file);
		else

		if (bitmap != null)
		{
			var retVal = cacheBitmap(file, bitmap);
			if(retVal != null) return retVal;
		}

		trace('oh no its returning null NOOOO ($file)');
		return null;
	}

	static public function cacheBitmap(file:String, ?bitmap:BitmapData = null)
	{
		if(bitmap == null)
		{
			if (OpenFlAssets.exists(file, IMAGE))
				bitmap = OpenFlAssets.getBitmapData(file);

			if(bitmap == null) return null;
		}

		var newGraphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, file);
		newGraphic.persist = true;
		newGraphic.destroyOnNoUse = false;
		currentTrackedAssets.set(file, newGraphic);
		return newGraphic;
	}

	inline static public function font(key:String) return 'assets/fonts/$key';

	inline static public function getSparrowAtlas(key:String, ?library:String = null):FlxAtlasFrames {
		var imageLoaded:FlxGraphic = image(key, library);
		return FlxAtlasFrames.fromSparrow(imageLoaded, xml(key, library));
	}
}