package
{
    public class Balloon extends DynamicEntity
    {
        public function Balloon(alignement:uint = 0x00, width:uint = 1, height:uint = 1, debug:Boolean = false):void
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, debug ? 0.1 : 0);
            sprite.graphics.drawRect(0, 0, width, height);
            sprite.graphics.endFill();
            super(sprite, alignement);
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
