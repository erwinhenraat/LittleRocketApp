package src 
{
	import flash.display.Sprite;
	import flash.ui.GameInputControl;
	import src.model.GameEngine;
	import src.view.ViewEngine;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Main extends Sprite 
	{
		private var gameEngine:GameEngine;
		private var viewEngine:ViewEngine;
		private var controlEngine:ControlEngine;
		
		public function Main() 
		{
			gameEngine = new GameEngine();
			viewEngine = new ViewEngine();
			controlEngine = new ControlEngine(gameEngine,viewEngine);

			addChild(viewEngine);
			
			//add gameEngine to display list to see gameobjects visualisation
			addChild(gameEngine);
			
			//start gameEngine
			gameEngine.start();
		}
		
	}

}