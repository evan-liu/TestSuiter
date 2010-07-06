package suiter.models
{
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    public class Output
    {
        public function Output(target:File)
        {
            _suite = parseSuite(target);
            getContentForSuite(_suite);
            _value = "package \n{";
            if (_suite.packageName)
            {
                _value += _suite.packageName + " ";
            }
            _value += imports;
            _value += "\n\n\t[Suite]\n\t[RunWith(\"org.flexunit.runners.Suite\")]\n\n\tpublic class AllTests {";
            _value += content;
            _value += "\n\t}\n}";
        }

        private var content:String = "";
        private var imports:String = "";

        private var _suite:TestSuite;
        public function get suite():TestSuite
        {
            return _suite;
        }

        private var _value:String = "";
        public function get value():String
        {
            return _value;
        }

        private function parseSuite(target:File, parentSuite:TestSuite = null):TestSuite
        {
            var targetPackage:String = getPackage(target.name, parentSuite);
            var suite:TestSuite = new TestSuite(target, targetPackage);

            var list:Array = target.getDirectoryListing();
            for each (var file:File in list)
            {
                if (file.isDirectory)
                {
                    var subSuite:TestSuite = parseSuite(file, suite);
                    suite.addSuite(subSuite);
                }
                else if (isTestCase(file))
                {
                    var testCase:TestCase = new TestCase(file, suite.packageName);
                    suite.addCase(testCase);
                }
            }
            return suite;
        }

        private function isTestCase(target:File):Boolean
        {
            if (target.extension != "as")
            {
                return false;
            }
            var stream:FileStream = new FileStream();
            stream.open(target, FileMode.READ);
            var length:uint = stream.bytesAvailable;
            var data:String = stream.readUTFBytes(length);
            return data.indexOf("[Test") != -1;
        }

        private function getPackage(name:String, parentSuite:TestSuite):String
        {
            if (!parentSuite)
            {
                return "";
            }
            if (!parentSuite.packageName)
            {
                return name;
            }
            return parentSuite.packageName + "." + name;
        }

        private function getContentForSuite(target:TestSuite):void
        {
            var cases:Array = target.cases;
            if (cases.length > 0)
            {
                content += "\n\n\t\t// " + target.packageName;
                for each (var testCase:TestCase in cases)
                {
                    getContentForCase(testCase);
                }
            }
            for each (var testSuite:TestSuite in target.suites)
            {
                getContentForSuite(testSuite);
            }
        }

        private function getContentForCase(target:TestCase):void
        {
            content += "\n\t\tpublic var ";
            var name:String = target.file.name.split(".")[0];
            var fullName:String = target.packageName + "." + name;
            content += "_" + name + ":" + name + ";";
            imports += "\n\timport " + fullName + ";";
        }
    }
}