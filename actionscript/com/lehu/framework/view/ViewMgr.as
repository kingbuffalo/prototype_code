package com.lehu.framework.view 
{
	import com.lehu.framework.view.interfaces.IViewMgr;
	import com.lehu.framework.view.interfaces.INotification;
	import com.lehu.framework.view.interfaces.IView;
	/**
	 * ...
	 * @author boy
	 */
	public class ViewMgr implements IViewMgr
	{
		protected static var _Instance:IViewMgr;
		
		protected var _StrMapViewArrObj:Object = new Object;
		protected var _classNameMapViewClassObj:Object = new Object;
		protected var _classNameMapViewInstanceObj:Object = new Object;
		protected var _strmapViewClassNameArrObj:Object = new Object;
		protected var _hasCreateInstanceClassNameArr:Array = [];
		
		
		public function ViewMgr() 
		{
			if (_Instance != null )
			{
				throw(new Error("ViewMgr_single_error"));
			}
		}
		
		public static function get instance():IViewMgr
		{
			if (_Instance == null )
			{
				_Instance = new ViewMgr;
			}
			return _Instance;
		}
		
		public function handleNotification(notification:INotification):void 
		{
			var instanceArrName:String = notification.name;
			var instanceArr:Array = _StrMapViewArrObj[instanceArrName] as Array;
			if (instanceArr == null ){
				return;
			}
			
			for (var i:int = 0; i <instanceArr.length ; i++) {
				var view:IView = instanceArr[i] as View;
				if ( view == null  ){
					view = getViewInstance(instanceArr[i] as String);
					instanceArr[i] = view;
				}
				view.handleNotification(notification);
			}
		}
		
		private function getViewInstance(className:String):IView {
			var result:IView = _classNameMapViewInstanceObj[className] as IView;
			if ( result == null ){
				result = new (_classNameMapViewClassObj[className] as Class);
				_classNameMapViewInstanceObj[className] = result;
			}
			return result;
		}
		
		public function sendNotification(name:String, body:Object = null, type:String = null):void 
		{
			this.handleNotification(new Notification(name, body, type));
		}
		
		public function removeNotification(name:String):void
		{
			_StrMapViewArrObj[name] = null;
		}
		public function registeView(className:String,notificationStrArr:Array, viewClass:Class):void {
			if ( _classNameMapViewClassObj[className] == null ) {
				 _classNameMapViewClassObj[className] = viewClass;
				var arr:Array = notificationStrArr;
				var classNameArr:Array;
				for (var i:int = 0; i <arr.length ; i++) 
				{
					var notificationStr:String = String(arr[i]);
					if (_StrMapViewArrObj[notificationStr] == null ){
						 classNameArr= [];
					}else{
						 classNameArr=_StrMapViewArrObj[notificationStr] as Array;
					}
					
					if ( classNameArr.indexOf(className) == -1 ){
						 classNameArr.push(className);
					}else{
						throw(new Error(notificationStr + " you register the same view again"));
					}
					_StrMapViewArrObj[notificationStr] = classNameArr;
				}
			}else {
				throw(new Error( className+ " you register the same view again"));
			}
		}
		
		public function registeViewInstance(noteArr:Array, view:IView):void{
			var arr:Array = noteArr;
			var instanceArr:Array;
			for (var i:int = 0; i <arr.length ; i++) {
				var notificationStr:String = String(arr[i]);
				if (_StrMapViewArrObj[notificationStr] == null ){
					instanceArr = [];
				}else{
					instanceArr = _StrMapViewArrObj[notificationStr] as Array;
				}
				
				if (instanceArr.indexOf(view) == -1 ){
					instanceArr.push(view);
				}else{
					throw(new Error(notificationStr + " you register the same view again"));
				}
				_StrMapViewArrObj[notificationStr] = instanceArr;
			}
		}
		
	}

}