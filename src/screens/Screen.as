package src.screens 
{
	import flash.display.MovieClip;
	import flash.text.engine.ElementFormat;
	import src.userInterface.UIElement;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Screen extends MovieClip 
	{
		
		public function Screen() 
		{
		
			
		}
		
		public function addUIElement(element:Class):void
		{
			
			addChild(new element());
			
		}
		
	}

}