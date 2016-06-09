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
			var e = new element();
			if (e is UIElement)
			{
				addChild(e);
			}
			else
			{
				throw new Error("added class is not a UIElement");
			}
		}
		
	}

}