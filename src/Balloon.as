package
{
    public class Balloon extends DynamicEntity
    {
        public function Balloon(alignement:uint):void
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, 0);
            sprite.graphics.drawRect(0, 0, 1, 1);
            sprite.graphics.endFill();
            super(sprite, alignement);
        }

        override protected function beforeUpdate():void
        {
            if (alignement & FIT)
            {
                var h:Number = 0;
                var w:Number = 0;

                for each (var entity:Entity in _entities)
                {
                    h  = entity.height > h ? entity.height : h;
                    w += entity.width;
                }
                width = w > width ? w : width;
                height = h > height ? h : height;
            }
            else if (alignement & FILL)
            {
                if (alignement & Entity.HORIZONTAL)
                {
                    width = parent.width;
                }
                else if (alignement & Entity.VERTICAL)
                {
                    height = parent.height;
                }
            }
        }

        override protected function afterUpdate():void
        {
            scaleX = 1;
            scaleY = 1;
            for each (var entity:Entity in _entities)
            {
                entity.scaleY = 1 / scaleY;
                entity.scaleX = 1 / scaleX;
            }
        }
    }

    import flash.display.Sprite;

    import Entity;
}
