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
            //var scene:Scene = new Scene(stage, Style.VERTICAL);
            var scene:Scene = new Scene(stage, Style.HORIZONTAL);

            var l1:Leaf = new Leaf(getSprite(0xFFAAFF, 100, 100));
            scene.append(l1);

            var b1:Balloon = new Balloon(Style.HORIZONTAL);
            scene.append(b1);

            var l2:Leaf = new Leaf(getSprite(0xFFFFAA, 40, 40));
            b1.append(l2);

            scene.update();
        }

        private function getSprite(color:uint, width:Number, height:Number):Sprite
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(color);
            sprite.graphics.drawRect(0, 0, width, height);
            sprite.graphics.endFill();
            sprite.alpha = 0.75;
            return sprite;
        }
    }

    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.display.Sprite;

    import Entity;
    import Balloon;
    import Scene;
    import Leaf;
    import Style;
}
