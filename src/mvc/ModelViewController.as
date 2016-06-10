package src.mvc 
{
	import src.gameLogic.GameEngine;
	import src.screens.ScreenEngine;
	import src.input.MouseController;
	import src.input.KeyboardController;
	/**
	 * ...
	 * @author erwin henraat
	 * 
	 * 
	 * Catches data events from the model / gameengine and instructs the view / screenEngine to show gameobjects
	 * 
	 */
	public class ModelViewController 
	{
		private var _gameEngine:GameEngine;
		private var _screenEngine:ScreenEngine;
		public function ModelViewController(gameEngine:GameEngine, screenEngine:ScreenEngine) 
		{
			_gameEngine = gameEngine;
			_screenEngine = screenEngine;
			
			//initialize the mousecontroller
			MouseController.enable(stage);
			
			//initialize KeyboardController
			KeyboardController.enable(stage);
			
			
		}
		
	}

}