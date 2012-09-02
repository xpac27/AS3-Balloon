package
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
        }

        final public function addTo(entity:Entity):Boolean
        {
            if (_subject.parent)
            {
                return false;
            }
            _parent = entity;
            _parent.subject.addChild(_subject);
            return true;
        }

        // Do nothing, Entity is static by default
        public function update():void
        {
        }

        // Writable properties
        public function set scaleX(v:Number):void { _subject.scaleX = v; }
        public function set scaleY(v:Number):void { _subject.scaleY = v; }
        public function set width(v:Number):void  { _subject.width = v - v % 1; }
        public function set height(v:Number):void { _subject.height = v - v % 1; }
        public function set x(v:Number):void      { _subject.x = v - v % 1; }
        public function set y(v:Number):void      { _subject.y = v - v % 1; }

        // Read only properties
        public function get scaleX():Number       { return _subject.scaleX; }
        public function get scaleY():Number       { return _subject.scaleY; }
        public function get x():Number            { return _subject.x; }
        public function get y():Number            { return _subject.y; }
        public function get width():Number        { return _subject.width; }
        public function get height():Number       { return _subject.height; }
        public function get alignement():uint     { return _alignement; }
        public function get parent():Entity       { return _parent; }
        public function get subject():DisplayObjectContainer { return _subject; }

        // Read only properties
        private var _alignement:uint = Entity.HORIZONTAL;
        private var _subject:DisplayObjectContainer;
        private var _parent:Entity;

        public static const HORIZONTAL : uint = 0x0001;
        public static const VERTICAL   : uint = 0x0002;

        public static const TOP        : uint = 0x0010;
        public static const BOTTOM     : uint = 0x0020;
        public static const VCENTER    : uint = 0x0040;

        public static const LEFT       : uint = 0x0100;
        public static const RIGHT      : uint = 0x0200;
        public static const HCENTER    : uint = 0x0400;

        public static const FIT        : uint = 0x1000;
        public static const FILL       : uint = 0x2000;
    }

    import flash.display.DisplayObjectContainer;
}
