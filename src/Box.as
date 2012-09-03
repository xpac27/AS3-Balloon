package
{
    public class Box extends DynamicEntity
    {
        public function Box(width:uint, height:uint, alignement:uint):void
        {
            // TODO test if we can remove this drawing
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, 0.2);
            sprite.graphics.drawRect(0, 0, width, height);
            sprite.graphics.endFill();
            super(sprite, alignement);
        }
    }

    import flash.display.Sprite;

    import Entity;
    import DynamicEntity;
}
