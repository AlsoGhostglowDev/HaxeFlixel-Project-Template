package objects;

import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.FlxGradient;
import flixel.tweens.*;

class Transition extends flixel.group.FlxSpriteGroup {
    public var transGrad:FlxSprite;
    public var transGraphic:FlxSprite;
	public var transOut:Bool = true;

	override public function new(?transOut:Bool = true, ?onComplete:() -> Void) {
        super();

		transGraphic = new FlxSprite(0).makeGraphic(1, 1, FlxColor.BLACK);
        transGraphic.scale.set(FlxG.width, FlxG.height);
        transGraphic.updateHitbox();
        add(transGraphic);

        transGrad = FlxGradient.createGradientFlxSprite(Std.int(FlxG.width/3), 1, [0x0, 0xFF000000], 1, transOut ? 0 : 180);
        transGrad.scrollFactor.set();
        transGrad.scale.y = FlxG.height;
        transGrad.updateHitbox();

		this.transOut = transOut;
        add(transGraphic);
        add(transGrad);

		transGraphic.x = (transOut ? (FlxG.width + FlxG.width / 3)-1 : 0);
		transGrad.x    = FlxG.width;

		for (transObj in members) {
			FlxTween.tween(transObj, {x: transObj.x - (FlxG.width + (FlxG.width / 3))}, 1, 
				{ease: (transOut ? FlxEase.expoIn : FlxEase.expoOut)}
            );
            new FlxTimer().start(1, (_) -> {
                if (onComplete != null)
                    onComplete();
            });
		}
    }
}