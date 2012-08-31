package
{
    public class Balloon
    {
        public function Balloon(algo:uint, subject:DisplayObjectContainer):void
        {
            _algo = algo;

            _subject = subject;
            _subject.addEventListener(Event.RESIZE, onSubjectResize);

            _balloons = [];

            if (_subject.parent)
            {
                update();
            }
        }

        public function append(balloon:Balloon):void
        {
            _balloons.push(balloon);
            _subject.addChild(balloon.subject);
            update();
        }
        public function prepend(balloon:Balloon):void
        {
            _balloons.unshift(balloon);
            _subject.addChild(balloon.subject);
            update();
        }

        private function onSubjectResize(event:Event):void
        {
            update();
        }

        private function update():void
        {
            var x:uint = 0;
            var y:uint = 0;

            for each (var balloon:Balloon in _balloons)
            {
                balloon.subject.x = x;
                x += balloon.subject.width;
            }
        }

        public function get subject():DisplayObjectContainer { return _subject; }

        public static const ALGO_HORIZONTAL:uint = 0x00;
        public static const ALGO_VERTICAL:uint   = 0x01;

        private var _subject:DisplayObjectContainer;
        private var _algo:uint;
        private var _balloons:Array;
    }

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
}
