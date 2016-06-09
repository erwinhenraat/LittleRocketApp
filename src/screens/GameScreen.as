package src.screens 
{
	import src.gameObjects.GameObject;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameScreen extends Screen 
	{
		
		public function GameScreen() 
		{
			
		}
		/*
		 * Shows a single gameobject
		 */
		public function addGameObject(go:GameObject):void
		{
			addChild(go);
			
		}
		/*
		 * hides a single gameobject
		 */
		public function removeGameObject(go:GameObject):void
		{
			removeChild(go);
			
		}		
		/*
		 * Shows all active gameobjects
		 */
		public function showActive(activeGameObjects:Vector.<GameObject>):void
		{
			for each (var go:GameObject in activeGameObjects)
			{
				if (!this.contains(go))
				{
					addChild(go);
					
				}
			}			
		}
		/*
		 * Hides all inactive gameobjects
		 */
		public function hideInactive(activeGameObjects:Vector.<GameObject>):void
		{
			//Check if any of the screens children are not found in the activeGameObjects
			for (var i:int = numChildren - 1; i >= 0; i-- )
			{
				var go:GameObject = this.getChildAt(i) as GameObject;							
				if (activeGameObjects.indexOf( go ) < 0)
				{					
					removeChild(go);
				}
			}
			
		}
			
	}

}