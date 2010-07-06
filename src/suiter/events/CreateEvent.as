package suiter.events
{
    import flash.events.Event;

    public class CreateEvent extends Event
    {
        public static const CREATE:String = "create";

        public function CreateEvent(type:String, path:String, exitAfterCreate:Boolean = false)
        {
            super(type);
            _path = path;
            _exitAfterCreate = exitAfterCreate;
        }

        private var _path:String;
        public function get path():String
        {
            return _path;
        }

        private var _exitAfterCreate:Boolean;
        public function get exitAfterCreate():Boolean
        {
            return _exitAfterCreate;
        }

        override public function clone():Event
        {
            return new CreateEvent(type, _path);
        }
    }
}