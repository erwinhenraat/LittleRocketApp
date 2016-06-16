package src.model.events 
{
	import flash.events.Event;
	import src.model.gameObjects.GameObject;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameEvent extends Event 
	{
		private var _gameObject:GameObject;
		//	public statics to enable the control Engine to catch events Sent by the gameEngine
		public static const PLAYER_DIES:String = "player dies";
		
		public static const GAMEOBJECT_DIES:String = "unit dies";
		
		public static const START_WAVE:String = "start wave";
		
		public static const SHOOT_LASER:String = "shoot laser";
		public static const SHOOT_RAIL_BEAM:String = "shoot rail beam";
		public static const SHOOT_SPECIAL_BEAM:String = "shoot special beam";
		
		public static const CATCH_POWERUP:String = "catch powerup";
				
		public static const TRIGGER_WINGMAN_COMBO:String = "wingman combo";					//3 doubles
		public static const TRIGGER_MAGNETIC_COMBO:String = "magnetic combo";				//3 up arrows
		public static const TRIGGER_SHRINK_COMBO:String = "shrink combo";					//3 down arrows
		public static const TRIGGER_RAILBEAM_COMBO:String = "railbeam combo"				//3 diamonds
		public static const TRIGGER_PERMANENT_LASERSTACK:String = "permanent laserstack";	//3 lightning bolts
		public static const TRIGGER_SHIELD_COMBO:String = "shield combo";					//4 different powerup types

		public static const COLLISION:String = "collision";
		
		public static const HEALTH_COMPONENT_ADDED:String = "health component added";
		
		
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 		
		
		public override function clone():Event 
		{ 
			return new GameEvent(type, bubbles, cancelable);
		}
 		
		public override function toString():String 
		{ 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}		
		public function get gameObject():GameObject
		{
			return _gameObject;
		}
		public function set gameObject(value:GameObject):void
		{
			_gameObject = value;
		}
		
	}
	
}