package presentation
{
	import spark.components.Alert;
	
	import domain.User;

	public class LoginPagePM
	{
		public var user:User = new User();
		
		public function LoginPagePM()
		{
		}
		
		public function onClickSignIn(name:String, password:String) : void {
			user.name = name;
			user.password = password;
			Alert.show("name:"+name + " password: " + password);
		}
	}
}