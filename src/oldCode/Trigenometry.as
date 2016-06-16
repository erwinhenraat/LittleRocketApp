package src.oldCode 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Trigenometry
	{
		
		public function Trigenometry() 
		{
			
		}
		public static function calculateDistance(a:DisplayObject, b:DisplayObject):Number
		{			
			var distX:Number = Math.abs(a.x - b.x);
			var distY:Number = Math.abs(a.y - b.y);
			var distance:Number = Math.sqrt((distX * distX) + (distY * distY));
			
			return distance;			
		}		
		public static function calculateAngle(a:DisplayObject, b:DisplayObject):Number
		{		
			var radians:Number = Math.atan2((b.y - a.y), (b.x - a.x));
			var angle:Number = radians * (180 / Math.PI);
		
			return angle;
		}
		
		public static function calculateMovement($origin:MovieClip, $target:MovieClip, $speedModifier:Number = 4):Object
		{
			//xmove en ymove worden gedeeld aan de hand van de afstand om zo een constante snelheid te krijgen
			var dist:Number = calculateDistance($target, $origin);
			var angle:Number = calculateAngle($origin, $target);
			var radians:Number = angle * (Math.PI / 180); 
			
			
			var returnObject:Object = new Object();			
			
		
			
			
			var radians:Number = Math.atan2((b.y - a.y), (b.x - a.x));
			returnObject.xMove = Math.cos(radians) * $speedModifier;
			returnObject.yMove = Math.sin(radians) * $speedModifier;			
			
			
			
			return returnObject;				
			
		}
		
	}

}
