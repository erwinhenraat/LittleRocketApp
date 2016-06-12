package src 
{
	import flash.display.Sprite;
	import src.model.GameEngine;
	import src.view.ViewEngine;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class ControlEngine extends Sprite 
	{
		private var _gameEngine:GameEngine;
		private var _viewEngine:ViewEngine;
		public function ControlEngine(ge:GameEngine, ve:ViewEngine):void 
		{
			_gameEngine = ge;
			_viewEngine = ve;
			
			addChild(_gameEngine);
			addEventListeners();
		}
		/*	Add eventlisteners to the game engine to catch all events that need to trigger methods of the view engine
		 * 
		 * 
		 */
		private function addEventListeners():void 
		{
			
			//_gameEngine.addEventListener();
		}
		
	}

}