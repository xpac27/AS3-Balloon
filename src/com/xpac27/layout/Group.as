package com.xpac27.layout
{
    public class Group extends DynamicEntity
    {
        public function Group(alignement:uint = 0x0):void
        {
            super(this, new Sprite(), alignement, [0, 0, 0, 0]);

            if (super.HFit || super.VFit)
            {
                throw new ArgumentError('You cannot user FIT on a Group, it will always fit its content.');
            }
            _type = Entity.TYPE_GROUP;
        }

        override public function get HFit():Boolean
        {
            return contains('HFit');
        }
        override public function get VFit():Boolean
        {
            return contains('VFit');
        }
        override public function set width(v:Number):void
        {
            _width = (v - v % 1);
        }
        override public function set height(v:Number):void
        {
            _height = (v - v % 1);
        }
        override public function get width():Number
        {
            if (HFit) return _width;

            var min:Number = 0;
            var max:Number = 0;
            for each (var entity:Entity in entities)
            {
                min = entity.x < min ? entity.x : min;
                max = entity.x + entity.width > max ? entity.x + entity.width : max;
            }
            return max - min;
        }
        override public function get height():Number
        {
            if (VFit) return _height;

            var min:Number = 0;
            var max:Number = 0;
            for each (var entity:Entity in entities)
            {
                min = entity.y < min ? entity.y : min;
                max = entity.y + entity.height > max ? entity.y + entity.height : max;
            }
            return max - min;
        }

        private var _width:Number = 0;
        private var _height:Number = 0;
    }

    import flash.display.Sprite;

    import com.xpac27.layout.Entity;
    import com.xpac27.layout.DynamicEntity;
}
