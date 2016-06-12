package src.model.gameObjects 
{
	import fl.motion.Color;
	import flash.display.Sprite;
	import src.utils.MovementVector;
		
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameObject extends Sprite 
	{
		private var _movementVector:MovementVector;
		private var _rotationDegrees:Number = 0;
		private var _rotationRadians:Number = 0;
		
		public function GameObject(color:uint) 
		{				
			/*
			this.graphics.beginFill(color, 1);
			this.graphics.drawCircle(0, 0, 5);
			this.graphics.endFill();
			*/
			
			this.graphics.lineStyle(1,color, 1);
			this.graphics.moveTo(10, 0);
			this.graphics.lineTo(0, 8);
			this.graphics.lineTo(0, 4);
			this.graphics.lineTo(-10, 4);
			this.graphics.lineTo(-10, -4);
			this.graphics.lineTo(0, -4);
			this.graphics.lineTo(0, -8);
			this.graphics.lineTo(10, 0);		
			
			
			//use the .visible property to show gameobject position dots.
			this.visible = false;
		}
		/*
		 * Getters and Setters for movement and rotation values
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