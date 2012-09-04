package com.xpac27.layout
{
    public class Entity
    {
        public function Entity(subject:DisplayObjectContainer, alignement:uint = 0x00):void
        {
            _subject = subject;
            _alignement = alignement;

            if ((_alignement & TOP) + (_alignement & BOTTOM) + (_alignement & VCENTER) == 0)
            {
                _alignement = _alignement | VCENTER;
            }

            if ((_alignement & LEFT) + (_alignement & RIGHT) + (_alignement & HCENTER) == 0)
            {
                _alignement = _alignement | HCENTER;
            }

            if ((_alignement & FIT) + (_alignement & FILL) == 0)
            {
                _alignement = _alignement | FIT;
            }

            if ((_alignement & NEGLECT) + (_alignement & PRESERVE) == 0)
            {
                _alignement = _alignement | NEGLECT;
            }
        }

        public function addTo(entity:Entity):Boolean
        {
            if (_subject.parent)
            {
                return false;
            }
            _parent = entity;
            _parent.subject.addChild(_subject);
            return true;
        }

        public function update():void {}

        public function set width(v:Number):void  { _subject.width = v - v % 1; }
        public function set height(v:Number):void { _subject.height = v - v % 1; }
        public function get width():Number        { return _subject.width; }
        public function get height():Number       { return _subject.height; }
        public function get parent():Entity       { return _parent; }

        final public function set scaleX(v:Number):void { _subject.scaleX = v; }
        final public function set scaleY(v:Number):void { _subject.scaleY = v; }
        final public function set x(v:Number):void      { _subject.x = v - v % 1; }
        final public function set y(v:Number):void      { _subject.y = v - v % 1; }
        final public function get scaleX():Number       { return _subject.scaleX; }
        final public function get scaleY():Number       { return _subject.scaleY; }
        final public function get x():Number            { return _subject.x; }
        final public function get y():Number            { return _subject.y; }
        final public function get subject():DisplayObjectContainer { return _subject; }
        final public function horizontal():Boolean { return 0 != (_alignement & HORIZONTAL); }
        final public function vertical():Boolean   { return 0 != (_alignement & VERTICAL); }
        final public function top():Boolean        { return 0 != (_alignement & TOP); }
        final public function bottom():Boolean     { return 0 != (_alignement & BOTTOM); }
        final public function vcenter():Boolean    { return 0 != (_alignement & VCENTER); }
        final public function left():Boolean       { return 0 != (_alignement & LEFT); }
        final public function right():Boolean      { return 0 != (_alignement & RIGHT); }
        final public function hcenter():Boolean    { return 0 != (_alignement & HCENTER); }
        final public function fit():Boolean        { return 0 != (_alignement & FIT); }
        final public function fill():Boolean       { return 0 != (_alignement & FILL); }
        final public function neglect():Boolean    { return 0 != (_alignement & NEGLECT); }
        final public function preserve():Boolean   { return 0 != (_alignement & PRESERVE); }

        public static const HORIZONTAL : uint = 0x00001;
        public static const VERTICAL   : uint = 0x00002;
        public static const TOP        : uint = 0x00010;
        public static const BOTTOM     : uint = 0x00020;
        public static const VCENTER    : uint = 0x00040;
        public static const LEFT       : uint = 0x00100;
        public static const RIGHT      : uint = 0x00200;
        public static const HCENTER    : uint = 0x00400;
        public static const FIT        : uint = 0x01000;
        public static const FILL       : uint = 0x02000;
        public static const NEGLECT    : uint = 0x10000;
        public static const PRESERVE   : uint = 0x20000;

        private var _alignement:uint = Entity.HORIZONTAL;
        private var _subject:DisplayObjectContainer;
        private var _parent:Entity;
    }

    import flash.display.DisplayObjectContainer;
}
