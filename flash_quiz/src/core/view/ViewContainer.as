package core.view
{
	import core.ICleanable;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public final class ViewContainer implements ICleanable
	{
		private var _container:Sprite;
		private var _back:Sprite;
		private var _content:Sprite;
		private var _front:Sprite;
		
		public function ViewContainer(targetContainer:Sprite)
		{
			_container = targetContainer;
		}

		public function initialize():void
		{
			_back = new Sprite;
			_content = new Sprite;
			_front = new Sprite;
			_container.addChild(_back);
			_container.addChild(_content);
			_container.addChild(_front);
		}
		
		public function addFront(target:DisplayObject):void
		{
			_front.addChild(target);
		}
		
		public function addContent(target:DisplayObject):void
		{
			_content.addChild(target);
		}
		
		public function addBack(target:DisplayObject):void
		{
			_back.addChild(target);
		}
		
		public function clean():void
		{
			if (_container)
			{
				_container.removeChildren();
				removeFromParent(_container);
				_container = null;
			}
			if (_back)
			{
				_back.removeChildren();
				removeFromParent(_back);
				_back = null;
			}
			if (_front)
			{
				_front.removeChildren();
				removeFromParent(_front);
				_front = null;
			}
			if (_content)
			{
				_content.removeChildren();
				removeFromParent(_content);
				_content = null;
			}
		}
	}
}