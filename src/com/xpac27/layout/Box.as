package com.xpac27.layout
{
    public class Box extends DynamicEntity
    {
        public function Box(width:uint, height:uint, alignement:uint, debug:Boolean = false):void
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, debug ? 0.2 : 0);
            sprite.graphics.drawRect(0, 0, width, height);
            sprite.graphics.endFill();
            super(this, sprite, alignement);

            if (fill())
            {
                throw new ArgumentError('Boxes must have a fixed size, you cannot use FILL on a Box.');
            }
            else if (preserve())
            {
                throw new ArgumentError('You cannot user PRESERVE on a Box because its size is fixed.');
            }
        }

        override public function get parent():Entity { return this; }

        override protected function afterUpdate():void
        {
            scaleX = 1;
            scaleY = 1;
        }
    }

    import flash.display.Sprite;

    import com.xpac27.layout.Entity;
    import com.xpac27.layout.DynamicEntity;
}
