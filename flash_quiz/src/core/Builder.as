package core
{
	import flash.utils.describeType;
	
	public class Builder
	{
		
		private var map:Object = {};
		private var waiting:Object = {};
		private var inits:Array = [];
		private var cleanables:Vector.<ICleanable> = new Vector.<ICleanable>();
		
		public function Builder()
		{
		}
			
		public function create():void
		{
			while (inits.length > 0)
			{
				var instance:Object = inits.shift();
				if (instance.hasOwnProperty("initialize"))
				{
					var func:Function = instance["initialize"] as Function;
					if (func != null && func.length == 0) func.call();
				}
			}
			
			var cleaner:Cleaner = map["core::Cleaner"];
			if (cleaner == null) return;
			while (cleanables.length > 0)
			{
				var cleanable:ICleanable = cleanables.shift();
				cleaner.add(cleanable);
			}
		}
		
		public function register(
			clazz:Class, 
			instance:* = null):void
		{
			instance = instance == null ? new clazz() : instance;
			var xml:XML = describeType(instance);
			var name:String = xml.@name;
			//登録してある場合は終了
			if (map[name] != null) return;
			
			inits.push(instance);
			var iface:XMLList = xml.implementsInterface;
			if (checkCleanable(iface)) cleanables.unshift(instance);
			
			registerInterface(instance, iface);
			registerClass(instance, name);
			
			checkAccessor(instance, xml.variable);
			var s:XMLList = xml.variable;
			checkAccessor(instance, xml.accessor);
		}
		
		private function checkAccessor(instance:*, list:XMLList):void
		{
			var i:int;
			var len:int = list.length();
			var type:String;
			var param:XML;
			var x:XML;
			var target:*;
			var iface:XMLList;
			for (i = 0; i  < len; i++)
			{
				param = list[i];
				type = param.@type;
				
				if (type.indexOf("flash") == 0) continue;
				if (type == "int" || type == "uint" || type == "String" || type == "Number" || type == "Array" || type == "Object" || type == "Boolean" || type.indexOf("Vector") > -1) continue;
				
				if (param.@access != "writeonly")
				{
					if (map[type] == null && instance[param.@name] != null)
					{
						target = instance[param.@name];
						x = describeType(target);
						registerInterface(target, x.implementsInterface);
						registerClass(target, x.@name);
					}
				}
				
				if (param.@access == "readonly") continue;
				
				if (map[type] != null)
					instance[param.@name] = map[type];
				else
				{
					if (waiting[type] == null) waiting[type] = [];
					waiting[type].push(new WaitingData(instance, param.@name, type));
				}
			}
		}
		
		private function registerClass(instance:*, name:String):void
		{
			if (map[name] != null) return;
			map[name] = instance;
			checkWaitingList(instance, name);
		}
		
		private function registerInterface(instance:*, iface:XMLList):void
		{
			var i:int;
			var len:int = iface.length();
			var type:String;
			for (i = 0; i < len; i++)
			{
				type = iface[i].@type;
				if (type.indexOf("flash") == 0 ) continue;
				if (type == "core::ICleanable") continue;
				if (map[type] == null)
				{
					map[type] = instance;
					//interfaceで参照しているやつらを探す
					checkWaitingList(instance, type);
				}
			}
		}
		
		private function checkWaitingList(instance:*, type:String):void
		{
			if (waiting[type] != null)
			{
				var arr:Array = waiting[type];
				var i:int;
				var len:int = arr.length;
				var data:WaitingData;
				for (i = 0; i < len; i++)
				{
					data = arr[i];
					data.target[data.name] = instance;
				}
			}
			delete waiting[type];
		}
		
		private function checkCleanable(iface:XMLList):Boolean
		{
			var i:int;
			var len:int = iface.length();
			var type:String;
			for (i = 0; i < len; i++)
			{
				type = iface[i].@type;
				if (type == "core::ICleanable") return true;
			}
			return false;	
		}
	}
}

class WaitingData
{
	public var target:*;
	public var name:String;
	public var type:String;
	
	public function WaitingData(target:*, name:String, type:String)
	{
		this.target = target;
		this.name = name;
		this.type = type;	
	}
}