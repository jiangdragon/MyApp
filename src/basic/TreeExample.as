package basic
{
	//指定children属性为默认属性
	[DefaultProperty("children")]
	public class TreeExample
	{
		[Bindable]
		public var label:String;
		public var classRef:Class;
		public var children:Array;
		
		public function TreeExample()
		{
		}
		
	}
}