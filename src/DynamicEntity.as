package
{
    public class DynamicEntity extends Entity
    {
        public function DynamicEntity(alignement:uint):void
        {
            super(alignement);
        }

        public function append(entity:Entity):void
        {
            if (entity.addTo(_subject))
            {
                _entities.push(entity);
            }
        }

        public function prepend(entity:Entity):void
        {
            if (entity.addTo(_subject))
            {
                _entities.unshift(entity);
            }
        }

        override public function update():void
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

        private function performeUpdate():void
        {
            var entity:Entity;
            var pos:Number;

            if (_alignement == 0x00)
            {
                pos = _paddingLeft;
                for each (entity in _entities)
                {
                    entity.x = pos;
                    pos += entity.width / _subject.scaleX;

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
            else if (_alignement == 0x01)
            {
                pos = _paddingTop;
                for each (entity in _entities)
                {
                    entity.y = pos;
                    pos += entity.height;

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
}
