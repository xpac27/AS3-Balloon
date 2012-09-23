package com.xpac27.layout
{
    public class Group extends DynamicEntity
    {
        public function Group(alignement:uint = 0x0):void
        {
            super(this, new Sprite(), alignement, [0, 0, 0, 0]);

            if (super.HFill || super.VFill)
            {
                throw new ArgumentError('You cannot user FILL on a Group, it will always fit its content.');
            }
            _type = Entity.TYPE_GROUP;
        }

        override public function get HFill():Boolean
        {
            return contains('HFill');
        }
        override public function get VFill():Boolean
        {
            return contains('VFill');
        }
        override public function set width(v:Number):void
        {
            _width = v;
        }
        override public function set height(v:Number):void
        {
            _height = v;
        }
        override public function get width():Number
        {
            if (HFill) return _width;

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
            if (VFill) return _height;

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
