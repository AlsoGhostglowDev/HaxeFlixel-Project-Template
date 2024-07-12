package backend;

import flixel.FlxCamera;
import objects.Transition;

class BaseState extends FlxUIState {
    public static var instance:BaseState;
    public var exitFunc:Void->Void = () -> BaseState.instance.switchState(new states.PlayState());

    public var transCam:FlxCamera;
    public var canSwitchState:Bool = false;
    public var transitioning:Bool = true;
    public var canPause:Bool = true;

    public function new() {
        super();

		instance = this;

        transCam = new FlxCamera();
        transCam.bgColor.alpha = 0;
        FlxG.cameras.add(transCam, false);

		var transition = new Transition(false, () -> {
			canSwitchState = true;
			transitioning = false; 
        });
		transition.camera = transCam;
		add(transition);
    }

    override function update(elapsed:Float) {
        if (canPause && Preferences.keyPressed('exit', true))
            openSubState(new substates.PauseSubstate());

        super.update(elapsed);
    }

    public function switchState(nextState:BaseState) {
		var transition = new Transition(true);
        canSwitchState = false;
		transitioning = true;
        
		transition.camera = transCam;
		add(transition);
    }
}