package backend;

class BaseSubstate extends FlxSubState {
	public var substateCam:flixel.FlxCamera;
	public var overlayBg:FlxSprite;
	public var canLeaveSubstate:Bool = true;

	public static var instance:BaseSubstate;

	override public function new()
	{
		super();

		substateCam = new flixel.FlxCamera();
		substateCam.bgColor = 0x0;
		FlxG.cameras.add(substateCam);

		overlayBg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		overlayBg.alpha = 0;
		add(overlayBg);
		FlxTween.tween(overlayBg, {alpha: 0.6}, 1, {ease: FlxEase.expoOut});
	}

	override public function openSubState(substate:flixel.FlxSubState) {
		super.openSubState(substate);
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.anyPressed(Preferences.prefs.keyBinds.get('exit')) && !canLeaveSubstate)
			close();

		super.update(elapsed);
		updatePost(elapsed);
	}

	public function updatePost(elapsed:Float) {};

	override public function destroy()
	{
		FlxG.cameras.remove(substateCam);
		if (_parentState.persistentUpdate) _parentState.persistentUpdate = false;

		if (FlxG.sound.music != null)
			FlxG.sound.music.fadeIn(0.6, FlxG.sound.music.volume, FlxG.sound.music.volume + 0.5);
	}
}