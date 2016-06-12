package src.model.abillities 
{
	import src.model.gameObjects.GameObject;
	import src.utils.MovementVector;
	import src.model.systems.MovementSystem;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Move extends Abillity 
	{
		
		public function Move(go:GameObject, ms:MovementSystem) 
		{
			//create a necessary movememntvector object
			go.movementVector = new MovementVector();
			//add gameobject to movementsystem list
			ms.list.push(go);

			
		}

	}

}