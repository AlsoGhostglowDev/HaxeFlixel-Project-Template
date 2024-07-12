package backend;

@:structInit class PreferenceVars {
    public var antialiasingGlobal:Bool = true; 
    public var flashingLights:Bool = true;
    public var framerate:Int = 60;
	public var difficulty:String = "normal";

    public var keyBinds:Map<String, Array<flixel.input.keyboard.FlxKey>> = [
        "exit" => [ESCAPE],
		"up"   => [W],
		"down" => [S]
    ];
}

class Preferences {
    public static var prefs:PreferenceVars = {};
	public static var defaultPrefs:PreferenceVars = {};

    static public function savePrefs() {
		for (key in Reflect.fields(prefs))
			Reflect.setField(FlxG.save.data, key, Reflect.field(prefs, key));

		FlxG.save.flush();
    }

    static public function loadPrefs() {
		FlxG.save.bind('spelligans', "SpellingShenanigans");
		
		for (key in Reflect.fields(prefs))
			if (Reflect.hasField(FlxG.save.data, key))
				Reflect.setField(prefs, key, Reflect.field(FlxG.save.data, key));
    }

    public static function resetPrefs() {
        prefs = defaultPrefs;
    }

	public static function keyPressed(key:String, ?justPressed:Bool = false):Bool {
		function mapContains(map:Map<Dynamic, Dynamic>, key:Dynamic):Bool {
            for (k in map.keys()) {
                if (k == key) return true;
            }
            return false;
        }

        if (mapContains(prefs.keyBinds, key)) {
			final checkFunc = justPressed ? FlxG.keys.anyJustPressed : FlxG.keys.anyPressed;
            return checkFunc(prefs.keyBinds.get(key));
        }
        return false;
	}
}