package src.model.abillities 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import src.model.gameObjects.GameObject;
	
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Abillity extends EventDispatcher
	{
		private var _gameObject:GameObject;
		public function Abillity(gameObject:GameObject = null) 
		{
			_gameObject = gameObject;
		}
		public function get gameObject():GameObject
		{ 
			return _gameObject; 
			
		}
	}

}