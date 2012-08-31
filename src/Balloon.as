package
{
    public class Balloon extends DynamicEntity
    {
        public function Balloon(alignement:uint = 0x00):void
        {
            super(new Sprite(), alignement);
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
            subject.width = w = w > subject.width ? w : subject.width;
            subject.height = h = h > subject.height ? h : subject.height;
        }


        override protected function afterUpdate():void
        {
            for each (var entity:Entity in _entities)
            {
                entity.scaleY = 1 / subject.scaleY;
                entity.scaleX = 1 / subject.scaleX;
            }
        }
    }

    import flash.display.Sprite;

    import Entity;
}
