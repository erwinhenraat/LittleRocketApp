package src.input 
{
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class KeyboardController extends EventDispatcher
	{
		private static var _stage:Stage;
		private static var _anyKeyDown:Boolean;
		public static function enable(stage:Stage):void
		{
			_stage = stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
						
		}		
		private static function onKeyUp(e:KeyboardEvent):void 
		{
			_anyKeyDown = false;
		}
		
		private static function onKeyDown(e:KeyboardEvent):void 
		{
			_anyKeyDown = true;
		}
		 
		public static function get anyKey():Boolean
		{
			return _anyKeyDown;
			
		}
	
		
	}

}