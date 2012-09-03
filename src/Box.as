package
{
    public class Box extends DynamicEntity
    {
        public function Box(width:uint, height:uint, alignement:uint, debug:Boolean = false):void
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, debug ? 0.2 : 0);
            sprite.graphics.drawRect(0, 0, width, height);
            sprite.graphics.endFill();
            super(sprite, alignement);
        }

        override public function get parent():Entity { return this; }
    }

    import flash.display.Sprite;

    import Entity;
    import DynamicEntity;
}
