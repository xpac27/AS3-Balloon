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

        private function onClick(event:MouseEvent):void
        {
            _scene.updateAll();
        }

        private function onAddedToStage(event:Event):void
        {
            stage.addEventListener(MouseEvent.CLICK, onClick);

            _scene = new Scene(stage, Entity.HORIZONTAL);

            // Grey
            var b1:Box = new Box(getSprite(0xAAAAAA, 500, 200), Entity.HORIZONTAL);
            _scene.append(b1);

                // Yellow
                var e1:Entity = new Entity(getSprite(0xFFFFAA, 20, 60), Entity.ABSOLUTE | Entity.PRESERVE | Entity.VFILL);
                b1.append(e1);
                // Red
                var e2:Entity = new Entity(getSprite(0xFFAAAA, 60, 60), Entity.HFILL);
                b1.append(e2);
                // Green
                var e3:Entity = new Entity(getSprite(0xAAFFAA, 60, 60), Entity.TOP | Entity.LEFT);
                b1.append(e3);
                // Blue
                var e4:Entity = new Entity(getSprite(0xAAAAFF, 60, 60), Entity.BOTTOM | Entity.RIGHT);
                b1.append(e4);

            var g1:Group = new Group(Entity.VERTICAL);

                // White
                var e5:Entity = new Entity(getSprite(0xFFFFFF, 60, 60), Entity.VFILL);
                g1.append(e5);

                // Purple
                var e6:Entity = new Entity(getSprite(0xFFAAFF, 60, 60), Entity.HFILL);
                g1.append(e6);

            b1.append(g1);
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

        private var _scene:Scene;
    }

    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.display.Sprite;

    import com.xpac27.layout.Group;
    import com.xpac27.layout.Scene;
    import com.xpac27.layout.Entity;
    import com.xpac27.layout.Box;
}
