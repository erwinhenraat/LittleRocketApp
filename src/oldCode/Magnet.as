package src.oldCode 
{
	import flash.media.SoundChannel;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Magnet extends Laser
	{
		private var channels:Array=[];
		public var range:Number = 250;
		public function Magnet() 
		{
			var snd:Sound = new magIntroSound();
			channels.push(snd.play(Math.ceil(Math.random() * 100),1));
			var snd2:Sound = new magLoopSound();
			channels.push(snd2.play(5500, 10)); 
			
			
		}
		
	}

}