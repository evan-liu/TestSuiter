package suiter
{
    import flash.display.DisplayObjectContainer;
    import flash.events.InvokeEvent;

    import org.robotlegs.mvcs.Context;

    import suiter.commands.CreateCommand;
    import suiter.events.CreateEvent;
    import suiter.views.components.CreateView;
    import suiter.views.mediators.CreateMediator;

    public class SuiterContext extends Context
    {
        public function SuiterContext(contextView:DisplayObjectContainer = null)
        {
            super(contextView);
        }

        override public function startup():void
        {
            super.startup();

            mediatorMap.mapView(CreateView, CreateMediator);

            commandMap.mapEvent(CreateEvent.CREATE, CreateCommand);

            contextView.addEventListener(InvokeEvent.INVOKE, invokeHandler);
        }

        private function invokeHandler(event:InvokeEvent):void
        {
            var arguments:Array = event.arguments;
            if (arguments.length == 0)
            {
                return;
            }
            var path:String = arguments[0];
            if (path)
            {
                // Exit after create by default. Or set the sectond argument is false otherwise.
                var exitAfterCreate:Boolean = arguments.length == 1 || arguments[1] != "false";
                dispatchEvent(new CreateEvent(CreateEvent.CREATE, path, exitAfterCreate));
            }
        }
    }
}