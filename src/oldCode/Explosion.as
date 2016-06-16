package src.oldCode 
{
	import flash.media.Sound;
	import flash.events.Event;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Explosion extends libExplosion
	{
		private var main:Main;
		
		public function Explosion($main:Main) 
		{
			main = $main;
			var snd:Sound = new BafSound();
			snd.play();
			
			addEventListener(Event.ENTER_FRAME, checkEnd);
		}
		
		private function checkEnd(e:Event):void 
		{
			if (currentFrame == framesLoaded)
			{
				removeEventListener(Event.ENTER_FRAME, checkEnd);
				main.removeChild(this);
				var index:int = main.explosions.indexOf(this);
				main.explosions.splice(index, 1);
			}
		}
		
	}

}