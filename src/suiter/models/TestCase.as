package suiter.models
{
    import flash.filesystem.File;

    public class TestCase
    {
        public function TestCase(file:File, packageName:String)
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
    }
}