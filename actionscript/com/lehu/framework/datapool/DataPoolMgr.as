package com.lehu.framework.datapool 
{
	import com.lehu.framework.net.interfaces.ICmdVO;
	import com.lehu.framework.datapool.interfaces.IDataPool;
	import com.lehu.framework.datapool.interfaces.IDataPoolMgr;
	
	/**
	 * ...
	 * @author boy
	 */
	public class DataPoolMgr implements IDataPoolMgr 
	{
		protected static var _Instance:IDataPoolMgr;
		private var _cmdMapDataPool:Object = new Object;
		
		public function DataPoolMgr() 
		{
			
		}
		
		public static function get instance():IDataPoolMgr
		{
			if (_Instance == null )
			{
				_Instance = new DataPoolMgr;
			}
			return _Instance;
		}
		
		/* INTERFACE com.lehu.framework.datapool.interfaces.IDataPoolMgr */
		
		public function regiestDataPool(dataPool:IDataPool):void 
		{
			var arr:Array = dataPool.cmdList;
			var instanceArr:Array;
			for (var i:int = 0; i <arr.length ; i++) 
			{
				var cmdStr:String = String(arr[i]);
				if (_cmdMapDataPool[cmdStr] == null )
				{
					instanceArr = [];
				}
				else
				{
					instanceArr = _cmdMapDataPool[cmdStr] as Array;
				}
				
				if (instanceArr.indexOf(dataPool) == -1 )
				{
					instanceArr.push(dataPool);
				}
				else
				{
					throw(new Error("you register the same datapool once more"));
				}
				_cmdMapDataPool[cmdStr] = instanceArr;
			}
		}
		
		public function recData(cmdVO:ICmdVO):void 
		{
			var instanceArr:Array = _cmdMapDataPool[cmdVO.cmd.toString()] as Array;
			
			if (instanceArr == null  )
			{
				return;
			}
			
			for (var i:int = 0; i <instanceArr.length ; i++) 
			{
				var dataPoolInstance:IDataPool = instanceArr[i] as IDataPool;
				dataPoolInstance.execute(cmdVO);
			}
		}
		
		public function removeCmd(cmd:int):void
		{
			_cmdMapDataPool[cmd.toString()] = null;
		}
		
	}

}