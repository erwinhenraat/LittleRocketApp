package src.oldCode 
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.display.Shape;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Laser extends libLaser
	{
		public var xMove:Number;
		public var yMove:Number;	
		public var toRemove:Boolean = false;
		public function Laser() 
		{	
		
		}
		public function init( $rot:Number = 0,$pan:Number = 0, $speed:Number = 60)
		{
			var sound:Sound = new LaserSound();
			var channel:SoundChannel = sound.play(Math.ceil(Math.random() * 50),0,new SoundTransform(1,$pan));
			rotation = $rot;
								
			var radians:Number = (rotation+90) * (Math.PI / 180);			
			xMove = (Math.cos(radians) * $speed);
			yMove = (Math.sin(radians) * $speed);		
		}		
		public function update()
		{
			
			x -= xMove;
			y -= yMove;			
		
		}
		
	}

}