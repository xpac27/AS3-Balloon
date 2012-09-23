package com.xpac27.layout
{
    public class Scene extends DynamicEntity
    {
        public function Scene(subject:Stage, alignement:uint = 0x0):void
        {
            super(this, subject, alignement, [0, 0, 0, 0]);

            if (HFill || VFill)
            {
                throw new ArgumentError('You cannot user FILL on a Scene, it will always fit to the stage.');
            }
            else if (preserve)
            {
                throw new ArgumentError('You cannot user PRESERVE on a Scene because the stage could be resized to any aspect ratio.');
            }
            else
            {
                subject.addEventListener(Event.RESIZE, onSubjectResize);
            }
            _type = Entity.TYPE_SCENE;
            _stage = subject;
            checkDisplayQueue();
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

        static public function display(o:DisplayObjectContainer):void
        {
            _displayQueue.push(o);
            checkDisplayQueue();
        }
        static private function checkDisplayQueue():void
        {
            while (_stage && _displayQueue.length)
            {
                _stage.addChild(_displayQueue.shift());
            }
        }

        private static var _stage:Stage = null;
        private static var _displayQueue:Array = [];
    }

    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.errors.IllegalOperationError;
}
