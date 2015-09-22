package com.adobe.utils 
{
	/**
	 * ...
	 * @author GuangGuangDang
	 */
	public class traceObject
	{
		
		public function traceObject() 
		{
			
		}
		public static function print(_obj:Object):void{
			var txt:String = "";
			for (var i:* in _obj) {
				if (txt != "") {
					txt += ", ";
				}
				txt += i+"="+_obj[i];
			}
			traceObject._trace("{"+txt+"}");
		}
		
		/**
		 * //boy
		 * 浏览代码时无意中看到有个traceObject.
		 * 所以补上我以前在不知道fireBug分析jsonObj的函数.
		 */
		//专门用来测试jsonObj的		
		private static var testStr:String = "";
		public static function myTrace(obj:Object):void
		{
			if ( obj == null )
			{
				traceObject._trace("null");
				return;
			}
			testStr = "";
			analysisJsonObj(" ", obj);
			traceObject._trace(testStr);
		}
		
		public static function _trace(obj:*):void
		{
			trace(String(obj));
		}
		
		private static function analysisJsonObj(str:String, obje:Object):void
		{
			var i:int = 0;
			if ( obje is Array )
			{
				testStr = testStr.slice(0,testStr.length-1);
				testStr += " is Array length="+(obje as Array).length.toString() + "\n";
				if ( (obje as Array).length > 0 )
				{
					analysisJsonObj(str+str,obje[0]);
				}
			}
			else
			{
				for ( var objStr:String in obje )
				{
					i ++;
					var strTemp:String = obje[objStr].toString().charAt(0)=="["  ? "" : obje[objStr];
					testStr += str+objStr + ' ' + strTemp+ " "+'\n';
					analysisJsonObj(str+str,obje[objStr]);
				}
			}
			if ( i>0 )
			{
				testStr += '\n';
			}
		}
		
	}

}