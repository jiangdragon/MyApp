package basic
{
	import mx.containers.HBox;
	
	public class Example extends HBox
	{
		private var _step:int;
		[Bindable] public var controls:Array;
		public function Example()
		{
			super();
			this.percentWidth = 100;
			this.percentHeight = 100;
		}
		/**
		 * 描述
		 */
		public function get descriptions():Array{
			return [];
		}
		/**
		 * 当前描述
		 */
		[Bindable("stepChange")]
		public function get currentDescription():String{
			return descriptions[_step];
		}
		
		public function start():void{
			
		}
		
		public function stop():void{
			
		}
	}
}