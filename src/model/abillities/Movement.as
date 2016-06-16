package src.model.abillities 
{
	import src.utils.MovementVector;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Movement extends Abillity 
	{
		private var _movementVector:MovementVector;
		private var _rotationDegrees:Number = 0;
		private var _rotationRadians:Number = 0;
		public function Movement(xMove:Number, yMove:Number, speed:Number, rot:Number = 0) 
		{
			super();
			_movementVector = new MovementVector();
			_movementVector.x = xMove;
			_movementVector.y = yMove;
			_movementVector.speed = speed;
			rotationDegrees = rot;
		}
		/*
		 * Getters and Setters for movement values
		 * 
		 * setters automatically convert and update radians to degrees and degrees to radians. 
		 * This way values will automatically correspond.
		 * 
		 */
		public function get movementVector():MovementVector
		{
			return _movementVector;
		}
		public function set movementVector(movement:MovementVector):void
		{
			_movementVector = movement;
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