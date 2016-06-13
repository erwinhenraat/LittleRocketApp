package src.model.systems 
{
	import flash.display.Sprite;
	import src.model.abillities.Abillity;
	import src.model.gameObjects.GameObject;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameSystem extends Sprite
	{
		
		protected var _gameObjects:Vector.<GameObject>;
		protected var nescesary:Class;
		protected var specifficGOAbillity:Abillity;
		
		public function GameSystem(gameObjects:Vector.<GameObject>) 
		{
			_gameObjects = gameObjects;
			this.addEventListener(Event.ENTER_FRAME, loop);	
		}		
		private function loop(e:Event):void 
		{			
			for each(var go:GameObject in _gameObjects) {
				
				//trace("checking abillity : " + checkForAbillity(go));
				if (checkForAbillity(go))systemAction(go);
			}									
		}			
		protected function checkForAbillity(go:GameObject):Boolean
		{		
						
			for each(var k in go.abillities)
			{
				var value:Abillity = Abillity(k);
				if (value is nescesary)
				{
					specifficGOAbillity = value;
					return true;
				}
				
			}
			return false;
			
			
			//if (go.abillities[nescesary]) return true;
			//return false;
			/*
			if (nescesary == null) throw new Error("The 'nescecary' field is not set for the GameSystem impelemtation");
			
			//!!!!!
			
			if(go.abillities[nescesary])
			
			
			for each(var abillity:Abillity in go.abillities)
			{
				if (abillity is nescesary)
				{
					return true;
				}				
			}
			return false;		
			*/
		}
		protected function systemAction(go:GameObject):void
		{
			//trace("abstract system action performs");
		}		
		
	}

}