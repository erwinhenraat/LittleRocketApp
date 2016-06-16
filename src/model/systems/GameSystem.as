package src.model.systems 
{
	import flash.display.Sprite;
	import src.model.abillities.Abillity;
	import src.model.gameObjects.GameObject;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameSystem extends Sprite
	{		
		protected var _gameObjects:Vector.<GameObject>;
		protected var nescesary:Class;
		protected var specifficGOAbillity:Abillity;		
		public function GameSystem(gameObjects:Vector.<GameObject> = null) 
		{
			_gameObjects = gameObjects;
			this.addEventListener(Event.ENTER_FRAME, loop);	
		}		
		protected function loop(e:Event):void 
		{			
			//trace("Abstract loop function calls");				
		}					
		protected function systemAction(go:GameObject):void
		{
			//trace("abstract system action performs");
		}			
	}
}