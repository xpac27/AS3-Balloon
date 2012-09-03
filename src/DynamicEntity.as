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
            if (entity.addTo(this))
            {
                _entities.push(entity);
                update();
            }
        }

        final public function prepend(entity:Entity):void
        {
            if (entity.addTo(this))
            {
                _entities.unshift(entity);
                update();
            }
        }

        final override public function update():void
        {
            if (_entities.length > 0)
            {
                beforeUpdate();
                performeUpdateTB();
                for each (var entity:Entity in _entities)
                {
                    entity.update();
                }
                performeUpdateBT();
                afterUpdate();
            }
        }

        final private function performeUpdateTB():void
        {
            var entity:Entity;
            var fill_total:Number = 0;
            var fill_space:Number = 0;

            if (alignement & Entity.HORIZONTAL)
            {
                fill_space = parent.width;

                for each (entity in _entities)
                {
                    if (entity.alignement & Entity.FILL)
                    {
                        fill_total ++;
                    }
                    else if (entity.alignement & Entity.FIT)
                    {
                        fill_space -= entity.width;
                    }
                }

                for each (entity in _entities)
                {
                    if (entity.alignement & Entity.FILL)
                    {
                        entity.width = fill_space / fill_total;
                    }
                }
            }
            else if (alignement & Entity.VERTICAL)
            {
                fill_space = parent.height;

                for each (entity in _entities)
                {
                    if (entity.alignement & Entity.FILL)
                    {
                        fill_total ++;
                    }
                    else if (entity.alignement & Entity.FIT)
                    {
                        fill_space -= entity.height;
                    }
                }

                for each (entity in _entities)
                {
                    if (entity.alignement & Entity.FILL)
                    {
                        entity.height = fill_space / fill_total;
                    }
                }
            }
        }

        final private function performeUpdateBT():void
        {
            var entity:Entity;
            var pos_start:Number = 0;
            var pos_middle:Number = 0;
            var pos_end:Number = 0;

            var expanded:Boolean = false;
            for each (entity in _entities)
            {
                if (entity.alignement & Entity.FILL)
                {
                    expanded = true;
                    break;
                }
            }

            if (alignement & Entity.HORIZONTAL)
            {
                if (!expanded)
                {
                    for each (entity in _entities)
                    {
                        if (entity.alignement & Entity.HCENTER)
                        {
                            pos_middle += entity.width;
                        }
                    }
                    pos_middle = width / 2 - pos_middle / 2;
                    pos_end = width;
                }

                for each (entity in _entities)
                {
                    if (expanded || entity.alignement & Entity.LEFT)
                    {
                        entity.x = pos_start;
                        pos_start += entity.width;
                    }
                    else if (entity.alignement & Entity.HCENTER)
                    {
                        entity.x = pos_middle;
                        pos_middle += entity.width;
                    }
                    else if (entity.alignement & Entity.RIGHT)
                    {
                        pos_end -= entity.width;
                        entity.x = pos_end;
                    }

                    if (entity.alignement & Entity.VCENTER)
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
                if (!expanded)
                {
                    for each (entity in _entities)
                    {
                        if (entity.alignement & Entity.VCENTER)
                        {
                            pos_middle += entity.height;
                        }
                    }
                    pos_middle = height / 2 - pos_middle / 2;
                    pos_end = height;
                }

                for each (entity in _entities)
                {
                    if (expanded || entity.alignement & Entity.TOP)
                    {
                        entity.y = pos_start;
                        pos_start += entity.height;
                    }
                    else if (entity.alignement & Entity.VCENTER)
                    {
                        entity.y = pos_middle;
                        pos_middle += entity.height;
                    }
                    else if (entity.alignement & Entity.BOTTOM)
                    {
                        pos_end -= entity.height;
                        entity.y = pos_end;
                    }

                    if (entity.alignement & Entity.HCENTER)
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
