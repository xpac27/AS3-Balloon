package com.xpac27.layout
{
    public class DynamicEntity extends Entity
    {
        public function DynamicEntity(self:Entity, subject:DisplayObject, alignement:uint, margins:Array):void
        {
            super(subject, alignement, margins);

            if(self != this)
            {
                throw new IllegalOperationError('DynamicEntity cannot be instantiated directly.');
            }
        }

        final public function append(entity:Entity):void
        {
            if (entity.appendTo(this))
            {
                _entities.push(entity);
            }
        }

        final public function prepend(entity:Entity):void
        {
            if (entity.prependTo(this))
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
                finishUpdate();
            }
        }

        final override public function updateX():void
        {
            super.updateX();
            for each (var entity:Entity in _entities)
            {
                entity.updateX();
            }
        }

        final override public function updateY():void
        {
            super.updateY();
            for each (var entity:Entity in _entities)
            {
                entity.updateY();
            }
        }

        private function performeUpdateTB():void
        {
            CONFIG::DEBUG { trace('performeUpdateTB of ' + type); }

            computePreserve();
            computeFill();
            setFill();
        }

        private function performeUpdateBT():void
        {
            CONFIG::DEBUG { trace('performeUpdateBT of ' + type); }

            computeChildPosition();
            setChildPosition();
        }

        private function computePreserve():void
        {
            CONFIG::DEBUG { trace('  > computePreserve'); }

            var ratio:Number = width / height;
            for each (var entity:Entity in _entities)
            {
                if (entity.preserve && entity.absolute && (entity.VFill || entity.HFill))
                {
                    if (entity.aspectRatio > ratio)
                    {
                        entity.width  = width - entity.marginLeft - entity.marginRight;
                        entity.height = entity.width / entity.aspectRatio;
                    }
                    else
                    {
                        entity.height = height - entity.marginTop - entity.marginBottom;
                        entity.width  = entity.height * entity.aspectRatio;
                    }

                    CONFIG::DEBUG { trace('    > ' + entity.type + ' width set to ' + entity.width + ', height set to ' + entity.height); }
                }
            }
        }

        private function computeFill():void
        {
            CONFIG::DEBUG { trace('  > computeFill'); }

            var p1 : String = (horizontal) ? 'HFill'       : 'VFill';
            var a1 : String = (horizontal) ? 'width'       : 'height';
            var a2 : String = (horizontal) ? 'marginLeft'  : 'marginTop';
            var a3 : String = (horizontal) ? 'marginRight' : 'marginBottom';
            var total:Number = fillTotal();
            if (total > 0)
            {
                var value:Number = fillSpace() / total;
                for each (var entity:Entity in _entities)
                {
                    if (entity[p1])
                    {
                        entity[a1] = value - entity[a2] - entity[a3];

                        CONFIG::DEBUG { trace('    > ' + entity.type + '.' + a1 + ' set to ' + entity[a1]); }
                    }
                }
            }
        }

        private function setFill():void
        {
            CONFIG::DEBUG { trace('  > setFill'); }

            var a:String = (horizontal) ? 'height' : 'width';
            var p:String = (horizontal) ? 'VFill'  : 'HFill';
            for each (var entity:Entity in _entities)
            {
                if (entity[p] && entity.neglect)
                {
                    entity[a] = this[a];

                    CONFIG::DEBUG { trace('    > ' + entity.type + '.height set to ' + entity[a]); }
                }
            }
        }

        private function setChildPosition():void
        {
            CONFIG::DEBUG { trace('  > setChildPosition'); }

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

                CONFIG::DEBUG { trace('    > ' + entity.type + '.' + a1 + ' set to ' + entity[a1] + ' (' + info + ')'); }
            }
        }

        private function computeChildPosition():void
        {
            CONFIG::DEBUG { trace('  > computeChildPosition'); }

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
                        entity[a1] = pos_middle + entity[a2];
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

                CONFIG::DEBUG { trace('    > ' + entity.type + '.' + a1 + ' set to ' + entity[a1] + ' (' + info + ')'); }
            }
        }

        private function posMiddle():Number
        {
            var a1 : String = (horizontal) ? 'width'      : 'height';
            var p1 : String = (horizontal) ? 'hcenter'    : 'vcenter';
            var p2 : String = (horizontal) ? 'left'       : 'right';
            var p3 : String = (horizontal) ? 'totalWidth' : 'totalHeight';
            var value:Number = 0;
            var start:Number = 0;
            for each (var entity:Entity in _entities)
            {
                if (entity[p1] && entity.relative)
                {
                    value += entity[p3];
                }
                else if (entity[p2])
                {
                    start += entity[p3];
                }
            }
            return ((horizontal && contains('HFill')) || (vertical && contains('VFill')))
                ? start
                : this[a1] / 2 - value / 2;
        }

        final private function finishUpdate():void
        {
            for each (var entity:Entity in _entities)
            {
                entity.afterUpdate();
            }
        }

        private function fillTotal():Number
        {
            var p:String = (horizontal) ? 'HFill' : 'VFill';
            var total:Number = 0;
            for each (var entity:Entity in _entities)
            {
                if (entity[p] && entity.neglect) total ++;
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
                if (!entity[p] && entity.relative) space -= entity[a];
            }
            return space;
        }

        protected function contains(a:String):Boolean
        {
            for each (var entity:Entity in _entities)
            {
                if (entity[a]) return true;
            }
            return false;
        }

        protected function get entities():Array
        {
            return _entities;
        }

        private var _entities:Array = [];
    }

    import flash.display.DisplayObject;
    import flash.errors.IllegalOperationError;
}
