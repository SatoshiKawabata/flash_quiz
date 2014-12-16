package core
{
	import flash.display.Bitmap;
	import flash.text.Font;

	public final class Components
	{
		static private var _bitmapDatas:Object = {};
		static private var _messages:Object = {
			"test" : "テスト"
		};
		
		public function Components()
		{
		}
		
		static public function register():void
		{
			Font.registerFont(MSP);
			
		}
		
		static public function bitmap(name:String):Bitmap
		{
			if (_bitmapDatas.hasOwnProperty(name))
				return new Bitmap(_bitmapDatas[name], "always");
			else
				throw new Error("no such bitmap : " + name);
		}
		
		static public function messages(name:String):String
		{
			if (_messages.hasOwnProperty(name))
				return _messages[name];
			else
				throw new Error("no such message : " + name);
		}
	}
}