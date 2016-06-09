package src.input 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	import src.events.MousePositionEvent;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class MouseController extends EventDispatcher 
	{
		private var _stage:Stage;
		private static var _instance:MouseController;	
		public static function init(stage:Stage):void
		{
			_instance = new MouseController();
			_instance._stage = stage;
			
		}
		public static function get mouseX():Number
		{
			return _instance._stage.mouseX;					
		}
		public static function get mouseY():Number
		{
			return _instance._stage.mouseY;
		}	
				
	}

}