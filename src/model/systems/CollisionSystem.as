package src.model.systems 
{
	import fl.controls.NumericStepper;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import src.model.colliders.BoxCollider;
	import src.model.colliders.CircleCollider;
	import src.model.gameObjects.GameObject;
	import src.model.gameObjects.projectiles.Projectile;
	import src.model.colliders.Collider;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class CollisionSystem extends GameSystem
	{
			
		public function CollisionSystem(gameObjects:Vector.<GameObject>) 
		{
			nescesary = Collider;
			super(gameObjects);
		}				
		protected override function loop(e:Event):void
		{
			for each (var go:GameObject in _gameObjects)
			{
				if (go.collider != null)
				{
					systemAction(go);
				}				
			}
		}
		protected override function systemAction(go:GameObject):void 
		{
			for each (var other:GameObject in _gameObjects) 
			{
				
				var dx:Number = Math.abs(go.x - other.x); 
				var dy:Number = Math.abs(go.y - other.y);
				
				if (go == other) continue;
				if(go.collider is BoxCollider)
				{					
					//trace("BOX COLLIDER");
				}
				else if (go.collider is CircleCollider)
				{					
					//trace("circle collision");
					
					if( Math.atan2(dy,dx) < )
					
				}					
				
			}			
			
		}	
		
	}

}