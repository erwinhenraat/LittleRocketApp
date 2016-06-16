package src.model.colliders 
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
			super(1, 0xff0000, 1);
			_range = range;
			graphics.drawCircle(0, 0, _range);
		}
		public function get range():Number
		{
			return _range;
		}
		
	}

}