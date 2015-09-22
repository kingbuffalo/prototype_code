package com.lehu.framework.view 
{
	import com.lehu.framework.view.interfaces.INotification;
	
	/**
	 * ...
	 * @author boy
	 */
	public class Notification implements INotification 
	{
		protected var _Name:String;
		protected var _Body:Object;
		protected var _Type:String;
		
		public function Notification(name:String, body:Object=null, type:String=null) 
		{
			_Name = name;
			_Body = body;
			_Type = type;
		}
		
		/* INTERFACE com.lehu.framework.common.interfaces.INotification */
		
		public function get name():String 
		{
			return _Name;
		}
		
		public function get body():Object 
		{
			return _Body;
		}
		
		public function get type():String 
		{
			return _Type;
		}
		
	}

}