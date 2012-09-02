package
{
    public class Entity
    {
        public function Entity(subject:DisplayObjectContainer, alignement:uint = 0x00):void
        {
            _subject = subject;
            _alignement = alignement;

            if ((_alignement & TOP) + (_alignement & BOTTOM) + (_alignement & VERTICAL_CENTER) == 0)
            {
                trace('default 1');
                _alignement = _alignement | VERTICAL_CENTER;
            }
            else
            {
                trace('ok 1');
            }

            if ((_alignement & LEFT) + (_alignement & RIGHT) + (_alignement & HORIZONTAL_CENTER) == 0)
            {
                trace('default 2');
                _alignement = _alignement | HORIZONTAL_CENTER;
            }
            else
            {
                trace('ok 2');
            }
        }

        // Meant to protect the _subject attribute
        final public function addTo(subject:DisplayObjectContainer):Boolean
        {
            if (_subject.parent)
            {
                return false;
            }
            subject.addChild(_subject);
            return true;
        }

        // Do nothing as Entity is static by default
        public function update():void {}

        // Writable properties
        public function set scaleX(v:Number):void { _subject.scaleX = v; }
        public function set scaleY(v:Number):void { _subject.scaleY = v; }
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
        public function get subject():DisplayObjectContainer { return _subject; }

        // Read only properties
        private var _alignement:uint = Entity.HORIZONTAL;
        private var _subject:DisplayObjectContainer;

        public static const HORIZONTAL        : uint = 0x001;
        public static const VERTICAL          : uint = 0x002;

        public static const TOP               : uint = 0x010;
        public static const BOTTOM            : uint = 0x020;
        public static const VERTICAL_CENTER   : uint = 0x040;

        public static const LEFT              : uint = 0x100;
        public static const RIGHT             : uint = 0x200;
        public static const HORIZONTAL_CENTER : uint = 0x400;
    }

    import flash.display.DisplayObjectContainer;
}
