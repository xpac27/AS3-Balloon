package
{
    public class DynamicEntity extends Entity
    {
        public function DynamicEntity(subject:DisplayObjectContainer, alignement:uint = 0x00):void
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
            var pos:Number = 0;

            if (alignement == 0x00)
            {
                for each (entity in _entities)
                {
                    pos += entity.width;
                }
                pos = width / 2 - pos / 2;

                for each (entity in _entities)
                {
                    entity.x = pos;
                    pos += entity.width / subject.scaleX;

                    switch (entity.alignement)
                    {
                        case 0x00:
                            entity.y = height / 2 - entity.height / 2;
                            break;

                        case 0x01:
                            entity.y = 0;
                            break;

                        case 0x02:
                            entity.y = height - entity.height;
                            break;
                    }
                }
            }
            else if (alignement == 0x01)
            {
                for each (entity in _entities)
                {
                    pos += entity.height;
                }
                pos = height / 2 - pos / 2;

                for each (entity in _entities)
                {
                    entity.y = pos;
                    pos += entity.height / subject.scaleY;

                    switch (entity.alignement)
                    {
                        case 0x00:
                            entity.x = width / 2 - entity.width / 2;
                            break;

                        case 0x01:
                            entity.x = 0;
                            break;

                        case 0x02:
                            entity.x = width - entity.width;
                            break;
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
