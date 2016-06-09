package src.input 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.events.MouseEvent;

	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class MouseController extends EventDispatcher 
	{
		private var _stage:Stage;
		private var _mouseDown:Boolean = false;
		private static var _instance:MouseController;	
		public static function enable(stage:Stage):void
		{
			_instance = new MouseController();
			_instance._stage = stage;
			_instance._stage.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			_instance._stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			
		}
		
		static private function onUp(e:MouseEvent):void 
		{
			_instance._mouseDown = false;
		}
		
		static private function onDown(e:MouseEvent):void 
		{
			_instance._mouseDown = true;
		}
		
		public static function get mouseX():Number
		{
			return _instance._stage.mouseX;					
		}
		public static function get mouseY():Number
		{
			return _instance._stage.mouseY;
		}
		public static function get mouseDown():Boolean
		{
			return _instance._mouseDown;
		}

				
	}

}