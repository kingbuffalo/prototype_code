package com.lehu.framework.net 
{
	import com.lehu.framework.datapool.DataPoolMgr;
	import com.lehu.framework.datapool.interfaces.IDataPoolMgr;
	import com.lehu.framework.net.interfaces.ICmdVO;
	import com.lehu.framework.net.interfaces.ILHRecCmdMgr;
	import com.lehu.framework.view.interfaces.INotification;
	import com.lehu.framework.view.interfaces.IViewMgr;
	import com.lehu.framework.view.Notification;
	import com.lehu.framework.view.ViewMgr;
	/**
	 * ...
	 * @author boy
	 */
	public class LHRecCmdMgr implements ILHRecCmdMgr
	{
		
		protected static var _Instance:ILHRecCmdMgr;
		protected var _DataPoolMgr:IDataPoolMgr;
		protected var _ViewMgr:IViewMgr;
		protected var _cmdMapObj:Object = new Object;
		
		public function LHRecCmdMgr() 
		{
			if ( _Instance != null )
			{
				throw(new Error("LHRecCmdMgr_single_error") );
			}
			init();
		}
		
		public static function get instance():ILHRecCmdMgr
		{
			if (_Instance == null )
			{
				_Instance = new LHRecCmdMgr;
			}
			return _Instance;
		}
		
		public function recCmd(cmd:int, serObj:Object):void
		{
			//effect
			//data
			trace("rec : " + cmd);
			var cmdvo:ICmdVO = _cmdMapObj[cmd.toString()] as ICmdVO;
			if ( cmdvo == null )
			{
				var cmdClass:Class = _cmdMapObj[cmd.toString()] as Class;
				if ( cmdClass == null ) {
					throw(new Error("cmd: " + cmd.toString() + " not found"));
				}
				cmdvo = new (cmdClass) as ICmdVO;
				_cmdMapObj[cmd.toString()] = cmdvo;
			}
			cmdvo.recSerCmd(serObj);
			_DataPoolMgr.recData(cmdvo);
			//view
			var notification:INotification = new Notification(cmd.toString(), cmdvo);
			_ViewMgr.handleNotification(notification);
		}
		
		public function regiestCmdVO(cmd:int,cmdVOClass:Class):void
		{
			_cmdMapObj[cmd.toString()] = cmdVOClass;
		}
		
		protected function init():void
		{
			_DataPoolMgr = DataPoolMgr.instance;
			_ViewMgr = ViewMgr.instance;
		}
	}

}