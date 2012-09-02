package
{
    public class Entity
    {
        public function Entity(subject:DisplayObjectContainer, alignement:uint):void
        {
            _subject = subject;
            _alignement = alignement;
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

        // Constants
        public static const HORIZONTAL        : uint = 0x0001;
        public static const VERTICAL          : uint = 0x0002;
        public static const TOP               : uint = 0x0010;
        public static const BOTTOM            : uint = 0x0020;
        public static const LEFT              : uint = 0x0100;
        public static const RIGHT             : uint = 0x0200;
        public static const HORIZONTAL_CENTER : uint = 0x1000;
        public static const VERTICAL_CENTER   : uint = 0x2000;
    }

    import flash.display.DisplayObjectContainer;
}
