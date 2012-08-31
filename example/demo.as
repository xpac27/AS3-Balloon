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
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            var mainBalloon:Balloon = new Balloon(Balloon.ALGO_HORIZONTAL, stage);

            var el1:Sprite = new Sprite();
            el1.graphics.beginFill(0xFFFFAA);
            el1.graphics.drawRect(0, 0, 100, 50);
            el1.graphics.endFill();

            var b1:Balloon = new Balloon(Balloon.ALGO_HORIZONTAL, el1);
            mainBalloon.append(b1);

            var el2:Sprite = new Sprite();
            el2.graphics.beginFill(0xFFAAFF);
            el2.graphics.drawRect(0, 0, 60, 50);
            el2.graphics.endFill();

            var b2:Balloon = new Balloon(Balloon.ALGO_HORIZONTAL, el2);
            mainBalloon.append(b2);
        }
    }

    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.display.Sprite;

    import Balloon;
}
