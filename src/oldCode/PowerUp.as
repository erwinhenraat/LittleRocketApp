package src.oldCode 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class PowerUp extends libPowerUp
	{
		private var main:Main;
		private var fade:Boolean = true;
		public var destroy:Boolean = false;
		public function PowerUp($main:Main, type:String) 
		{
			main = $main;
			switch(type)
			{
				case "double":
				gotoAndStop("double");		
				break;
				case "special":
				gotoAndStop("special");	
				break;
				case "rapid":
				gotoAndStop("rapid");
				break;
				case "45angle":
				gotoAndStop("45angle");
				break;
				case "90angle":
				gotoAndStop("90angle");
				break;
			}		
			
			this.scaleX = this.scaleY = 1.5;
		}		
		public function update():void 
		{
			y += 6;
			//rotation += 5;
			if (y > main.stage.stageHeight + height)
			{
				destroy = true;
			}
			if (fade)
			{
				if(alpha > 0.4)
				{
					alpha -= 0.2;
				}else
				{
					fade = false;
				}
			}else
			{
				if (alpha < 1)
				{
					alpha += 0.2;
				}else
				{
					fade = true;
				}
			}
			
			
			
		}
		public function remove()
		{
			main.removeChild(this);
			main.powerup = null;	
		}
		
	}

}