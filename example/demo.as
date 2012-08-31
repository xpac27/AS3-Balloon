package
{
    public class demo extends Sprite
    {
        public function demo():void
        {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event:Event):void
        {
            var mainBalloon:Balloon = new Balloon(Balloon.ALGO_HORIZONTAL, stage, true);

                var b1:Balloon = new Balloon(Balloon.ALGO_HORIZONTAL, getSprite(0xFFFFAA, 200, 100));
                mainBalloon.append(b1);

                    var b3:Balloon = new Balloon(Balloon.ALGO_HORIZONTAL, getSprite(0xAAFFFF, 50, 50));
                    b1.append(b3);

                var b2:Balloon = new Balloon(Balloon.ALGO_HORIZONTAL, getSprite(0xFFAAFF, 120, 160));
                mainBalloon.append(b2);

            mainBalloon.update();
        }

        private function getSprite(color:uint, width:Number, height:Number):Sprite
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(color);
            sprite.graphics.drawRect(0, 0, width, height);
            sprite.graphics.endFill();
            return sprite;
        }
    }

    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.display.Sprite;

    import Balloon;
}
