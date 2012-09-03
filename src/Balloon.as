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

        override protected function afterUpdate():void
        {
            scaleX = 1;
            scaleY = 1;
        }
    }

    import flash.display.Sprite;

    import Entity;
}
