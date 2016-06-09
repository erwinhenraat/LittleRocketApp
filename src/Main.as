package src 
{
	import flash.display.MovieClip;
	import src.screens.GameScreen;
	import flash.events.Event;
	import src.screens.TitleScreen;
	import src.userInterface.TitleElement;
	import src.screens.Screen;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Main extends MovieClip
	{
		private var screens:Vector.<Screen>;
		
		public function Main() 
		{
			screens = new Vector.<Screen>;
			screens.push(new TitleScreen());
			screens.push(new GameScreen());
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addChild(screens[0]);
			
		}
		
	}

}