package com.lehu.framework.net.interfaces 
{
	import com.lehu.framework.view.interfaces.INotification;
	
	/**
	 * ...
	 * @author boy
	 */
	public interface ICmdVO
	{
		function isSucceed():Boolean;
		function recSerCmd(serObj:Object, showTipOption:int = 3 ):void;
		function get cmd():int;
		function get code():int;
		function get serObj():Object;
	}
	
}