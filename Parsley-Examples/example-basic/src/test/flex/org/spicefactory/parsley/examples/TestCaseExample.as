package org.spicefactory.parsley.examples
{
	import flexunit.framework.Assert;

	public class TestCaseExample
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testGreeting():void {
			var name:String = "Buck Rogers";
			var expectedGreeting:String = "Hello, Buck Rogers";
			var result:String = App.greeting(name);
			Assert.assertEquals("Greeting is incorrect", expectedGreeting, result);
		}
	}
}