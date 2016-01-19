package src 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Enemy extends libEnemy
	{
		private var pijltje:MovieClip;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var invulnerable:Boolean;
		
		public function Enemy($main:Main) 
		{
			stop();			
			animation.gotoAndPlay(Math.ceil(Math.random()*framesLoaded))
			main = $main;
			pijltje = new libPijltje();
			main.addChild(pijltje);
			invulnerable = true;
		}
		public function update()
		{	
			x += xSpeed;
			y += ySpeed;
			if (x <= width / 2) xSpeed=Math.abs(xSpeed);
			if(x >= main.stage.stageWidth -width/2) xSpeed=-Math.abs(xSpeed);
			if (y <= -height / 2 )ySpeed=Math.abs(ySpeed);
			if(y >= main.stage.stageHeight-height/2)ySpeed=-Math.abs(ySpeed);
			
			//bug omzeilen dat enemies buiten het scherm verkeerde richting opgaan. door bouncen op de rand???!
			
			
			
			if (x < 0 || x > main.stage.stageWidth || y < 0 || y > main.stage.stageHeight)
			{				 
				
				//boven
				if (y < 0)
				{
					pijltje.x = x;
					pijltje.rotation = 0;
					pijltje.y = 0;
				}
				
				//onder
				if (y > main.stage.stageHeight)
				{
					pijltje.x = x;
					pijltje.rotation = 180;
					pijltje.y = main.stage.stageHeight;
				}
				//rechts
				if (x > main.stage.stageWidth)
				{
					pijltje.x = stage.stageWidth;
					pijltje.rotation = 90;
					pijltje.y = y;
				}
				//links				
				if (x < 0)
				{
					pijltje.x = 0;
					pijltje.rotation = -90;
					pijltje.y = y;
				}
				
			}else
			{
				pijltje.visible = false;
				invulnerable = false;
			}
			
		}
	}

}