package com.xpac27.layout
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

            if (horizontal())
            {
                fill_space = parent.width;

                for each (entity in _entities)
                {
                    if (entity.fill())
                    {
                        fill_total ++;
                    }
                    else if (entity.fit())
                    {
                        fill_space -= entity.width;
                    }
                }

                var h:Number = 0;
                for each (entity in _entities)
                {
                    if (entity.fill())
                    {
                        entity.width = Math.max(0, fill_space / fill_total);
                    }
                    h  = entity.height > h ? entity.height : h;
                }
                height = h > height ? h : height;
            }
            else if (vertical())
            {
                fill_space = parent.height;

                for each (entity in _entities)
                {
                    if (entity.fill())
                    {
                        fill_total ++;
                    }
                    else if (entity.fit())
                    {
                        fill_space -= entity.height;
                    }
                }

                var w:Number = 0;
                for each (entity in _entities)
                {
                    if (entity.fill())
                    {
                        entity.height = Math.max(0, fill_space / fill_total);
                    }
                    w  = entity.width > w ? entity.width : w;
                }
                width = w > width ? w : width;
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
                if (entity.fill())
                {
                    expanded = true;
                    break;
                }
            }

            if (horizontal())
            {
                if (!expanded)
                {
                    for each (entity in _entities)
                    {
                        if (entity.hcenter())
                        {
                            pos_middle += entity.width;
                        }
                    }
                    pos_middle = width / 2 - pos_middle / 2;
                    pos_end = width;
                }

                for each (entity in _entities)
                {
                    if (expanded || entity.left())
                    {
                        entity.x = pos_start;
                        pos_start += entity.width;
                    }
                    else if (entity.hcenter())
                    {
                        entity.x = pos_middle;
                        pos_middle += entity.width;
                    }
                    else if (entity.right())
                    {
                        pos_end -= entity.width;
                        entity.x = pos_end;
                    }

                    if (entity.vcenter())
                    {
                        entity.y = height / 2 - entity.height / 2;
                    }
                    else if (entity.top())
                    {
                        entity.y = 0;
                    }
                    else if (entity.bottom())
                    {
                        entity.y = height - entity.height;
                    }
                }
            }
            else if (vertical())
            {
                if (!expanded)
                {
                    for each (entity in _entities)
                    {
                        if (entity.vcenter())
                        {
                            pos_middle += entity.height;
                        }
                    }
                    pos_middle = height / 2 - pos_middle / 2;
                    pos_end = height;
                }

                for each (entity in _entities)
                {
                    if (expanded || entity.top())
                    {
                        entity.y = pos_start;
                        pos_start += entity.height;
                    }
                    else if (entity.vcenter())
                    {
                        entity.y = pos_middle;
                        pos_middle += entity.height;
                    }
                    else if (entity.bottom())
                    {
                        pos_end -= entity.height;
                        entity.y = pos_end;
                    }

                    if (entity.hcenter())
                    {
                        entity.x = width / 2 - entity.width / 2;
                    }
                    else if (entity.left())
                    {
                        entity.x = 0;
                    }
                    else if (entity.right())
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
