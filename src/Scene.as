package
{
    public class Scene extends DynamicEntity
    {
        public function Scene(subject:Stage, alignement:uint = 0x00):void
        {
            super(subject, alignement);
            subject.addEventListener(Event.RESIZE, onSubjectResize);
        }

        private function onSubjectResize(event:Event):void
        {
            clearTimeout(_timeout);
            _timeout = setTimeout(update, 10);
        }

        override public function get width():Number  { return subject.stage.stageWidth; }
        override public function get height():Number { return subject.stage.stageHeight; }

        private var _timeout:Number = 0;
    }

    import flash.display.Stage;
    import flash.events.Event;
    import flash.utils.*;

    import Balloon;
}
