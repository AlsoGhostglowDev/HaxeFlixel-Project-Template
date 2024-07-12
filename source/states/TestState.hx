package states;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class TestState extends BaseState {
    public var grpRenders:FlxTypedSpriteGroup<Render>;
    
    var curSelected:Int = 0;

    override function create() {
		grpRenders = new FlxTypedSpriteGroup<Render>();
        add(grpRenders);

        for (i in 0...3) {
            makeRender();
        }
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.justPressed.LEFT) curSelected--;
		if (FlxG.keys.justPressed.RIGHT) curSelected++;

        if (curSelected < 0) curSelected = grpRenders.length-1;
		if (curSelected > grpRenders.length-1) curSelected = 0;

        var i = -1;
        grpRenders.forEach((render) -> {
            i++;
            render.selected = (curSelected == i);
        });
    }

    var iRender:Int = -1;
    function makeRender() {
        iRender++;

        var colList = [0xFFFF0000, 0xFFFFFF00, 0xFFFF00FF, 0xFF00FF00, 0xFF7BFFFF];
        var render = new Render(50 + (150 * iRender), 200, colList[FlxG.random.int(0, colList.length-1)]);
        grpRenders.add(render);
    }
}

class Render extends flixel.group.FlxSpriteGroup {
    public var render:FlxSprite;
    public var outline:FlxSprite;
    public var selected:Bool = false;

    public function new(x:Float = 0, y:Float = 0, ?col:Int = 0xFFFF00FF) {
        super();

		outline = new FlxSprite(x - 5, y - 5).makeGraphic(110, 110, 0xFFFFFFFF);
		add(outline);

        render = new FlxSprite(x, y).makeGraphic(100, 100, col);
        add(render);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        outline.visible = selected;
    }
}