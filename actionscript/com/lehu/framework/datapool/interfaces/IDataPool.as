package com.lehu.framework.datapool.interfaces 
{
	import com.lehu.framework.net.interfaces.IRecCmd;
	/**
	 * ...
	 * @author boy
	 */
	public interface IDataPool extends IRecCmd
	{
		//function recData(cmdVO:ICmdVO):void
		function get cmdList():Array;
	}
	
}