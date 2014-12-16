package quiz
{
	import core.ICleanable;

	public final class QuizController
	{
		private var _model:QuizModel;
		
		public function set model(value:QuizModel):void{_model = value;}
		
		public function QuizController()
		{
		}

		public function initialize():void
		{
		}
		
		public function clean():void
		{
		}
	}
}