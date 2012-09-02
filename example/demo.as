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
            var scene:Scene = new Scene(stage, Entity.VERTICAL);

            var l1:Entity = new Entity(getSprite(0xFFAAFF, 100, 100), Entity.HORIZONTAL_CENTER | Entity.VERTICAL_CENTER);
            scene.append(l1);

            var b1:Balloon = new Balloon(200, 200, Entity.HORIZONTAL_CENTER | Entity.VERTICAL_CENTER | Entity.HORIZONTAL, true);
            scene.append(b1);

                // Yellow
                var l2:Entity = new Entity(getSprite(0xFFFFAA, 40, 40), Entity.HORIZONTAL_CENTER | Entity.VERTICAL_CENTER);
                b1.append(l2);

                // Green
                var l3:Entity = new Entity(getSprite(0xAAFFAA, 40, 70), Entity.HORIZONTAL_CENTER | Entity.VERTICAL_CENTER);
                b1.append(l3);

                // Grey
                var l4:Entity = new Entity(getSprite(0x999999, 40, 40), Entity.HORIZONTAL_CENTER | Entity.BOTTOM);
                b1.append(l4);

                // Grey
                var l5:Entity = new Entity(getSprite(0x666666, 40, 40), Entity.RIGHT | Entity.TOP);
                b1.append(l5);

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

    import Balloon;
    import Scene;
    import Entity;
}
