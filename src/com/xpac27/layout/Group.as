package com.xpac27.layout
{
    public class Group extends DynamicEntity
    {
        public function Group(alignement:uint = 0x0):void
        {
            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, 0);
            sprite.graphics.drawRect(0, 0, 1, 1);
            sprite.graphics.endFill();
            super(sprite, alignement);

            if (fill())
            {
                throw new ArgumentError('You cannot user FILL on a Group, it will always fit its content.');
            }
            _type = Entity.TYPE_GROUP;
        }

        override public function set width(v:Number):void  {}
        override public function set height(v:Number):void {}
        //override public function set width(v:Number):void  { _subject.scaleX = 1 / _parent.subject.scaleX; }
        //override public function set height(v:Number):void { _subject.scaleY = 1 / _parent.subject.scaleY; }

        override public function get width():Number
        {
            return subject.stage.stageWidth;
        }
        override public function get height():Number
        {
            return subject.stage.stageHeight;
        }
        override public function get VFill():Boolean
        {
            for (var entity:Entity in entities)
            {
                if (entities.VFill()) return true;
            }
            return false;
        }
        override public function get HFill():Boolean
        {
            for (var entity:Entity in entities)
            {
                if (entities.HFill()) return true;
            }
            return false;
        }
        override public function get width():Number
        {
            if (HFill)
            {
                return parent.width;
            }
            return subject.stage.stageWidth;
        }
        override public function get height():Number
        {
            if (VFill)
            {
                return parent.height;
            }
            return subject.stage.stageHeight;
        }
    }

    import flash.display.Sprite;

    import com.xpac27.layout.Entity;
    import com.xpac27.layout.DynamicEntity;
}
