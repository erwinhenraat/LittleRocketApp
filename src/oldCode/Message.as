package src.oldCode
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Message extends TextField
	{
		private var fadeTicks:int;
		private var main:Main;
		
		public function Message($main:Main, $y:Number, $message:String, $fadeInterval:int = 100, $fadeTicks:int = 10, $size:Number = 26) 
		{			
			main = $main;
			this.autoSize = TextFieldAutoSize.CENTER;
			htmlText = $message;
			fadeTicks = $fadeTicks;
			var lifeSpan:Timer = new Timer($fadeInterval, $fadeTicks);
			lifeSpan.addEventListener(TimerEvent.TIMER, fade);
			lifeSpan.start();
			x = main.stage.stageWidth / 2 - width / 2;
			y = $y;
			this.embedFonts = true;
			
			this.setTextFormat(new TextFormat("Verdana", $size, 0xffffff, true));
			
		}		
		private function fade(te:TimerEvent):void 
		{
			var timer:Timer = te.target as Timer;
			var decrease:Number = 1 / fadeTicks;
			alpha -= decrease;
			if (alpha <= 0)
			{
				timer.removeEventListener(TimerEvent.TIMER, fade);
				main.removeChild(this);
				
			}
		}
		
	}

}