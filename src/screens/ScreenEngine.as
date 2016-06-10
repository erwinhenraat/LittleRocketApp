package src.screens 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class ScreenEngine extends MovieClip 
	{
		private var titleScreen:TitleScreen;
		private var gameScreen:GameScreen;
		public function ScreenEngine() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			//add the introscreen
			titleScreen = new TitleScreen();
			this.addChild(titleScreen);
			
			
			gameScreen = new GameScreen();	
			
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