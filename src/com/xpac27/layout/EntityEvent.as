package com.xpac27.layout
{
    public class EntityEvent extends Event
    {
        public static const UPDATED : String = 'updated';

        public function EntityEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void
        {
            super(type, bubbles, cancelable);
        }
    }

    import flash.events.Event
}
