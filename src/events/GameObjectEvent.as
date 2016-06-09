package src.events 
{
	import flash.events.Event;
	import src.gameObjects.GameObject;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameObjectEvent extends Event 
	{
		public static const ADDED:String = "added";
		public static const REMOVED:String = "removed";
		private var _gameObject:GameObject;
		public function GameObjectEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false):void 
		{
			super(type, bubbles, cancelable);
		}
		public function get gameObject():GameObject
		{
			return _gameObject;
		}
		public function set gameObject(go:GameObject):void
		{
			_gameObject = go;
		}
	}

}