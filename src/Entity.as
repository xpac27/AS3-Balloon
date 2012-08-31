package
{
    public class Entity
    {
        public function get width():Number   { return _subject.width; }
        public function get height():Number  { return _subject.height; }
        public function get x():Number       { return _subject.x; }
        public function get y():Number       { return _subject.x; }
        public function set x(v:Number):void { _subject.x = v; }
        public function set y(v:Number):void { _subject.y = v; }

        public function get subject():DisplayObjectContainer { return _subject; }

        public function get alignement():uint { return _alignement; }

        public function update():void
        {
        }

        protected var _alignement:uint = 0x00;
        protected var _subject:DisplayObjectContainer;
    }

    import flash.display.DisplayObjectContainer;
}
