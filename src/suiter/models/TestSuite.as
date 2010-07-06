package suiter.models
{
    import flash.filesystem.File;

    public class TestSuite
    {
        public function TestSuite(file:File, packageName:String)
        {
            _file = file;
            _packageName = packageName;
        }

        private var _file:File;
        public function get file():File
        {
            return _file;
        }

        private var _packageName:String;
        public function get packageName():String
        {
            return _packageName;
        }

        private var _cases:Array = [];
        public function get cases():Array
        {
            return _cases.concat();
        }

        private var _suites:Array = [];
        public function get suites():Array
        {
            return _suites.concat();
        }

        private var _elements:Array = [];
        public function get elements():Array
        {
            return _elements.concat();
        }

        public function addCase(target:TestCase):void
        {
            if (_cases.indexOf(target) == -1)
            {
                _cases.push(target);
            }
            if (_elements.indexOf(target) == -1)
            {
                _elements.push(target);
            }
        }

        public function addSuite(target:TestSuite):void
        {
            if (_suites.indexOf(target) == -1)
            {
                _suites.push(target);
            }
            if (_elements.indexOf(target) == -1)
            {
                _elements.push(target);
            }
        }
    }
}