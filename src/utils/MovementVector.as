package src.utils 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author erwin henraat
	 * 
	 * movement vector that is based on Point class and adds a speed property.
	 * 
	 */
	public class MovementVector extends Point 
	{
		private var _speed:Number = 0;
		
		public function MovementVector() 
		{
			
		}
		public function get speed():Number
		{
			return _speed;
		}
		public function set speed(value:Number):void 
		{
			_speed = value;
			 
		}
	}

}