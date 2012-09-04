package com.xpac27.layout
{
    public class Scene extends DynamicEntity
    {
        public function Scene(subject:Stage, alignement:uint):void
        {
            super(this, subject, alignement);

            if (fill())
            {
                throw new ArgumentError('You cannot user FILL on a Scene, it will always fit the entier stage.');
            }
            else if (preserve())
            {
                throw new ArgumentError('You cannot user PRESERVE on a Scene because the stage could be resized to any aspect ratio.');
            }
            else
            {
                subject.addEventListener(Event.RESIZE, onSubjectResize);
            }
        }

        private function onSubjectResize(event:Event):void
        {
            update();
        }

        override public function addTo(entity:Entity):Boolean
        {
            throw new IllegalOperationError('Scene cannot be appended or prepended to anything.');
        }

        override public function get parent():Entity { return this; }

        override public function set width(v:Number):void  {}
        override public function set height(v:Number):void {}

        override public function get width():Number  { return subject.stage.stageWidth; }
        override public function get height():Number { return subject.stage.stageHeight; }
    }

    import flash.display.Stage;
    import flash.events.Event;
    import flash.errors.IllegalOperationError;

    import com.xpac27.layout.Balloon;
}
