package
{
	import flash.display.DisplayObject;
	
	public function removeFromParent(obj:DisplayObject):void
	{
		if (obj && obj.parent)
			obj.parent.removeChild(obj);
	}
}