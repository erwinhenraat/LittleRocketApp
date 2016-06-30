package src.oldCode 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author erwin henraat
	 * 
	 * This class animates a UI card object once
	 * 
	 * 
	 */
	public class UICard extends libCardAnim
	{
		
		public function UICard() 
		{
			this.gotoAndStop(1);
			
		}		
		public function animate():void
		{
			this.play();
		}
		public function animateOnce():void
		{
			trace("animate once");
			this.play();
			this.addEventListener(Event.ENTER_FRAME, checkEnd);
		}
		
		private function checkEnd(e:Event):void 
		{
			if (this.currentFrame == this.framesLoaded)
			{
				this.gotoAndStop(1);
				this.removeEventListener(Event.ENTER_FRAME, checkEnd);
			}
		}
		
	}

}