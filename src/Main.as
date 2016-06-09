package src 
{
	import flash.display.MovieClip;
	import src.gameLogic.GameEngine;
	import src.input.MouseController;
	import src.screens.GameScreen;
	import flash.events.Event;
	import src.screens.TitleScreen;
	import src.userInterface.TitleElement;
	import src.screens.Screen
	import src.events.GameObjectEvent;
	import src.input.KeyboardController;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Main extends MovieClip
	{
		private var titleScreen:TitleScreen;
		private var gameScreen:GameScreen;
		private var gameEngine:GameEngine;
		
		public function Main() 
		{
	
			titleScreen = new TitleScreen();
			gameScreen = new GameScreen();			
			
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}		
	
		
		/*
		 *Wait until the class' object is added to the stage
		 *Then add objects to the visible screen
		 */
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//add the introscreen
			this.addChild(titleScreen);
			
			
			//initialize the mousecontroller
			MouseController.enable(stage);
			
			//initialize KeyboardController
			KeyboardController.enable(stage);
			
			this.addEventListener(Event.ENTER_FRAME, waitForInput);
			
		}
		
		private function waitForInput(e:Event):void 
		{
			//Wait until input is given
			if (contains(titleScreen) && KeyboardController.anyKey || MouseController.mouseDown)
			{
				//Start the gameengine and show gamescreen				
				this.removeEventListener(Event.ENTER_FRAME, waitForInput);
				removeChild(titleScreen);
				
				gameEngine = new GameEngine();
				gameEngine.addEventListener(GameObjectEvent.ADDED, addGOtoGameScreen);
				gameEngine.addEventListener(GameObjectEvent.REMOVED, removeGOtoGameScreen);
			
				gameScreen = new GameScreen();
				addChild(gameScreen);
				gameScreen.showActive(gameEngine.activeGameObjects);
			
			}
		}
		private function addGOtoGameScreen(e:GameObjectEvent):void 
		{
			gameScreen.addGameObject(e.gameObject);
		}
		private function removeGOtoGameScreen(e:GameObjectEvent):void 
		{
			gameScreen.removeGameObject(e.gameObject);
		}		
		
			
	}

}