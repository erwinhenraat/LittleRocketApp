package src 
{
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Stage;
	import flash.display.Shape;
	import flash.display.GradientType;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Plane extends libPlane
	{
		public var maxYspeed:Number = 9;
		public var maxXspeed:Number = 14;
		
		private var xspeed = 0;
		private var yspeed = 0;
		private var exhaust:Exhaust;
		public var reloading:Boolean;
		public var flash:Shape;
		private var lastx:Number;
		private var lasty:Number;
		private var shield:MovieClip;
		private var destroyingShield:Boolean = false;
		private var pan:Number= 0;
		private var sizeModifier:Number = 1;
		private var shrinkTimer = new Timer(1000,1);
		public var angle180ShotsLeft:int = 0;
		public var angle45ShotsLeft:int = 0;
		public var angle90ShotsLeft:int = 0;
		public var doubleShotsLeft:int = 0;
		public var rapidShotsLeft:int = 0;
		public var base:MovieClip;
		public var shielded:Boolean = false;
		
		public function Plane($main:Main, $x:Number, $y:Number) 
		{
			main = $main;
			shrinkTimer.addEventListener(TimerEvent.TIMER_COMPLETE, resize);
			
					
			x = $x;
			y = $y;
			
			base = this.collider;
		
			exhaust = new Exhaust();
		
			addChildAt(exhaust,0);
		
			exhaust.y = height;
		
			exhaust.alpha = 0.4;
			
			flash = new Shape()
			flash.graphics.beginGradientFill(GradientType.RADIAL, [0xffffff, 0xFFFFFF], [1, 0.01],[10,60]);
			flash.graphics.drawCircle(0, 0, 30);
			flash.graphics.endFill();			
			addChild(flash);
			//flash.y = y * scaleY;
			flash.visible = false;
			lastx = x;
			lasty = y;
			
			
			
		}				
		
		public function update()
		{
			//trace("fingerpos",main.fingerPos)
			xspeed = (main.fingerPos.x - x) / 3; // tweakpunt 1: "Snelheid waarmee de plane de muis volgt."
			yspeed = ((main.fingerPos.y - height / 2) - y) / 2; // tweakpunt 2: "Snelheid waarmee de plane de muis volgt."
			if (xspeed < 0.01 && xspeed > -0.01) xspeed = 0;			
			if (yspeed < 0.01 && yspeed > -0.01) yspeed = 0;
			
			x += xspeed;
			y += yspeed; 
			
			rotation = xspeed * 0.5; //tweakpunt 3: "Schip roteert mee met beweging."
			if (main.special != null) main.special.rotation = rotation;
			
			if (yspeed > -maxYspeed / 4 && exhaust.numFumes != 1)
			{
				exhaust.change(1);
				scaleX = 1*sizeModifier;
				exhaust.scaleX = 1;
				scaleY = 1 *sizeModifier;
				exhaust.scaleY = 1;
				exhaust.alpha = 0.4;
			}
			if (yspeed < -maxYspeed / 4 && yspeed < maxYspeed / 2 && exhaust.numFumes != 2)
			{
				exhaust.change(2);
				scaleX = 0.95 * sizeModifier;
				exhaust.scaleX = 1.05;
				scaleY = 1.05 * sizeModifier;
				exhaust.scaleY = 0.95;
				exhaust.alpha = 0.5;
			}
			if (yspeed < -maxYspeed / 2 && yspeed < (maxYspeed / 4 * 3) && exhaust.numFumes != 3) 
			{ 
				exhaust.change(3);
				scaleX = 0.9 * sizeModifier;
				exhaust.scaleX = 1.1;
				scaleY = 1.1 *sizeModifier;
				exhaust.scaleY = 0.9;
				exhaust.alpha = 0.6;
			}
			if (yspeed < -(maxYspeed / 4 * 3) && exhaust.numFumes != 4)
			{
				exhaust.change(4);
				scaleX = 0.8*sizeModifier;
				exhaust.scaleX = 1.2;
				scaleY = 1.2*sizeModifier;
				exhaust.scaleY = 0.8;
				exhaust.alpha = 0.7;
			}
			
			
			//panning van plane bepalen
			pan = Math.ceil(((x - (main.stage.stageWidth / 2)) / (main.stage.stageWidth / 2))*10)/10;
			
			if(!reloading)shoot();
			
			lastx = x;
			lasty = y;
		}	
		
		public function shoot():void 
		{
			//schieten
			for (var i:int = 0; i < main.wingmen.length; i++) 
			{
				main.wingmen[i].shoot();
			}
			reloading = true;
			var reloadTimer:Timer = new Timer(100, 1); //tweakpunt 4: "Snelheid waarmee het schip normale kogels schiet."
			reloadTimer.addEventListener(TimerEvent.TIMER_COMPLETE, reload);				
			
			var l:Laser;				
							
			if (rapidShotsLeft > 0) 
			{
				rapidShotsLeft--;
				l = new libRapidLaser();
				reloadTimer.delay = 30; //tweaken 5: "Snelheid waarmee het schip snelle kogels schiet."
			} 
			else
			{
				l = new Laser();	
			}					
			main.addChild(l);
			
			main.lasers.push(l);
			
			if (doubleShotsLeft > 0) 
			{
				doubleShotsLeft--;
				l.x = x-8;
									
				var l2:Laser;
				if (rapidShotsLeft > 0){ l2 = new libRapidLaser();}else{l2 = new Laser();}
				main.addChild(l2);
				main.addChild(this);
				
				main.lasers.push(l2);
				
				l2.x = x+8;
				l2.y = y;// * scaleY * sizeModifier;
				l2.init(0,pan);
				
			}
			else
			{					
				l.x = x;
				
			}
			l.y = y;// * scaleY * sizeModifier; 
			l.init(0,pan);
			
			if (angle45ShotsLeft > 0)
			{
				angle45ShotsLeft -= 2;
				var l3:Laser;
				var l4:Laser;
				
				if (rapidShotsLeft > 0)
				{
					l3 = new libRapidLaser();
					l4 = new libRapidLaser();
				}
				else
				{
					l3 = new Laser();
					l4 = new Laser();
				}
				l3.x = x;
				l3.y = y;// * scaleY * sizeModifier;
				l4.x = x;
				l4.y = y;// * scaleY * sizeModifier;
				l3.init( -45, pan);
				l4.init( 45, pan);
				main.lasers.push(l3);
				main.lasers.push(l4);
				main.addChild(l3);
				main.addChild(l4);
				
			}
			if (angle90ShotsLeft > 0)
			{
				angle90ShotsLeft -= 2;
				var l5:Laser;
				var l6:Laser;
				
				if (rapidShotsLeft > 0)
				{
					l5 = new libRapidLaser();
					l6 = new libRapidLaser();
				}
				else
				{
					l5 = new Laser();
					l6 = new Laser();
				}
				l5.x = x;
				l5.y = y;// * scaleY * sizeModifier;
				l6.x = x;
				l6.y = y;// * scaleY * sizeModifier;
				l5.init( -90, pan);
				l6.init( 90, pan);
				main.lasers.push(l5);
				main.lasers.push(l6);
				main.addChild(l5);
				main.addChild(l6);
			}
			if (angle180ShotsLeft > 0)
			{
				angle180ShotsLeft --;
				var l7:Laser;
				if (rapidShotsLeft > 0){l7 = new libRapidLaser();}
				else{l7 = new Laser();}
				l7.x = x;
				l7.y = y;
				l7.init(180, pan);
				main.lasers.push(l7);
				main.addChild(l7);
			}
			
			main.addChild(this);
			main.addChild(main.ui);
			main.addChild(main.combo);
			reloadTimer.start();
			
			flash.visible = true;
			var timer:Timer = new Timer(50, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, removeFlash);
			timer.start();
			
		}
		
		
		public function removeFlash(e:TimerEvent):void 
		{
			var t:Timer = e.target as Timer;
			t.removeEventListener(TimerEvent.TIMER_COMPLETE, removeFlash);
			flash.visible = false;
		}
		private function reload(e:TimerEvent):void 
		{
			reloading = false;
		}
		public function activateDouble($amount:int = 10)
		{
			doubleShotsLeft += $amount;
		}
		public function activateRapid($amount:int = 50)
		{
			rapidShotsLeft += $amount;
		}
		public function activate45Angle($amount:int = 50)
		{
			angle45ShotsLeft += $amount;
		}
		public function activate90Angle($amount:int = 50)
		{
			angle90ShotsLeft += $amount;
		}
		public function activate180Angle($amount:int = 50)
		{
			angle180ShotsLeft += $amount;
		}
		
		public function fireMagnet()
		{
			var b:Laser = new libMagnet();
			b.init(0, pan, 2);
			main.lasers.push(b);
			main.addChild(b);
			b.x = x;
			b.y = y;					
			
		}
		public function shrink($time:Number)
		{
			sizeModifier = 0.5;
			scaleX *= sizeModifier;
			scaleY *= sizeModifier;
			
			shrinkTimer.delay = $time;
			
			shrinkTimer.start();
		}		
		private function resize(e:TimerEvent):void 
		{
			//trace("resize");
			sizeModifier = 1;
			shrinkTimer.stop();
			shrinkTimer.reset();
		}
		public function activateShield()
		{
			shielded = true;
			shield = new libShield();
			addChild(shield);
			//trace("shield up!");
		}
		public function destroyShield()
		{
			if(!destroyingShield){
				destroyingShield = true;
				var t:Timer = new Timer(100, 10);
				t.addEventListener(TimerEvent.TIMER, unshield);
				
				t.start();
			}
			
		}		
		private function unshield(e:TimerEvent):void 
		{
			var t:Timer = e.target as Timer;
			if(shield.alpha > 0)shield.alpha -= 0.1;
			if (t.currentCount == t.repeatCount)
			{
				t.stop();
				t.removeEventListener(TimerEvent.TIMER, unshield);
				removeChild(shield);
				shield = null;
				shielded = false;
				//main.combo.generateCombo();
				destroyingShield = false;
			}
			
			
		}
	}

}