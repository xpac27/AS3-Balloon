package com.xpac27.layout
{
    public class Group extends DynamicEntity
    {
        public function Group(alignement:uint = 0x0):void
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, 0.5);
            sprite.graphics.drawRect(0, 0, 1, 1);
            sprite.graphics.endFill();
            super(this, sprite, alignement, [0, 0, 0, 0]);

            if (HFill || VFill)
            {
                throw new ArgumentError('You cannot user FILL on a Group, it will always fit its content.');
            }
            _type = Entity.TYPE_GROUP;
        }

        //override public function set width(v:Number):void  {}
        //override public function set height(v:Number):void {}
        //override public function set width(v:Number):void  { subject.width = v; subject.scaleX = 1 / parent.subject.scaleX; }
        //override public function set height(v:Number):void { subject.height = v; subject.scaleY = 1 / parent.subject.scaleY; }

        //override public function get VFill():Boolean
        //{
            //return contains('VFill');
        //}
        //override public function get HFill():Boolean
        //{
            //return contains('HFill');
        //}
        override public function get width():Number
        {
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
            var min:Number = 0;
            var max:Number = 0;
            for each (var entity:Entity in entities)
            {
                min = entity.y < min ? entity.y : min;
                max = entity.y + entity.height > max ? entity.y + entity.height : max;
            }
            return max - min;
        }
    }

    import flash.display.Sprite;

    import com.xpac27.layout.Entity;
    import com.xpac27.layout.DynamicEntity;
}
