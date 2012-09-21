package com.xpac27.layout
{
    public class Entity extends EventDispatcher
    {
        public function Entity(subject:DisplayObjectContainer, alignement:uint = 0x0, margins:Array = null):void
        {
            _subject = subject;
            _alignement = alignement;
            _margins = (margins ||= [0, 0, 0, 0]);

            checkAlignement();
        }

        private function checkAlignement():void
        {
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

            if ((_alignement & FIT) + (_alignement & HFILL) + (_alignement & VFILL) == 0)
            {
                _alignement = _alignement | FIT;
            }

            if ((_alignement & NEGLECT) + (_alignement & PRESERVE) == 0)
            {
                _alignement = _alignement | NEGLECT;
            }

            if ((_alignement & RELATIVE) + (_alignement & ABSOLUTE) == 0)
            {
                _alignement = _alignement | RELATIVE;
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
            trace('');
            trace('============================');
            trace('');
            _subject.dispatchEvent(new Event(Event.RESIZE, true));
        }

        public function update():void
        {
            dispatchEvent(new EntityEvent(EntityEvent.UPDATED));
        }

        // OVERRIDABLE SETTER
        public function set width(v:Number):void  { _subject.width = v; }
        public function set height(v:Number):void { _subject.height = v; }

        // OVERRIDABLE GETTER
        public function get width():Number        { return _subject.width; }
        public function get height():Number       { return _subject.height; }
        public function get parent():Entity       { return _parent; }

        // OVERRIDABLE LOGIC
        public function get VFill():Boolean { return 0 != (_alignement & VFILL); }
        public function get HFill():Boolean { return 0 != (_alignement & HFILL); }

        // SETTER
        final public function set x(v:Number):void            { _subject.x = v - v % 1; }
        final public function set y(v:Number):void            { _subject.y = v - v % 1; }
        final public function set margins(v:Array):void       { _margins = v; }
        final public function set marginTop(v:Number):void    { _margins[0] = v; }
        final public function set marginRight(v:Number):void  { _margins[1] = v; }
        final public function set marginBottom(v:Number):void { _margins[2] = v; }
        final public function set marginLeft(v:Number):void   { _margins[3] = v; }
        final public function set alignement(v:uint):void     { _alignement = v; checkAlignement(); }

        // GETTER
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
        final public function get horizontal():Boolean { return 0 != (_alignement & HORIZONTAL); }
        final public function get vertical():Boolean   { return 0 != (_alignement & VERTICAL); }
        final public function get top():Boolean        { return 0 != (_alignement & TOP); }
        final public function get bottom():Boolean     { return 0 != (_alignement & BOTTOM); }
        final public function get vcenter():Boolean    { return 0 != (_alignement & VCENTER); }
        final public function get left():Boolean       { return 0 != (_alignement & LEFT); }
        final public function get right():Boolean      { return 0 != (_alignement & RIGHT); }
        final public function get hcenter():Boolean    { return 0 != (_alignement & HCENTER); }
        final public function get fit():Boolean        { return 0 != (_alignement & FIT); }
        final public function get neglect():Boolean    { return 0 != (_alignement & NEGLECT); }
        final public function get preserve():Boolean   { return 0 != (_alignement & PRESERVE); }
        final public function get relative():Boolean   { return 0 != (_alignement & RELATIVE); }
        final public function get absolute():Boolean   { return 0 != (_alignement & ABSOLUTE); }

        public static const HORIZONTAL : uint = 0x0000001;
        public static const VERTICAL   : uint = 0x0000002;
        public static const TOP        : uint = 0x0000010;
        public static const BOTTOM     : uint = 0x0000020;
        public static const VCENTER    : uint = 0x0000040;
        public static const LEFT       : uint = 0x0000100;
        public static const RIGHT      : uint = 0x0000200;
        public static const HCENTER    : uint = 0x0000400;
        public static const FIT        : uint = 0x0001000;
        public static const HFILL      : uint = 0x0002000;
        public static const VFILL      : uint = 0x0010000;
        public static const NEGLECT    : uint = 0x0100000;
        public static const PRESERVE   : uint = 0x0200000;
        public static const RELATIVE   : uint = 0x1000000;
        public static const ABSOLUTE   : uint = 0x2000000;

        public static const TYPE_ENTITY : String = 'Entity';
        public static const TYPE_GROUP  : String = 'Group';
        public static const TYPE_SCENE  : String = 'Scene';
        public static const TYPE_BOX    : String = 'Box';

        private var _alignement:uint = Entity.HORIZONTAL;
        private var _margins:Array;
        private var _subject:DisplayObjectContainer;
        private var _parent:Entity;

        protected var _type:String = TYPE_ENTITY;
    }

    import flash.display.DisplayObjectContainer;
    import flash.events.EventDispatcher;
    import flash.events.Event;

    import com.xpac27.layout.EntityEvent;
}
