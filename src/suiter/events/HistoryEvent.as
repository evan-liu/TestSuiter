package suiter.events
{
    import flash.events.Event;

    public class HistoryEvent extends Event
    {

        public static const LOAD_HISTORY_COMPLETED:String = "loadHistoryCompleted";
        public static const SAVE_HISTORY_COMPLETED:String = "saveHistoryCompleted";

        public function HistoryEvent(type:String, data:String = "")
        {
            super(type);
            _data = data;
        }

        private var _data:String;
        public function get data():String
        {
            return _data;
        }
    }
}