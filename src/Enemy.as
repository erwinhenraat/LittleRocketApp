package src 
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Enemy extends libEnemy
	{
		static public const ENEMY_DIES:String = "enemy dies";
		static public const ENEMY_HIT:String = "enemyHit";
		
		private var pijltje:MovieClip;
		
		private var s:Shape;
		public var xSpeed:Number;
		public var ySpeed:Number;
		public var invulnerable:Boolean;
		
		private var lives:int = 6;
		private var frozen:Boolean = false;
		public function loseLife():void
		{			
			lives--;			
			
			flash();
			freezeFrame();
			dispatchEvent(new Event(ENEMY_HIT));
			
			if (lives <= 0) {
				mustDie = true;
				dispatchEvent(new Event(ENEMY_DIES));
			}
			
		}
		private function flash():void
		{
			s.visible = true;
			var t:Timer = new Timer(10, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, endFlash);
			t.start();
		}
		
		private function endFlash(e:TimerEvent):void 
		{
			s.visible = false;
		}
		private function freezeFrame():void
		{
			frozen = true;
			var t:Timer = new Timer(66, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, endFreeze);
			t.start();
		}		
		private function endFreeze(e:TimerEvent):void 
		{
			frozen = false;
		}		
		public function Enemy($main:Main) 
		{
			s = new Shape();
			s.graphics.beginFill(0xffffff, 1);
			s.graphics.drawCircle(0, 0, this.width/2);
			s.graphics.endFill();
			this.addChild(s);
			s.visible = false;
			
						
			stop();			
			animation.gotoAndPlay(Math.ceil(Math.random()*framesLoaded))
			main = $main;
			pijltje = new libPijltje();
			main.addChild(pijltje);
			invulnerable = true;
			
			//lives = 10; 
		}
		public function update()
		{	
			if (!frozen)
			{
				x += xSpeed;
				y += ySpeed;
				if (x <= width / 2) xSpeed=Math.abs(xSpeed);
				if(x >= main.stage.stageWidth -width/2) xSpeed=-Math.abs(xSpeed);
				if (y <= -height / 2 )ySpeed=Math.abs(ySpeed);
				if(y >= main.stage.stageHeight-height/2)ySpeed=-Math.abs(ySpeed);
			}
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