package
{
    public class Leaf extends Entity
    {
        public function Leaf(subject:DisplayObjectContainer, alignement:uint = 0x00):void
        {
            _alignement = alignement;
            _subject = subject;
        }
    }

    import flash.display.DisplayObjectContainer;

    import Entity;
}
