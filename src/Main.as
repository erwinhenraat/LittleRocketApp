package src 
{
	import flash.display.Sprite;
	import flash.ui.GameInputControl;
	import src.model.GameEngine;
	import src.view.ViewEngine;
	import src.model.abillities.BoxCollider;
	/**
	 * ...
	 * @author erwin henraat
	 * 
	 * The code structure is based in the Model View Controller pattern
	 * The gameEngine(model) handles all gameplay data and actions and only renders "optionally" this datarepresentation in a lightweight and abstract way.
	 * The viewEngine(view) handles all rendering of visible animations, sprites and GUI elements.
	 * The controlEngine(controller) interprets the model data and instructs a visual implementation to the viewEngine
	 *  
	 */
	public class Main extends Sprite 
	{
		private var gameEngine:GameEngine;
		private var viewEngine:ViewEngine;
		private var controlEngine:ControlEngine;
		/* Constructor
		 * Creates and starts MVC engines 
		 * 
		 */
		public function Main() 
		{
			addChild(new BoxCollider(200, 200));
			
			gameEngine = new GameEngine();
			viewEngine = new ViewEngine();
			controlEngine = new ControlEngine(gameEngine,viewEngine);
			addChild(viewEngine);
			
			//add gameEngine to display list to see gameobjects visualisation disable code for optimal performance
			addChild(gameEngine);
			
			//start gameEngine
			gameEngine.start();
			
			
			
		
		}
		
	}

}