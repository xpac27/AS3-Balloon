package
{
    public class Balloon extends Entity
    {
        public function Balloon(alignement:uint):void
        {
            _alignement = alignement;
            _subject = new Sprite();
        }

        public function append(entity:Entity):void
        {
            _entities.push(entity);
            _subject.addChild(entity.subject);
        }

        public function prepend(entity:Entity):void
        {
            _entities.unshift(entity);
            _subject.addChild(entity.subject);
        }

        override public function update():void
        {
            if (_entities.length > 0)
            {
                for each (var entity:Entity in _entities)
                {
                    entity.update();
                }
                performe_update();
            }
        }

        protected function performe_update():void
        {
            trace('update Balloon' + width + 'x' + height);
        }

        protected var _entities:Array = [];
    }

    import flash.display.Sprite;

    import Entity;
}
