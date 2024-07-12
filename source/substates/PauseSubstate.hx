package substates;

class PauseSubstate extends BaseSubstate {
    override function update(elapsed:Float) {
        super.update(elapsed);
        
        if (Preferences.keyPressed('exit', true)) {
            close();
        }
    }
}