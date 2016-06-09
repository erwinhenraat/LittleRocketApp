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
	import src.events.MousePositionEvent;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Main extends MovieClip
	{
		private var screens:Vector.<Screen>;
		private var gameEngine:GameEngine;
		
		public function Main() 
		{
			screens = new Vector.<Screen>;
			screens.push(new TitleScreen());
			screens.push(new GameScreen());
			
			
			gameEngine = new GameEngine();
			
			
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
			this.addChild(screens[0]);
			
			//initialize the mousecontroller
			MouseController.init(stage);
			
			
			
		}
			
	}

}