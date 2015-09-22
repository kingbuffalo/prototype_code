package com.lehu.framework.net.interfaces 
{
	
	/**
	 * ...
	 * @author boy
	 */
	public interface ILHRecCmdMgr 
	{
		function recCmd(cmd:int, serObj:Object):void;
		function regiestCmdVO(cmd:int, cmdVOClass:Class):void;
	}
	
}