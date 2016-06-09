package src.gameLogic 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import src.gameObjects.GameObject;

	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameEngine extends EventDispatcher 
	{
		private var activeGameobjects:Vector.<GameObject>;
		private var wavecontroller:WaveController;
		private var powerupCombiner:PowerupCombiner;
		private var enemyPool:Pool;
		private var laserPool:Pool;
		private var powerupPool:Pool;
		public function GameEngine() 
		{
			activeGameobjects = new Vector.<GameObject>();
			wavecontroller  = new WaveController(); 
			powerupCombiner = new PowerupCombiner();
			enemyPool = new Pool();
			laserPool = new Pool();
			powerupPool = new Pool();
			collisionController = new CollisionController();
			
		}
		
	}

}