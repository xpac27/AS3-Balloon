package
{
    public class Entity
    {
        public function Entity(alignement:uint):void
        {
            _alignement = alignement;
        }

        public function set scaleX(v:Number):void { _subject.scaleX = v; }
        public function set scaleY(v:Number):void { _subject.scaleY = v; }
        public function set x(v:Number):void      { _subject.x = v - v % 1; }
        public function set y(v:Number):void      { _subject.y = v - v % 1; }

        public function get scaleX():Number       { return _subject.scaleX; }
        public function get scaleY():Number       { return _subject.scaleY; }
        public function get width():Number        { return _subject.width; }
        public function get height():Number       { return _subject.height; }
        public function get x():Number            { return _subject.x; }
        public function get y():Number            { return _subject.x; }

        public function get alignement():uint { return _alignement; }

        public function addTo(subject:DisplayObjectContainer):Boolean
        {
            if (!_subject.parent)
            {
                subject.addChild(_subject);
                return true;
            }
            return false;
        }
        public function update():void {}

        protected var _paddingLeft:Number   = 0;
        protected var _paddingTop:Number    = 0;
        protected var _paddingRight:Number  = 0;
        protected var _paddingBottom:Number = 0;

        protected var _alignement:uint = 0x00;

        protected var _subject:DisplayObjectContainer;
    }

    import flash.display.DisplayObjectContainer;
}
