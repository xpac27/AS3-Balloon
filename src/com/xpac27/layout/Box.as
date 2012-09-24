package com.xpac27.layout
{
    public class Box extends DynamicEntity
    {
        public function Box(subject:DisplayObject, alignement:uint = 0x0, margins:Array = null):void
        {
            super(this, subject, alignement, margins);

            if (HFill || VFill)
            {
                throw new ArgumentError('Boxes must have a fixed size, you cannot use FILL on a Box.');
            }
            _type = Entity.TYPE_BOX;
        }

        override public function set width(v:Number):void  {}
        override public function set height(v:Number):void {}
    }

    import flash.display.Sprite;
    import flash.display.DisplayObject;

    import com.xpac27.layout.Entity;
    import com.xpac27.layout.DynamicEntity;
}
