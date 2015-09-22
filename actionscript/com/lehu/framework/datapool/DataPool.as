package com.lehu.framework.datapool 
{
	import com.lehu.framework.datapool.interfaces.IDataPool;
	import com.lehu.framework.net.interfaces.ICmdVO;
	import com.lehu.framework.net.interfaces.IRecCmd;
	import com.lehu.framework.view.interfaces.IViewMgr;
	import com.lehu.framework.view.Notification;
	import com.lehu.framework.view.ViewMgr;
	import com.lehu.game.config.AllConfig;
	import com.lehu.game.config.Language
	import com.lehu.game.ui.tooltip.LHToolTip;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author boy
	 * write function -> private
	 * read function -> public
	 */
	public class DataPool implements IDataPool, IRecCmd
	{
		private var lan:Language;
		private var _viewMgr:IViewMgr;
		
		public function DataPool() 
		{
			init();
		}
		
		public function execute(cmdVO:ICmdVO):void
		{
			//showCmdCodeTip(cmdVO.code);
		}
		
		public function get cmdList():Array
		{
			return [];
		}
		
		final public function sendNotification(name:String, body:Object = null, type:String = null):void 
		{
			_viewMgr.handleNotification(new Notification(name, body, type));
		}
		
		final public function remvoeCmdListener(cmd:int):void
		{
			DataPoolMgr.instance.removeCmd(cmd);
		}
		
		/*****************protected***********/
		private function init():void
		{
			_viewMgr = ViewMgr.instance;
			lan = AllConfig.instance.lanConfig;
		}
		
		/************private**********************/
		//protected function showCmdCodeTip(cmdVO:ICmdVO):void
		//{
			//var index:int = cmdVO.code;
			//if (index == 1)
			//{
				//index = 0;
			//}
			//else
			//{
				//index = -index;
			//}
			//var arr:Array = lan.getCmdCodeTipArr(cmdVO.cmd);
			//if ( arr == null )
			//{
				//trace(cmdVO.code.toString() + " not found");
				//return;
			//}
			//LHToolTip.getInstance().showTypeMessage(arr[index], LHToolTip.MSG_TYPE_MOVE_UP);
		//}
	}

}