package presentation
{	
	import spark.components.Alert;
	
	import domain.User;
	import domain.UserManager;

	public class LoginPagePM
	{
		[Inject]
		public var userManager:UserManager;
		public function LoginPagePM()
		{
		}
		
		public function onClickSignIn(name:String, password:String) : void {
			var user:User = new User();
			user.name = name;
			user.password = password;
			Alert.show("name:"+name + " password: " + password);
			userManager.loggedUser = user;
		}
	}
}