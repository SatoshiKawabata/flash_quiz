package quiz
{
	import core.Cleaner;

	public final class QuizModel
	{
		private var _cleaner:Cleaner;
		private var _view:QuizView;
		

		public function set view(value:QuizView):void{_view = value;}
		public function set cleaner(value:Cleaner):void{_cleaner = value;}
		
		public function QuizModel()
		{
		}
		

		public function initialize():void
		{
		}
		
		public function close():void
		{
			_cleaner.clean();
			_cleaner = null;
		}
	}
}