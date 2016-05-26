package src 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Special extends libSpecial
	{
		private var main:Main;
		public var channel:SoundChannel;
		public function Special($main:Main, $milisecs:int = 2000) 
		{
			main = $main;
			var snd:Sound = new SparkSound();
			channel = snd.play(Math.ceil(Math.random() * 3000), 8);
			
			var time:Timer = new Timer($milisecs, 1);
			time.addEventListener(TimerEvent.TIMER_COMPLETE, deactivate);
			var fade:Timer = new Timer($milisecs - 1000, 1);
			fade.addEventListener(TimerEvent.TIMER_COMPLETE, startFade);
			
			
			time.start();
			fade.start();
			
			update();
			main.addChild(this);
			
		}
		
		private function startFade(e:TimerEvent):void 
		{
			var timer:Timer = new Timer(100, 10);
			timer.addEventListener(TimerEvent.TIMER, fadeOut);			
			timer.start();
		}		
		private function fadeOut(e:TimerEvent):void 
		{
			//alpha -= 0.1;
			
			this.scaleX -= 0.1;
		}		
		public function activate()
		{
			//obsolete
			
			
			//main.special = new Special(main);
			//main.addChild(main.special);
			
			
		}
		public function update()
		{
			var pan:Number = Math.ceil(((x - (main.stage.stageWidth / 2)) / (main.stage.stageWidth / 2))*10)/10;
			channel.soundTransform = new SoundTransform(1, pan);
			x = main.plane.x;
			y = main.plane.y; 
		}
		private function deactivate(e:TimerEvent)
		{
			var timer:Timer = e.target as Timer;
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, deactivate);
			main.special.channel.stop();
			main.removeChild(main.special);
			main.special = null;
			main.plane.specialActive = false;
		}
		
	}

}