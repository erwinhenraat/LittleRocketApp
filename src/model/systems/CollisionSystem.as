package src.model.systems 
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import src.model.abillities.BoxCollider;
	import src.model.abillities.CircleCollider;
	import src.model.gameObjects.GameObject;
	import src.model.gameObjects.projectiles.Projectile;
	import src.model.abillities.Collider;
	
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
		
				
		protected override function systemAction(go:GameObject):void 
		{
			for each (var other:GameObject in _gameObjects) 
			{
				if (go == other) continue;
				if(specifficGOAbillity is BoxCollider)
				{
					//
				}
				else if (specifficGOAbillity is CircleCollider)
				{
					
					if (Math.atan2(other.y - go.y, other.x - go.x) < go.abillities[CircleCollider].range)
					{
						trace("circle collision");
					}
				}
					
				
			}
			
			
			
		}
		
	
		
	}

}