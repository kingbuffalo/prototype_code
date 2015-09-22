package com.lehu.framework.cdb {
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author boy
	 */
	public class ClientDBMgr {
		
		private static var _instance:ClientDBMgr;
		private var _dbDict:Dictionary;
		
		public function ClientDBMgr() {
			_dbDict = new Dictionary();
		}
		
		public static function get instance():ClientDBMgr {
			if ( _instance == null )
				_instance = new ClientDBMgr();
			return _instance;
		}
		
		public function runFunWithData(tblName:String, conditionFun:Function, runFun:Function):void {
			if ( _dbDict[tblName] == null ) {
				loadDb(tblName,runFun);
			}else {
				runFun(_dbDict[tblName]);
			}
		}
		
		private function loadDb(tblName:String, runFun:Function):void {
			DataLoaderFac.instance.load(tblName, runFun);
		}
		
		public function recCmd(cmd:String, value:*):void {
			_dbDict[cmd] = value;
		}
		
	}

}