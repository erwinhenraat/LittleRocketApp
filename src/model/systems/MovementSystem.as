package src.model.systems 
{
	import flash.display.Sprite;
	import src.model.gameObjects.GameObject;
	import flash.events.Event;

	/**
	 * ...
	 * @author erwin henraat
	 */
	public class MovementSystem extends GameSystem
	{		
		public function MovementSystem():void
		{				
					
		}					
		/*	Method is triggerd by parent class and persorms the movement of the gameobjects
		 * 
		 * 
		 */
		public override function systemAction(go:GameObject):void 
		{
			go.x += go.movementVector.x * go.movementVector.speed;
			go.y += go.movementVector.y * go.movementVector.speed;
			go.rotation = go.rotationDegrees;			
		}	
		
	}

}