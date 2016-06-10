package src 
{
	import flash.display.MovieClip;
	import src.gameLogic.GameEngine;
	import src.input.MouseController;
	import src.screens.GameScreen;
	import flash.events.Event;
	import src.screens.ScreenEngine;
	import src.screens.TitleScreen;
	import src.userInterface.TitleElement;
	import src.screens.Screen
	import src.events.GameObjectEvent;
	import src.input.KeyboardController;
	import src.mvc.ModelViewController;
	/**
	 * 
	 * ...
	 * @author erwin 
	 * 
	 * Main class controls handles the screenflow(view) and loads the gameEngine(datamodel)  
	 */
	public class Main extends MovieClip
	{

		private var gameEngine:GameEngine;
		private var screenEngine:ScreenEngine;
		private var modelViewController:ModelViewController;
		
		public function Main() 
		{							
			this.addEventListener(Event.ADDED_TO_STAGE, init);			
		}			
		/*
		 *Wait until the class' object is added to the stage
		 *Then add objects to the visible screen
		 */
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Add ScreenEngine
			screenEngine = new ScreenEngine();
			addChild(screenEngine);
			
			
			//Add GameEngine
			gameEngine = new GameEngine();
			
			//Add controller
			mvc  = new ModelViewController(gameEngine, screenEngine);
			
			
			
				
			
			
		}
		
		

		
			
	}

}