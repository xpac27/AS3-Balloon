package
{
    public class Scene extends Balloon
    {
        public function Scene(subject:Stage, alignement:uint):void
        {
            super(alignement);
            _subject = subject;
            _subject.addEventListener(Event.RESIZE, onSubjectResize);
        }

        private function onSubjectResize(event:Event):void
        {
            clearTimeout(_timeout);
            _timeout = setTimeout(update, 10);
        }

        override protected function update_horizontal():void
        {
            var entity:Entity;
            var h:Number = 0;
            var w:Number = 0;
            var pos:Number = 0;

            for each (entity in _entities)
            {
                w += entity.width;
            }
            h = height;
            pos = width / 2 - w / 2;

            for each (entity in _entities)
            {
                entity.x = pos;
                pos += entity.width;

                switch (entity.alignement)
                {
                    case 0x00:
                        entity.y = h / 2 - entity.height / 2;
                        break;

                    case 0x01:
                        entity.y = 0;
                        break;

                    case 0x02:
                        entity.y = h - entity.height;
                        break;
                }
            }
        }

        override protected function update_vertical():void
        {
            var entity:Entity;
            var h:Number = 0;
            var w:Number = 0;
            var pos:Number = 0;

            for each (entity in _entities)
            {
                h += entity.height;
            }
            w = width;
            pos = height / 2 - h / 2;

            for each (entity in _entities)
            {
                entity.y = pos;
                pos += entity.height;

                switch (entity.alignement)
                {
                    case 0x00:
                        entity.x = w / 2 - entity.width / 2;
                        break;

                    case 0x01:
                        entity.x = 0;
                        break;

                    case 0x02:
                        entity.x = h - entity.width;
                        break;
                }
            }
        }

        override public function get width():Number  { return _subject.stage.stageWidth; }
        override public function get height():Number { return _subject.stage.stageHeight; }

        private var _timeout:Number = 0;
    }

    import flash.display.Stage;
    import flash.events.Event;
    import flash.utils.*;

    import Balloon;
    import Style;
}
