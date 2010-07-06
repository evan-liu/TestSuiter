package suiter.commands
{
    import flash.desktop.NativeApplication;
    import flash.display.DisplayObjectContainer;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    import mx.controls.Alert;
    import mx.managers.PopUpManager;

    import suiter.events.CreateEvent;
    import suiter.models.Output;

    public class CreateCommand
    {
        [Inject]
        public var triggerEvent:CreateEvent;
        [Inject]
        public var contextView:DisplayObjectContainer;

        public function execute():void
        {
            if (!triggerEvent.path)
            {
                alert("No path!", "Error");
                return;
            }
            var target:File;
            try
            {
                target = new File(triggerEvent.path);
            } catch (error:ArgumentError)
            {
                alert("Path not exists!", "Error");
                return;
            }
            if (!target.exists)
            {
                alert("Path not exists!", "Error");
                return;
            }
            if (!target.isDirectory)
            {
                alert("Not a Directory!", "Error");
                return;
            }

            write(target);

            if (triggerEvent.exitAfterCreate)
            {
                NativeApplication.nativeApplication.exit();
            }
            else
            {
                alert("Done.", "OK");
            }
        }

        private function alert(message:String, title:String = ""):void
        {
            var value:Alert = new Alert();
            value.text = message;
            value.title = title;
            PopUpManager.addPopUp(value, contextView, true);
            PopUpManager.centerPopUp(value);
        }

        private function write(target:File):void
        {
            var file:File = getOutputForSuite(target);
            var stream:FileStream = new FileStream;
            stream.open(file, FileMode.WRITE);
            stream.writeUTFBytes(new Output(target).value);
        }

        private function getOutputForSuite(file:File):File
        {
            return new File(file.url + "/AllTests.as");
        }
    }
}