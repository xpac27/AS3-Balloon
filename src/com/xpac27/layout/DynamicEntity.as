package com.xpac27.layout
{
    public class DynamicEntity extends Entity
    {
        public function DynamicEntity(self:Entity, subject:DisplayObjectContainer, alignement:uint, margins:Array):void
        {
            super(subject, alignement, margins);

            if(self != this)
            {
                throw new IllegalOperationError('DynamicEntity cannot be instantiated directly.');
            }

            _type = 'DynamicEntity';
        }

        final public function append(entity:Entity):void
        {
            if (entity.addTo(this))
            {
                _entities.push(entity);
                updateAll();
            }
        }

        final public function prepend(entity:Entity):void
        {
            if (entity.addTo(this))
            {
                _entities.unshift(entity);
                updateAll();
            }
        }

        final override public function update():void
        {
            if (_entities.length > 0 && parent)
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
            var entity_aspect_ratio:Number = 0;
            var parent_aspect_ratio:Number = parent.aspectRatio;

            if (horizontal())
            {
                fill_space = parent.width;

                for each (entity in _entities)
                {
                    if (entity.relative())
                    {
                        if (entity.fill())
                        {
                            fill_total ++;
                        }
                        else if (entity.fit())
                        {
                            fill_space -= entity.totalWidth;
                        }
                    }
                }

                var h:Number = 0;
                for each (entity in _entities)
                {
                    if (entity.fill())
                    {
                        if (entity.neglect())
                        {
                            entity.width = Math.max(0, fill_space / fill_total - entity.marginLeft - entity.marginRight);
                        }
                        // Do not handle margins because it's too complex
                        else if (entity.preserve())
                        {
                            entity_aspect_ratio = entity.aspectRatio;
                            if (entity_aspect_ratio > parent_aspect_ratio)
                            {
                                entity.width = Math.max(0, fill_space / fill_total);
                                entity.height = entity.width / entity_aspect_ratio;
                                entity.couldFill = true;
                            }
                            else
                            {
                                entity.height = parent.height;
                                entity.width = entity.height * entity_aspect_ratio;
                                entity.couldFill = false;
                            }
                        }
                    }
                    h = entity.totalHeight > h ? entity.totalHeight : h;
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
                        fill_space -= entity.totalHeight;
                    }
                }

                var w:Number = 0;
                for each (entity in _entities)
                {
                    if (entity.fill())
                    {
                        if (entity.neglect())
                        {
                            entity.height = Math.max(0, fill_space / fill_total - entity.marginTop - entity.marginBottom);
                        }
                        else if (entity.preserve())
                        {
                            entity_aspect_ratio = entity.width / entity.height;
                            if (entity_aspect_ratio > parent_aspect_ratio)
                            {
                                entity.height = Math.max(0, fill_space / fill_total);
                                entity.width = entity.height * entity_aspect_ratio;
                                entity.couldFill = true;
                            }
                            else
                            {
                                entity.width = parent.width;
                                entity.height = entity.width / entity_aspect_ratio;
                                entity.couldFill = false;
                            }
                        }
                    }
                    w = entity.totalWidth > w ? entity.totalWidth : w;
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
                if (entity.fill() && ((entity.preserve() && entity.couldFill) || entity.neglect()))
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
                        if (entity.hcenter() && entity.relative())
                        {
                            pos_middle += entity.totalWidth;
                        }
                    }
                    pos_middle = width / 2 - pos_middle / 2;
                    pos_end = width;
                }

                for each (entity in _entities)
                {
                    if (entity.left() || expanded)
                    {
                        if (entity.relative())
                        {
                            entity.x = pos_start + entity.marginLeft;
                            pos_start += entity.totalWidth;
                        }
                        else if (entity.absolute())
                        {
                            entity.x = entity.marginLeft;
                        }
                    }
                    else if (entity.hcenter())
                    {
                        if (entity.relative())
                        {
                            entity.x = pos_middle + entity.marginLeft - entity.marginRight;
                            pos_middle += entity.totalWidth;
                        }
                        else if (entity.absolute())
                        {
                            entity.x = width / 2 - entity.width / 2 + entity.marginLeft - entity.marginRight;
                        }
                    }
                    else if (entity.right())
                    {
                        if (entity.relative())
                        {
                            pos_end -= entity.totalWidth;
                            entity.x = pos_end + entity.marginLeft;
                        }
                        else if (entity.absolute())
                        {
                            entity.x = width - entity.width - entity.marginRight;
                        }
                    }

                    if (entity.vcenter())
                    {
                        entity.y = height / 2 - entity.height / 2 - entity.marginBottom + entity.marginTop;
                    }
                    else if (entity.top())
                    {
                        entity.y = entity.marginTop;
                    }
                    else if (entity.bottom())
                    {
                        entity.y = height - entity.height - entity.marginBottom;
                    }
                }
            }
            else if (vertical())
            {
                if (!expanded)
                {
                    for each (entity in _entities)
                    {
                        if (entity.vcenter() && entity.relative())
                        {
                            pos_middle += entity.totalHeight;
                        }
                    }
                    pos_middle = height / 2 - pos_middle / 2;
                    pos_end = height;
                }

                for each (entity in _entities)
                {
                    if (entity.top() || expanded)
                    {
                        if (entity.relative())
                        {
                            entity.y = pos_start + entity.marginTop;
                            pos_start += entity.totalHeight;
                        }
                        else if (entity.absolute())
                        {
                            entity.y = entity.marginTop;
                        }
                    }
                    else if (entity.vcenter())
                    {
                        if (entity.relative())
                        {
                            entity.y = pos_middle + entity.marginTop - entity.marginBottom;
                            pos_middle += entity.totalHeight;
                        }
                        else if (entity.absolute())
                        {
                            entity.y = height / 2 - entity.height / 2 + entity.marginTop - entity.marginBottom;
                        }
                    }
                    else if (entity.bottom())
                    {
                        if (entity.relative())
                        {
                            pos_end -= entity.totalHeight;
                            entity.y = pos_end + entity.marginTop;
                        }
                        else if (entity.absolute())
                        {
                            entity.x = height - entity.height - entity.marginBottom;
                        }
                    }

                    if (entity.hcenter())
                    {
                        entity.x = width / 2 - entity.width / 2 - entity.marginRight + entity.marginLeft;
                    }
                    else if (entity.left())
                    {
                        entity.x = entity.marginLeft;
                    }
                    else if (entity.right())
                    {
                        entity.x = width - entity.width - entity.marginRight;
                    }
                }
            }
        }

        protected function beforeUpdate():void {}
        protected function afterUpdate():void {}

        protected var _entities:Array = [];
    }

    import flash.display.DisplayObjectContainer;
    import flash.errors.IllegalOperationError;
}
