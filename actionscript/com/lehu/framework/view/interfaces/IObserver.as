package com.lehu.framework.view.interfaces 
{
	
	/**
	 * ...
	 * @author boy
	 */
	public interface IObserver 
	{
		function handleNotification(notification:INotification):void;
		function sendNotification(name:String, body:Object = null, type:String = null):void;
		function removeNotification(name:String):void;
	}
	
}