package
{
	import core.Builder;
	import core.Cleaner;
	import core.Components;
	import core.view.ViewContainer;
	
	import flash.display.Sprite;
	
	import quiz.QuizController;
	import quiz.QuizModel;
	import quiz.QuizView;
	
	[SWF(width="960",  height="700",  frameRate="24",  backgroundColor="#999999")]
	
	public class flash_quiz extends Sprite
	{
		public function flash_quiz()
		{
			Components.register();
			var viewContainer:ViewContainer = new ViewContainer(this);
			var builder:Builder = new Builder();
			builder.register(Cleaner);
			builder.register(ViewContainer, viewContainer);
			builder.register(QuizModel);
			builder.register(QuizView);
			builder.register(QuizController);
			builder.create();
		}
	}
}