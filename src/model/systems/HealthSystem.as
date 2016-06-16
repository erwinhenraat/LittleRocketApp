package src.model.systems 
{
	import src.model.abillities.Health;
	import src.model.events.GameEvent;
	import src.model.gameObjects.GameObject;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class HealthSystem extends GameSystem 
	{
		
		public function HealthSystem() 
		{
			this.addEventListener(GameEvent.HEALTH_COMPONENT_ADDED, createEventListeners)
		}
		
		private function createEventListeners(e:GameEvent):void 
		{
			trace("hc added");
			var healthComponent:Health = e.target as Health;
			var go:GameObject = healthComponent.gameObject;
			go.addEventListener(GameEvent.COLLISION, onCollision);
		}
		
		private function onCollision(e:GameEvent):void 
		{
			trace("onCollision");
			var go:GameObject = e.target as GameObject;
			var hc:Health = go.abillities[Health] as Health;
			hc.amount--;
			if (hc.amount <= 0)
			{
				go.dispatchEvent(new GameEvent(GameEvent.GAMEOBJECT_DIES));
				go.removeEventListener(GameEvent.COLLISION, onCollision);
			}
			
			
		}
		
		
	}

}