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
        }

        final public function append(entity:Entity):void
        {
            if (entity.addTo(this))
            {
                _entities.push(entity);
            }
        }

        final public function prepend(entity:Entity):void
        {
            if (entity.addTo(this))
            {
                _entities.unshift(entity);
            }
        }

        final override public function update():void
        {
            if (_entities.length > 0 && parent)
            {
                performeUpdateTB();
                for each (var entity:Entity in _entities)
                {
                    entity.update();
                }
                performeUpdateBT();
            }
        }

        private function performeUpdateTB():void
        {
            trace('performeUpdateTB of ' + type);
            computeFill();
            setFill();
        }

        private function performeUpdateBT():void
        {
            trace('performeUpdateBT of ' + type);
            if ((horizontal && HFill) || (vertical && VFill))
            {
                alignChildPosition();
            }
            else
            {
                computeChildPosition();
            }
            setChildPosition();
        }

        private function computeFill():void
        {
            trace('  > computeFill');

            var p:String = (horizontal) ? 'HFill' : 'VFill';
            var a:String = (horizontal) ? 'width' : 'height';
            var value:Number = fillSpace() / fillTotal();
            for each (var entity:Entity in _entities)
            {
                if (entity[p])
                {
                    entity[a] = value;
                    trace('    > ' + entity.type + '.' + a + ' set to ' + entity[a]);
                }
            }
        }

        private function setFill():void
        {
            trace('  > setFill');
            var a:String = (horizontal) ? 'height' : 'width';
            var p:String = (horizontal) ? 'VFill'  : 'HFill';
            for each (var entity:Entity in _entities)
            {
                if (entity[p])
                {
                    entity[a] = this[a];
                    trace('    > ' + entity.type + '.height set to ' + entity[a]);
                }
            }
        }

        private function alignChildPosition():void
        {
            trace('  > alignChildPosition');
            var a1 : String = (horizontal) ? 'x'          : 'y';
            var a2 : String = (horizontal) ? 'maringLeft' : 'marginTop';
            var a3 : String = (horizontal) ? 'totalWidth' : 'totalHeight';
            var pos_start : Number = 0;
            for each (var entity:Entity in _entities)
            {
                entity[a1] = pos_start + entity[a2];
                pos_start += entity[a3];
                trace('    > ' + entity.type + '.x set to ' + entity[a1]);
            }
        }

        private function setChildPosition():void
        {
            trace('  > setChildPosition');
            var p1 : String = (horizontal) ? 'vcenter'      : 'hcenter';
            var p2 : String = (horizontal) ? 'top'          : 'left';
            var p3 : String = (horizontal) ? 'bottom'       : 'right';
            var a1 : String = (horizontal) ? 'y'            : 'x';
            var a2 : String = (horizontal) ? 'height'       : 'width';
            var a3 : String = (horizontal) ? 'marginBottom' : 'marginRight';
            var a4 : String = (horizontal) ? 'marginTop'    : 'marginLeft';
            var info:String = '';
            for each (var entity:Entity in _entities)
            {
                if (entity[p1])
                {
                    entity[a1] = this[a2] / 2 - entity[a2] / 2 - entity[a3] + entity[a4];
                    info = p1;
                }
                else if (entity[p2])
                {
                    entity[a1] = entity[a4];
                    info = p2;
                }
                else if (entity[p3])
                {
                    entity[a1] = this[a2] - entity[a2] - entity[a3];
                    info = p3;
                }
                trace('    > ' + entity.type + '.y set to ' + entity[a1] + ' (' + info + ')');
            }
        }

        private function computeChildPosition():void
        {
            trace('  > computeChildPosition');
            var p1 : String = (horizontal) ? 'left'        : 'top';
            var p2 : String = (horizontal) ? 'hcenter'     : 'vcenter';
            var p3 : String = (horizontal) ? 'right'       : 'bottom';
            var a1 : String = (horizontal) ? 'x'           : 'y';
            var a2 : String = (horizontal) ? 'marginLeft'  : 'marginTop';
            var a3 : String = (horizontal) ? 'totalWidth'  : 'totalHeight';
            var a4 : String = (horizontal) ? 'marginRight' : 'marginBottom';
            var a5 : String = (horizontal) ? 'width'       : 'height';
            var info:String = '';
            var pos_start  : Number = 0;
            var pos_middle : Number = posMiddle();
            var pos_end    : Number = this[a5];
            for each (var entity:Entity in _entities)
            {
                if (entity[p1])
                {
                    if (entity.relative)
                    {
                        entity[a1] = pos_start + entity[a2];
                        pos_start += entity[a3];
                    }
                    else if (entity.absolute)
                    {
                        entity[a1] = entity[a2];
                    }
                    info = 'left';
                }
                else if (entity[p2])
                {
                    if (entity.relative)
                    {
                        entity[a1] = pos_middle + entity[a2] - entity[a4];
                        pos_middle += entity[a3];
                    }
                    else if (entity.absolute)
                    {
                        entity[a1] = this[a5] / 2 - entity[a5] / 2 + entity[a2] - entity[a4];
                    }
                    info = 'hcenter';
                }
                else if (entity[p3])
                {
                    if (entity.relative)
                    {
                        pos_end -= entity[a3];
                        entity[a1] = pos_end + entity[a2];
                    }
                    else if (entity.absolute)
                    {
                        entity[a1] = this[a5] - entity[a5] - entity[a4];
                    }
                    info = 'right';
                }
                trace('    > ' + entity.type + '.' + a1 + ' set to ' + entity[a1] + ' (' + info + ')');
            }
        }

        private function posMiddle():Number
        {
            var a1 : String = (horizontal) ? 'width'      : 'height';
            var a2 : String = (horizontal) ? 'totalWidth' : 'totalHeight';
            var value:Number = 0;
            for each (var entity:Entity in _entities)
            {
                if (entity.hcenter && entity.relative)
                {
                    value += entity[a2];
                }
            }
            return this[a1] / 2 - value / 2;
        }

        private function fillTotal():Number
        {
            var p:String = (horizontal) ? 'HFill' : 'VFill';
            var total:Number = 0;
            for each (var entity:Entity in _entities)
            {
                if (entity[p]) total ++;
            }
            return total;
        }

        private function fillSpace():Number
        {
            var p : String = (horizontal) ? 'HFill'      : 'VFill';
            var a : String = (horizontal) ? 'totalWidth' : 'totalHeight';
            var space:Number = (horizontal) ? width : height;
            for each (var entity:Entity in _entities)
            {
                if (!entity[p]) space -= entity[a];
            }
            return space;
        }

        protected function get entities():Array
        {
            return _entities;
        }

        private var _entities:Array = [];
    }

    import flash.display.DisplayObjectContainer;
    import flash.errors.IllegalOperationError;
}
