package src.gameLogic 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Timer;
	import src.gameObjects.GameObject;
	import src.gameObjects.Ship;
	import flash.events.Event;
	import src.input.MouseController;
	import flash.events.TimerEvent;
	import src.events.GameObjectEvent;
	import src.gameObjects.Enemy;
	import src.gameObjects.Laser;
	import src.gameObjects.PowerUp;
	/**
	 * ...
	 * @author erwin henraat
	 * 
	 * The game engine is kept lightweight bij nog extending the movieclip class and not rendering it on the displaylist
	 * In stead the seperate GameScreen class renders the activeGameObjects on screen
	 * Whenever a GameObject is added or removed an event wil be sent for the GameScreen to update the display list.
	 * 
	 */
	public class GameEngine extends EventDispatcher 
	{
		//events that will be caught bij the gamescreen to update the display list
		public static const GameInitialized:String = "initialized";
		public static const GameObjectAdded:String = "go_added";
		public static const GameObjectRemoved:String = "go_removed";
		
		private var _collisionController:CollisionController;
		private var _wavecontroller:WaveController;
		private var _powerupCombiner:PowerupCombiner;
		private var _enemyPool:Pool;
		private var _laserPool:Pool;
		private var _powerupPool:Pool;		
		
		private var _activeGameobjects:Vector.<GameObject>;
		public function get activeGameObjects():Vector.<GameObject>
		{
			return _activeGameobjects;
		}
		
		public function GameEngine() 
		{
			_activeGameobjects = new Vector.<GameObject>();
			_wavecontroller  = new WaveController(); 
			_powerupCombiner = new PowerupCombiner();
			_enemyPool = new Pool(Enemy, 20);
			
			_laserPool = new Pool(Laser, 50);
			
			
			_powerupPool = new Pool(PowerUp , 5);
			_collisionController = new CollisionController();
			initGame();
			
			
		}
		private function initGame():void 
		{
			_activeGameobjects.push(new Ship());
			
			
			for (var i:int = 0; i < 10; i++ )
			{
				_activeGameobjects.push(_enemyPool.unpool());
				_activeGameobjects[i].x = i * 30;
			}
		
			
			
			//dispatch at the end of initialization
			dispatchEvent(new Event(GameEngine.GameInitialized));
		}
		private function addGameObject(go:GameObject):void 
		{
			_activeGameobjects.push(go);
			var goe:GameObjectEvent = new GameObjectEvent(GameObjectEvent.ADDED);
			goe.gameObject = go;
			dispatchEvent(goe);
		}
		
		private function removeGameObject(go:GameObject):void 
		{
			_activeGameobjects.splice(_activeGameobjects.indexOf(go), 1);
			var goe:GameObjectEvent = new GameObjectEvent(GameObjectEvent.REMOVED);
			goe.gameObject = go;
			dispatchEvent(goe);
		}
		
		
		
		
		
	}

}