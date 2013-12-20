package presentation
{
	import flash.events.Event;
	
	import mx.controls.Alert;
	import mx.utils.ObjectProxy;
	
	import domain.User;

	public class MainPM
	{
		[Inject]
		public var user:User;
		
		[Inject(id="flashVars")]
		public var globalParameter:ObjectProxy;
		
		public function MainPM()
		{
		}
		
		public function onClick(event:Event):void {
			Alert.show("user: " + user);
			Alert.show("globalParameter: " + globalParameter);
		}
	}
}