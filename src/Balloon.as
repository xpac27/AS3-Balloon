package
{
    public class Balloon extends DynamicEntity
    {
        public function Balloon(alignement:uint):void
        {
            super(alignement);
            _subject = new Sprite();
        }

        override protected function beforeUpdate():void
        {
            var h:Number = 0;
            var w:Number = 0;
            for each (var entity:Entity in _entities)
            {
                entity.scaleY = 1;
                entity.scaleX = 1;
                h  = entity.height > h ? entity.height : h;
                w += entity.width;
            }
            _subject.width = w = w > _subject.width ? w : _subject.width;
            _subject.height = h = h > _subject.height ? h : _subject.height;
        }


        override protected function afterUpdate():void
        {
            for each (var entity:Entity in _entities)
            {
                entity.scaleY = 1 / _subject.scaleY;
                entity.scaleX = 1 / _subject.scaleX;
            }
        }
    }

    import flash.display.Sprite;

    import Entity;
}
