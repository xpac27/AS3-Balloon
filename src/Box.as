package
{
    public class Box extends DynamicEntity
    {
        public function Bax(width:uint, height:uint, alignement:uint):void
        {
            // TODO test if we can remove this drawing
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, 0.1);
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
                h  = entity.height > h ? entity.height : h;
                w += entity.width;
            }
            width = w > width ? w : width;
            height = h > height ? h : height;
        }
    }
}
