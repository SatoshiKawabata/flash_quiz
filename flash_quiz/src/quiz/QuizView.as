package quiz
{
	import core.Components;
	import core.ICleanable;
	import core.view.TextFieldFactory;
	import core.view.ViewContainer;
	
	import flash.display.Shape;
	import flash.text.TextField;

	public final class QuizView
	{
		private var _viewContainer:ViewContainer;
		private var _controller:QuizController;
		
		public function set controller(value:QuizController):void{_controller = value;}
		public function set viewContainer(value:ViewContainer):void{_viewContainer = value;}
		
		public function QuizView()
		{
		}
		
		public function initialize():void
		{
			var sp:Shape = new Shape();
			sp.graphics.beginFill(0xff0000);
			sp.graphics.drawCircle(100, 100, 100);
			sp.graphics.endFill();
			_viewContainer.addBack(sp);
			var tf:TextField = TextFieldFactory.create(Components.messages("test"), 100);
			_viewContainer.addFront(tf);
		}
		
		public function clean():void
		{
			
		}
	}
}