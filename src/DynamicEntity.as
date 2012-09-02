package
{
    public class DynamicEntity extends Entity
    {
        public function DynamicEntity(subject:DisplayObjectContainer, alignement:uint):void
        {
            super(subject, alignement);
        }

        final public function append(entity:Entity):void
        {
            if (entity.addTo(subject))
            {
                _entities.push(entity);
            }
        }

        final public function prepend(entity:Entity):void
        {
            if (entity.addTo(subject))
            {
                _entities.unshift(entity);
            }
        }

        final override public function update():void
        {
            if (_entities.length > 0)
            {
                for each (var entity:Entity in _entities)
                {
                    entity.update();
                }
                beforeUpdate();
                performeUpdate();
                afterUpdate();
            }
        }

        final private function performeUpdate():void
        {
            var entity:Entity;
            var pos_start:Number = 0;
            var pos_middle:Number = 0;
            var pos_end:Number = 0;

            if (alignement & Entity.HORIZONTAL)
            {
                for each (entity in _entities)
                {
                    pos_middle += entity.width;
                }
                pos_middle = width / 2 - pos_middle / 2;
                pos_end = width;

                for each (entity in _entities)
                {
                    // TODO CHECK TOP BOTTOM CENTER HERE
                    entity.x = pos_middle;
                    pos_middle += entity.width / subject.scaleX;

                    if (entity.alignement & Entity.CENTER)
                    {
                        entity.y = height / 2 - entity.height / 2;
                    }
                    else if (entity.alignement & Entity.TOP)
                    {
                        entity.y = 0;
                    }
                    else if (entity.alignement & Entity.BOTTOM)
                    {
                        entity.y = height - entity.height;
                    }
                }
            }
            else if (alignement & Entity.VERTICAL)
            {
                for each (entity in _entities)
                {
                    pos_middle += entity.height;
                }
                pos_middle = height / 2 - pos_middle / 2;

                for each (entity in _entities)
                {
                    entity.y = pos_middle;
                    pos_middle += entity.height / subject.scaleY;

                    if (entity.alignement & Entity.CENTER)
                    {
                        entity.x = width / 2 - entity.width / 2;
                    }
                    else if (entity.alignement & Entity.LEFT)
                    {
                        entity.x = 0;
                    }
                    else if (entity.alignement & Entity.RIGHT)
                    {
                        entity.x = width - entity.width;
                    }
                }
            }
        }

        protected function beforeUpdate():void {}
        protected function afterUpdate():void {}

        protected var _entities:Array = [];
    }

    import flash.display.DisplayObjectContainer;
}
