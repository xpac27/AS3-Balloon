package com.xpac27.layout
{
    public class Balloon extends DynamicEntity
    {
        public function Balloon(alignement:uint):void
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, 0);
            sprite.graphics.drawRect(0, 0, 1, 1);
            sprite.graphics.endFill();
            super(this, sprite, alignement);

            if (preserve())
            {
                throw new ArgumentError('You cannot user PRESERVE on a Balloon because it has no original size, it\'s extensible.');
            }

            _type = 'Balloon';
        }

        override public function get width():Number  { return super.width / scaleX; }
        override public function get height():Number { return super.height / scaleY; }

        override protected function afterUpdate():void
        {
            scaleX = 1;
            scaleY = 1;
        }
    }

    import flash.display.Sprite;

    import com.xpac27.layout.DynamicEntity;
}
