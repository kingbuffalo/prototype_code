package com.lehu.framework.view.interfaces 
{
	
	/**
	 * ...
	 * @author boy
	 */
	public interface IViewMgr extends IObserver
	{
		function registeViewInstance( noteArr:Array,view:IView):void;
		function registeView(className:String, notificationStrArr:Array, viewClass:Class):void;
	}
	
}