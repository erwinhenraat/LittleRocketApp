package src.model.systems 
{
	import flash.display.Sprite;
	import src.model.abillities.Abillity;
	import src.model.abillities.Movement;
	import src.model.gameObjects.GameObject;
	import flash.events.Event;
	import src.utils.MovementVector;
	

	/**
	 * ...
	 * @author erwin henraat
	 */
	public class MovementSystem extends GameSystem
	{		
		public function MovementSystem(gameObjects:Vector.<GameObject>):void
		{						
			nescesary = Movement;
			
			super(gameObjects);
		}					
		/*	Method is triggerd by parent class and persorm the movement of the gameobjects
		 * 
		 * 
		 */		
		protected override function systemAction(go:GameObject):void 
		{
			//var movementVector:MovementVector = go.abillities[GetClassName.getNameFromClass(Movement)].movementVector;
			var movementVector:MovementVector = go.abillities[Movement].movementVector;
			go.x += movementVector.x * movementVector.speed;
			go.y += movementVector.y * movementVector.speed;
			go.rotation += go.abillities[Movement].rotationDegrees;
			
			
			
		}	
		
	}

}