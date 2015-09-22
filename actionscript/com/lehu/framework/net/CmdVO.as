package com.lehu.framework.net 
{
	import com.lehu.framework.net.interfaces.ICmdVO
	import com.lehu.game.config.AllConfig;
	import com.lehu.game.net.cmdvo.utils.LHCmdFunction;
	import com.lehu.game.ui.tooltip.LHToolTip;
	/**;
	 * ...
	 * @author boy
	 */
	public class CmdVO implements ICmdVO 
	{
		public static var SHOW_ERROR_CODE_TIP:int = 0x1 << 1;
		public static var SHOW_SUCCEED_CODE_TIP:int = 0x1;
		public static var SHOW_ALL_CODE_TIP:int = SHOW_SUCCEED_CODE_TIP | SHOW_ERROR_CODE_TIP;
		public static var SHOW_NONE_TIP:int = 0;
		
		private static var _unShowTipCmdArr:Array = [];
		
		protected var _Cmd:int;
		protected var _Code:int;
		protected var _SerObj:Object;
		
		public function CmdVO() 
		{
		}
		
		public function recSerCmd(serObj:Object, showTipOption:int = 0 ):void
		{
			if ( serObj != null )
			{
				_SerObj = serObj;
				_Cmd = serObj.cmd;
				if ( serObj.code )
					_Code = serObj.code;
				else
					_Code = 1;
			}
			if ( _unShowTipCmdArr.indexOf(_Cmd ) == -1 )
			{
				if ( (_Code == 1 && Boolean(showTipOption & SHOW_SUCCEED_CODE_TIP ))
					|| (_Code < 0 && Boolean(showTipOption & SHOW_ERROR_CODE_TIP )) )
				{
					showCmdCodeTipStr();
				}
			}
			//if ( _unShowTipCmdArr.indexOf(_Cmd) == -1 && showTipOption )
				//showCmdCodeTipStr();
		}
		
		//final public function cloneCmdVO(cmdClass:Class):ICmdVO
		//{
			//var result:ICmdVO = new (cmdClass(_Cmd));
			//result.recSerCmd(_SerObj,false);
			//return result;
		//}
		
		public function isSucceed():Boolean
		{
			return _Code == 1;
		}
		
		public function get cmd():int
		{
			return _Cmd;
		}
		public function get code():int
		{
			return _Code;
		}
		
		public function get serObj():Object
		{
			return _SerObj;
		}
		
		public function showCmdCodeTipStr():String
		{
			var index:int = _Code > 0 ? 0 : -_Code;
			var str:String = AllConfig.instance.lanConfig.getLanArrIndexStr(cmd.toString(), index);
			trace("cmd = " + _Cmd.toString() + " code = " + _Code.toString() + "------>" +str);
			LHToolTip.getInstance().showMessage(str);
			return str;
		}
		
		/**
		 * 用来合成协议
		 */
		protected function sendCmd(cmd:int, serObj:Object):void
		{
			LHRecCmdMgr.instance.recCmd(cmd, serObj);
		}
		
		protected function regiestUnShowTipCmd(cmd:int):void
		{
			_unShowTipCmdArr.push(cmd);
		}
		
		protected function formatArr(voClass:Class, serObjArr:Array):Array
		{
			return LHCmdFunction.instance.formatArr(voClass, serObjArr);
		}
		
		protected function formatArrHasArr(voClass:Class, serObjArr:Array,voArr:Array):void
		{
			LHCmdFunction.instance.formatArrHasArr(voClass, serObjArr,voArr);
		}
		
	}

}