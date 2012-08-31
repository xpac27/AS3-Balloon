package
{
    public class Balloon
    {
        public function Balloon(algo:uint, subject:DisplayObjectContainer, main:Boolean = false):void
        {
            _algo = algo;

            _subject = subject;
            _subject.addEventListener(Event.RESIZE, onSubjectResize);
            _subject.addEventListener(Event.ADDED_TO_STAGE, onSubjectAddedToStage);

            _main = main;

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
        private function onSubjectAddedToStage(event:Event):void
        {
            update();
        }

        private function update():void
        {
            switch (_algo)
            {
                case 0x00:
                    update_horizontal();
                    break;

                case 0x01:
                    update_vertical();
                    break;

                default:
                    return;
                    break;
            }
        }

        private function update_horizontal():void
        {
            var x:uint = 0;
            var y:uint = 0;
            var height:uint = 0;
            var balloon:Balloon;

            if (_main)
            {
                trace('stage');
                height = _subject.stage.stageHeight;
            }
            else if (_subject.numChildren == 0)
            {
                trace('...');
                height = _subject.parent.height;
            }
            else
            {
                height = _subject.height;
            }
            //else
            //{
                //for each (balloon in _balloons)
                //{
                    //height = balloon.subject.height > height ? balloon.subject.height : height;
                //}
                //_subject.height = height;
            //}

            for each (balloon in _balloons)
            {
                balloon.subject.x = x;
                x += balloon.subject.width;

                switch (balloon.alignement)
                {
                    case 0x00:
                        balloon.subject.y = height / 2 - balloon.subject.height / 2;
                        break;

                    case 0x01:
                        balloon.subject.y = 0;
                        break;

                    case 0x02:
                        balloon.subject.y = height - balloon.subject.height;
                        break;
                }
            }
        }

        private function update_vertical():void
        {
        }


        public function set alignement(v:uint):void { _alignement = v; }

        public function get alignement():uint                { return _alignement; }
        public function get subject():DisplayObjectContainer { return _subject; }

        public static const ALGO_HORIZONTAL:uint = 0x00;
        public static const ALGO_VERTICAL:uint   = 0x01;

        public static const CENTER : uint = 0x00;
        public static const TOP    : uint = 0x01;
        public static const BOTTOM : uint = 0x02;
        public static const LEFT   : uint = 0x01;
        public static const RIGHT  : uint = 0x02;

        private var _alignement:uint = 0x00;

        private var _subject:DisplayObjectContainer;
        private var _algo:uint;

        private var _main:Boolean = false; // Means it's stage, fix this by creating a stageBalloon
        private var _balloons:Array = [];
    }

    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
}
