package src.model.abillities 
{
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class CircleCollider extends Collider 
	{
		private var _range:Number;
		
		public function CircleCollider(range:Number) 
		{
			_range = range;
		}
		public function get range():Number
		{
			return _range;
		}
		
	}

}