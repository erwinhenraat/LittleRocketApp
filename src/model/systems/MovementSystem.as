package src.model.systems 
{
	import flash.display.Sprite;
	import src.model.gameObjects.GameObject;
	import flash.events.Event;
	import src.model.systems.IGameSystem;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class MovementSystem extends GameSystem implements IGameSystem
	{		
		public function MovementSystem():void
		{				
					
		}					
		public override function systemAction(go:GameObject):void 
		{
			//trace("movement action performs");
			go.x += go.movementVector.x * go.movementVector.speed;
			go.y += go.movementVector.y * go.movementVector.speed;
			go.rotation = go.rotationDegrees;
						
			//trace("new pos x : " + go.x + "; pos y : " + go.y);
		}
		
	}

}