package src.model.abillities 
{
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Rotation extends Abillity 
	{
		private var _rotationDegrees:Number = 0;
		private var _rotationRadians:Number = 0;
		public function Rotation(degrees:Number) 
		{
			rotationDegrees = degrees;
		}
		public function get rotationDegrees():Number
		{
			return _rotationDegrees;
		}
		public function set rotationDegrees(degrees:Number):void
		{
			_rotationDegrees = degrees;
			//Always convert degrees to radians and update the variable so they correspond.
			_rotationRadians = degrees * (Math.PI / 180);
		}
		public function get rotationRadians():Number
		{
			return _rotationRadians;
		}
		public function set rotationRadians(radians:Number):void
		{
			_rotationRadians = radians;
			//Always convert radians to degrees and update the variable so they correspond.
			_rotationDegrees = (radians * 180) / Math.PI;
		}
		
	}

}