package suiter.views.mediators
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filesystem.File;
    import flash.net.FileReference;

    import org.robotlegs.mvcs.Mediator;

    import suiter.events.CreateEvent;
    import suiter.views.components.CreateView;

    public class CreateMediator extends Mediator
    {
        [Inject]
        public var view:CreateView;

        private var directory:File = new File();

        override public function onRegister():void
        {
            eventMap.mapListener(view.browseButton, MouseEvent.CLICK, browseButton_clickHandler);
            eventMap.mapListener(view.createButton, MouseEvent.CLICK, createButton_clickHandler);
        }

        private function browseButton_clickHandler(event:MouseEvent):void
        {
            directory.addEventListener(Event.SELECT, directory_selectHandler);
            directory.browseForDirectory("Please choose a test directory.");
        }

        private function createButton_clickHandler(event:MouseEvent):void
        {
            var path:String = view.pathInput.text;
            dispatch(new CreateEvent(CreateEvent.CREATE, path));
        }

        private function directory_selectHandler(event:Event):void
        {
            view.pathInput.text = directory.url;
        }
    }
}