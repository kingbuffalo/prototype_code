package com.lehu.framework.datapool.interfaces 
{
	import com.lehu.framework.net.interfaces.ICmdVO;
	
	/**
	 * ...
	 * @author boy
	 */
	public interface IDataPoolMgr 
	{
		function regiestDataPool(dataPool:IDataPool):void;
		function recData(cmdVO:ICmdVO):void
		function removeCmd(cmd:int):void;
	}
	
}