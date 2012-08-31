package
{
    public class Balloon extends Entity
    {
        public function Balloon(alignement:uint):void
        {
            _alignement = alignement;
            _subject = new Sprite();
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

        protected function beforeUpdate():void
        {
            var h:Number = 0;
            var w:Number = 0;
            for each (var entity:Entity in _entities)
            {
                entity.scaleY = 1;
                entity.scaleX = 1;
                h  = entity.height > h ? entity.height : h;
                w += entity.width;
            }
            _subject.width = w = w > _subject.width ? w : _subject.width;
            _subject.height = h = h > _subject.height ? h : _subject.height;
        }

        private function performeUpdate():void
        {
            var entity:Entity;
            var pos:Number = _padding;

            if (_alignement == 0x00)
            {
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

        protected function afterUpdate():void
        {
            for each (var entity:Entity in _entities)
            {
                entity.scaleY = 1 / _subject.scaleY;
                entity.scaleX = 1 / _subject.scaleX;
            }
        }

        protected var _entities:Array = [];
        protected var _padding:Number = 0;
    }

    import flash.display.Sprite;

    import Entity;
}
