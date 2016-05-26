package src 
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Wingman extends Plane
	{		
		private var side:String;
		private var distanceFromPlayer:int = 80;
		public var invulnerable:Boolean;
		public function Wingman($main:Main, $x:Number, $y:Number) 
		{
			super($main, $x, $y);
			x = $x;
			main = $main;
			invulnerable = true;
			var vulnerableTimer:Timer = new Timer(2000, 1);
			vulnerableTimer.addEventListener(TimerEvent.TIMER_COMPLETE, makeVulnerable);
			vulnerableTimer.start();
			main.addChild(this);
			if(x < main.plane.x)
			{
				side = "left";
			}
			else
			{
				side = "right";
			}
			
			scaleX = 0.5;
			scaleY = 0.5;
		}
		
		private function makeVulnerable(e:TimerEvent):void 
		{
			invulnerable = false;
		}
		public override function update()
		{
			var dx:Number = x - main.plane.x;
			
			if (dx > distanceFromPlayer || dx < -distanceFromPlayer)
			{				
				x += (main.plane.x - x)/5;
			}
			if (side == "left")
			{	
				if (dx > -distanceFromPlayer-15) x = main.plane.x - (distanceFromPlayer-15);
			}
			if (side == "right")
			{
				if (dx < distanceFromPlayer-15)  x = main.plane.x + (distanceFromPlayer-15);
			}
			
			y += ((main.plane.y+20) - y) / 4;
			
			
			
			//lastdx = dx;
		}
		override public function shoot():void 
		{
			//aangeroepen vanuit Plane class
			
			var l:Laser;				
			if(main.plane.rapidShotsLeft>0){l = new libRapidLaser();}else{l = new Laser();}					
			l.x = x;	
			l.y = y;	
			l.init(0,0);
			main.addChild(l);				
			main.lasers.push(l);
			flash.visible = true;
			var timer:Timer = new Timer(50, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, removeFlash);
			timer.start();
			
		}
		
	}

}