package com.xpac27.layout
{
    public class Scene extends DynamicEntity
    {
        public function Scene(subject:Stage, alignement:uint = 0x0, autoUpdate:Number = 0):void
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
            _type       = Entity.TYPE_SCENE;
            _stage      = subject;
            _autoUpdate = autoUpdate;
        }

        private function onSubjectResize(event:Event):void
        {
            if (_autoUpdate == 0)
            {
                update();
            }
            else if (_autoUpdate > 0)
            {
                clearTimeout(_updateTimeout);
                _updateTimeout = setTimeout(update, _autoUpdate);
            }
        }

        override public function addTo(entity:Entity):Boolean
        {
            throw new IllegalOperationError('Scene cannot be appended or prepended to anything.');
        }

        override public function set width(v:Number):void  {}
        override public function set height(v:Number):void {}

        override public function get parent():Entity { return this; }
        override public function get width():Number  { return _stage ? _stage.stageWidth : 0; }
        override public function get height():Number { return _stage ? _stage.stageHeight : 0; }

        static public function display(o:DisplayObjectContainer):void
        {
            _displayQueue.push(o);
            while (_stage && _displayQueue.length)
            {
                _stage.addChild(_displayQueue.shift());
            }
        }
        static private var _stage         : Stage = null;
        static private var _displayQueue  : Array = [];

        private var _autoUpdate    : Number = 0;
        private var _updateTimeout : Number = 0;
    }

    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.utils.setTimeout;
    import flash.utils.clearTimeout;
    import flash.errors.IllegalOperationError;
}
