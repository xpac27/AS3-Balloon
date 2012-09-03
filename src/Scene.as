package
{
    public class Scene extends DynamicEntity
    {
        public function Scene(subject:Stage, alignement:uint):void
        {
            super(subject, alignement);
            subject.addEventListener(Event.RESIZE, onSubjectResize);
        }

        private function onSubjectResize(event:Event):void
        {
            update();
        }

        override public function get parent():Entity { return this; }

        override public function set width(v:Number):void  {}
        override public function set height(v:Number):void {}

        override public function get width():Number  { return subject.stage.stageWidth; }
        override public function get height():Number { return subject.stage.stageHeight; }
    }

    import flash.display.Stage;
    import flash.events.Event;

    import Balloon;
}
