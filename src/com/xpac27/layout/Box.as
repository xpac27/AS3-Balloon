package com.xpac27.layout
{
    public class Box extends DynamicEntity
    {
        public function Box(subject:DisplayObjectContainer, alignement:uint, margins:Array = null):void
        {
            super(this, subject, alignement, margins);

            if (fill())
            {
                throw new ArgumentError('Boxes must have a fixed size, you cannot use FILL on a Box.');
            }
            else if (preserve())
            {
                throw new ArgumentError('You cannot user PRESERVE on a Box because its size is fixed.');
            }

            _type = 'Box';
        }

        override public function get parent():Entity { return this; }

        override protected function afterUpdate():void
        {
            scaleX = 1;
            scaleY = 1;
        }
    }

    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;

    import com.xpac27.layout.Entity;
    import com.xpac27.layout.DynamicEntity;
}
