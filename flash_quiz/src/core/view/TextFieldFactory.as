package core.view
{
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public final class TextFieldFactory
	{
		public function TextFieldFactory()
		{
		}
		
		static public function create(text:String, size:int = 11, color:uint = 0):TextField
		{
			var tf:TextField = new TextField();
			tf.text = text;
			var fmt:TextFormat = new TextFormat("フォント 1", size, color);
			fmt.size = size;
			fmt.color = color;
			tf.defaultTextFormat = fmt;
			return tf;
		}
	}
}