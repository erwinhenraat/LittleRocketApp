package src.model.abillities 
{
	import src.model.events.GameEvent;
	import src.model.gameObjects.GameObject;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Health extends Abillity 
	{
		private var _amount:int;
		
		public function Health(amount:int, gameObject:GameObject = null) 
		{
			super(gameObject);
			_amount = amount;
			dispatchEvent(new GameEvent(GameEvent.HEALTH_COMPONENT_ADDED,true,true));
		}
		public function get amount():int
		{
			return _amount;
		}
		public function set amount(value:int):void 
		{
			_amount = value;
			if (_amount <= 0) gameObject.dispatchEvent(new GameEvent(GameEvent.GAMEOBJECT_DIES));
		}
		
	}

}