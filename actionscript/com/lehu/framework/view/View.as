package com.lehu.framework.view {
	import com.lehu.framework.view.interfaces.INotification;
	import com.lehu.framework.view.interfaces.IView;
	import com.lehu.framework.view.interfaces.IViewMgr;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author boy
	 */
	public class View implements IView {
		private var _viewMgr:IViewMgr;
		protected var _ViewComponent:DisplayObjectContainer
		
		public function View(viewCompont:DisplayObjectContainer = null) {
			_ViewComponent = viewCompont;
			init();
		}
		
		/* INTERFACE com.lehu.framework.view.interfaces.IView */
		
		public function handleNotification(notification:INotification):void {
		
		}
		
		final public function sendNotification(name:String, body:Object = null, type:String = null):void {
			_viewMgr.handleNotification(new Notification(name, body, type));
		}
		
		final public function removeNotification(name:String):void {
			_viewMgr.removeNotification(name);
		}
		
		//public function listnotifications():Array {
			//return [];
		//}
		
		protected function init():void {
			_viewMgr = ViewMgr.instance;
		}
	}

}