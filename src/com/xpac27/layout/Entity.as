package com.xpac27.layout
{
    public class Entity
    {
        public function Entity(subject:DisplayObjectContainer, alignement:uint = 0x00, margins:Array = null):void
        {
            _subject = subject;
            _alignement = alignement;
            _margins = (margins ||= [0, 0, 0, 0]);

            if ((_alignement & HORIZONTAL) + (_alignement & VERTICAL) == 0)
            {
                _alignement = _alignement | HORIZONTAL;
            }

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

        public function updateAll():void
        {
            _subject.dispatchEvent(new Event(Event.RESIZE, true));
        }

        public function update():void {}

        // OVERRIDABLE SETTER
        public function set width(v:Number):void  { _subject.width = v; }
        public function set height(v:Number):void { _subject.height = v; }

        // OVERRIDABLE GETTER
        public function get width():Number        { return _subject.width; }
        public function get height():Number       { return _subject.height; }
        public function get parent():Entity       { return _parent; }

        // SETTER
        final public function set scaleX(v:Number):void       { _subject.scaleX = v; }
        final public function set scaleY(v:Number):void       { _subject.scaleY = v; }
        final public function set x(v:Number):void            { _subject.x = v - v % 1; }
        final public function set y(v:Number):void            { _subject.y = v - v % 1; }
        final public function set margins(v:Array):void       { _margins = v; }
        final public function set marginTop(v:Number):void    { _margins[0] = v; }
        final public function set marginRight(v:Number):void  { _margins[1] = v; }
        final public function set marginBottom(v:Number):void { _margins[2] = v; }
        final public function set marginLeft(v:Number):void   { _margins[3] = v; }

        // GETTER
        final public function get scaleX():Number       { return _subject.scaleX; }
        final public function get scaleY():Number       { return _subject.scaleY; }
        final public function get x():Number            { return _subject.x; }
        final public function get y():Number            { return _subject.y; }
        final public function get margins():Array       { return _margins; }
        final public function get marginTop():Number    { return _margins[0]; }
        final public function get marginRight():Number  { return _margins[1]; }
        final public function get marginBottom():Number { return _margins[2]; }
        final public function get marginLeft():Number   { return _margins[3]; }
        final public function get type():String         { return _type; }
        final public function get aspectRatio():Number  { return width / height; }
        final public function get totalWidth():Number   { return width + _margins[1] + _margins[3]; }
        final public function get totalHeight():Number  { return height + _margins[0] + _margins[2]; }
        final public function get subject():DisplayObjectContainer { return _subject; }

        // HELPERS
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
        private var _margins:Array;
        private var _subject:DisplayObjectContainer;
        private var _parent:Entity;

        protected var _type:String = 'Entity';
    }

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
}
