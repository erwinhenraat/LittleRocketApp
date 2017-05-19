package src.oldCode
{
	
	/*todo
	 *
	 * 1 - wingmen spacen - v
	 * 2 - powerups baseren op tijd - v
	 * 3 - meer enemies spawnen - v
	 * 4 - bug enemy blijft soms bij rand hangen, niet te raken - v
	 * 5 - kogels eerder verwijderen - v
	 * 6 - Masker over speelveld - v
	 * 7 - lasers meer uit elkaar - v
	 * 8 - more stars - v
	 * 9 - kogels uit bij special beam - v
	 * 10 - 	error na afloop van beam maar soms - ?
	 * 11 - beam audio loopen - v
	 * 12 - tussenlaag sneller - v
	 * 13 - beam ipv faden horizontaal plat - v
	 * 14 - laser pas verwijderen 1 frame nadat het een enemy raakt - v
	 * 15 - 	on death 3 letters invullen top 10
	 * 16 - horizontal flying bullets must be removed offscreen - v
	 * 17 - 	use objectpooling enemie & lasers to increase performance @ wave spawning  - !!!! object pooling done but creates a bug with invisible enemies after wave 8?!
	 * 18 - 	refactor using class diagram
	 * 
	 * */
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.net.SharedObject;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Main extends MovieClip
	{
		public var plane:Plane;
		public var wingmen:Array = new Array();
		public var space:Level;
		public var lasers:Vector.<Laser> = new Vector.<Laser>();
		public var laserPool:Vector.<Laser> = new Vector.<Laser>();		
		public var rapidLaserPool:Vector.<Laser> = new Vector.<Laser>();
		
		
		private var scrollSpeed:Number = 4; // tweakpunt 1: "Snelheid waarmee de achtergrond voorbij komt."
		
		
		public var enemies:Vector.<Enemy> = new Vector.<Enemy>();
		public var enemyPool:Vector.<Enemy> = new Vector.<Enemy>();//Work in progress -- need object poolng to improve performance in higher waves.
		public var splicerPool:Vector.<SplicerEnemy> = new Vector.<SplicerEnemy>();
		
		
		public var explosions:Array = new Array();
		private var numEnemiesToSpawn:int;
		public var ui:UserInterface;
		public var powerup:MovieClip;
		public var special:MovieClip;
		private var wave:int;
		private var highestWave:int = 1;
		private var gameEnded:Boolean = false;
		public var combo:Combobar;
		private var so:SharedObject;
		private var cf:int = 0;
		private var framesToShake:int;
		private var _shakeIntensity:int;
		
		private var _fingerPos:Point;
		
		
		public function get fingerPos():Point
		{
			return _fingerPos;
		
		}
		
		private function keepInScreen(obj:MovieClip):void
		{
			if (obj.x < 0) obj.x = 0;
			if (obj.x > stage.stageWidth) obj.x = stage.stageWidth;
		}
		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			createPools();
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}
		
		private function getHighScore():void
		{
			so = SharedObject.getLocal("highscore");
			
			if (so.data.highestWave == undefined)
			{
				so.data.highestWave = 1;
				
			}
			else
			{
				highestWave = so.data.highestWave;
				
			}
			//trace("loaded so" + so);
			so.close();
		
		}
		
		private function saveHighScore():void
		{
			//	trace("saving so" + so);
			so = SharedObject.getLocal("highscore");
			so.data.highestWave = highestWave;
			so.flush(10000);
			so.close();
		
		}
		
		private function init(e:Event):void
		{
			Mouse.hide();
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_fingerPos = new Point(stage.stageWidth / 2, stage.stageHeight / 2);
			
			getHighScore();
			
			initGame();
			
			createMask();
		}
		
		private function createMask():void 
		{
			var maskShape:Shape = new Shape();
			maskShape.graphics.beginFill(0x000000, 1);
			maskShape.graphics.drawRect(0, 0, 720, 1080);
			maskShape.graphics.endFill();
			addChild(maskShape);
			this.mask = maskShape;
		}
		
		private function initGame():void
		{
			
			//this.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			//this.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			
			gameEnded = false;
			wave = 1;
			space = new Level(this);
			
			plane = new Plane(this, stage.stageWidth / 2, stage.stageHeight); //tweakpunt 2: "Beginpositie van het schip."
			ui = new UserInterface();
			
			
			
			addChild(space);
			
			addChild(plane);
			
			addEventListener(Event.ENTER_FRAME, loop);
			
			if (wave > 1)
			{
				wave--;
				var minusOne:TextField = new Message(this, 100, "lose a wave ");
				addChild(minusOne);
			}
			
		//	trace("!!!");
			//placeWaveMessage();
			
			waitForWaveMessage();
			
			addChild(ui);
			
			combo = new Combobar(this);
			addChild(combo);
		
		}
		
		private function createPools():void 
		{
			for (var i:int = 0; i < 50; i++ ){
				enemyPool.push(new Enemy(this));
			}
			for (i = 0; i < 10; i++ ){
				splicerPool.push(new SplicerEnemy(this));
			}
			for (i = 0; i < 101; i++ ){
				laserPool.push(new Laser());
				rapidLaserPool.push(new libRapidLaser());
			}
		}
		private var wait:Timer = new Timer(1000,1);
		private function waitForWaveMessage():void 
		{
		//	trace("wait for message");
			if(!wait.running){
				betweenWaves = true;
				wait.addEventListener(TimerEvent.TIMER_COMPLETE, endWaitForMessage);
				wait.start();
			}
		}
		
		/*
		   private function onTouchBegin(e:MouseEvent):void
		   {
		   //	trace("touchbegin");
		
		   //	this.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		   _fingerPos.x = e.stageX;
		   _fingerPos.y = e.stageY;
		   }
		   private function onTouchEnd(e:TouchEvent):void
		   {
		   //trace("touchend");
		   this.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		   }
		
		   private function onTouchMove(e:TouchEvent):void
		   {
		   //trace("touchmove");
		   _fingerPos.x = e.stageX;
		   _fingerPos.y = e.stageY;
		   }
		 */
		private var waveMessage:MovieClip = new libNewWave();
		private var betweenWaves:Boolean = false;
		private function placeWaveMessage()
		{
			//trace("call new wave timers");
			if (!contains(waveMessage)) 
			{
				
				waveMessage.y = stage.stageHeight / 2;
				waveMessage.x = stage.stageWidth / 2;	
				ui.addChild(waveMessage);
			}
			
			waveMessage.gotoAndPlay(1);
			waveMessage.visible = true;
			
			var t:Timer = new Timer(3000, 1);
			t.addEventListener(TimerEvent.TIMER_COMPLETE, removeWaveMessage);
			t.start();
			
			var endMessageTimer:Timer = new Timer(1000, 1);
			endMessageTimer.addEventListener(TimerEvent.TIMER, placeUnitsForWave);
			endMessageTimer.start();
			
			
		}		
		private function placeUnitsForWave(e:TimerEvent):void 
		{
			//trace("create units")
			e.target.removeEventListener(TimerEvent.TIMER, placeUnitsForWave);
			
			numEnemiesToSpawn = 5 + Math.ceil(wave / 4);//tweakpunt 3: "Formule die bepaalt hoeveel vijanden er zijn per wave."
			/*
			var newWaveText:TextField = new Message(this, 150, "Wave " + wave); //tweakpunt 4: "Bericht bij een nieuwe wave."
			addChild(newWaveText);
			*/
			
			spawnEnemies(numEnemiesToSpawn);
			if (wave >= 4)//tweakpunt 5: "Vanaf welke wave komen er speciale gouden enemies?"
			{
				var num:Number = numEnemiesToSpawn / 5;//tweakpunt 6: "De hoeveelheid gouden enemies."
				spawnSplicers(num);
			}
			
			betweenWaves = false;
		}
		
		private function removeWaveMessage(e:TimerEvent):void 
		{
			e.target.removeEventListener(TimerEvent.TIMER_COMPLETE, removeWaveMessage);
			waveMessage.gotoAndStop(1);
			waveMessage.visible = false;
		}
		
		private function spawnEnemies(number:int):void
		{
			for (var i:int = 0; i < number; i++)
			{
				var xpos:Number;
				var ypos:Number;
				
				
				//initialize enemy
				//var e:Enemy = new Enemy(this);
				var e:Enemy = enemyPool[i];
				enemyPool.splice(i, 1);
				
				
				var waveStartDistance:Number = 500;
				e.addEventListener(Enemy.ENEMY_DIES, onEnemyDeath);
				enemies.push(e);
				if (wave < 10)
				{
					//tweakpunt 7: "Bepaal de posities en snelheid van de enemies tot wave 10."
					xpos = 10 + Math.round(Math.random() * stage.stageWidth - 20);
					ypos = -waveStartDistance;
					e.ySpeed = 6 + Math.round(Math.random() * 6);
					e.xSpeed = -4 + Math.round(Math.random() * 8);					
					while (e.xSpeed < 1 && e.xSpeed > -1) e.xSpeed = -4 + Math.round(Math.random() * 8);
					//while (e.ySpeed < 1 && e.ySpeed > -1) e.ySpeed *= 10;	
					
					//if (e.xSpeed > -1 && e.xSpeed <= 0) e.xSpeed -= 1;
				}
				else
				{
					
					//e.xSpeed = 0;
					//e.ySpeed = 0;
					switch (Math.ceil(Math.random() * 4))
					{
					case 1: 
						xpos = 10 + Math.round(Math.random() * stage.stageWidth - 20); //van boven komen."
						ypos = -waveStartDistance;
						e.ySpeed = 6 + Math.round(Math.random() * 6);
						e.xSpeed = -4 + Math.round(Math.random() * 8);
						while (e.xSpeed < 1 && e.xSpeed > -1) e.xSpeed = -4 + Math.round(Math.random() * 8);
						break;
					case 2: 
						xpos = stage.stageWidth + waveStartDistance; //van rechts komen."
						ypos = 10 + Math.round(Math.random() * stage.stageHeight - 20);
						e.xSpeed = -6 - Math.round(Math.random() * 6);
						e.ySpeed = -4 + Math.round(Math.random() * 8);
						while (e.ySpeed < 1 && e.ySpeed > -1) e.ySpeed = -4 + Math.round(Math.random() * 8);
						break;
					case 3: 
						xpos = 10 + Math.round(Math.random() * stage.stageWidth - 20); //van onder."
						ypos = stage.stageHeight + waveStartDistance;
						e.ySpeed = -6 - Math.round(Math.random() * 6);
						e.xSpeed = -4 + Math.round(Math.random() * 8);						
						while (e.xSpeed < 1 && e.xSpeed > -1) e.xSpeed = -4 + Math.round(Math.random() * 8);
						break;
					case 4: 
						xpos = -waveStartDistance; //van links."
						ypos = 10 + Math.round(Math.random() * stage.stageHeight - 20);
						e.xSpeed = 6 + Math.round(Math.random() * 6);
						e.ySpeed = -4 + Math.round(Math.random() * 8);
						while (e.ySpeed < 1 && e.ySpeed > -1) e.ySpeed = -4 + Math.round(Math.random() * 8);
						break;
					}
				}
				
				/*
				   e.xSpeed = e.xSpeed = -6 + Math.round(Math.random() * 12);
				   if (e.xSpeed < 1 && e.xSpeed > 0)e.xSpeed+=1;
				   if (e.xSpeed > -1 && e.xSpeed < 0)e.xSpeed-=1;
				   e.ySpeed = e.ySpeed = -6 + Math.round(Math.random() * 12);
				   if (e.ySpeed < 2 && e.ySpeed > 0)e.ySpeed+=1;
				   if (e.ySpeed >-2 && e.ySpeed < 0)e.ySpeed-=1;
				
				 */
				/*
				   while (e.xSpeed < 1 && e.xSpeed > -1)
				   {
				   e.xSpeed = e.xSpeed = -6 + Math.round(Math.random() * 12);
				   if (xSpeed < 1 && e.xSpeed > 0)e.xSpeed+=1;
				   }
				   while (e.ySpeed < 1 && e.ySpeed > -1)
				   {
				   e.ySpeed = e.ySpeed = -6 + Math.round(Math.random() * 12);
				   }
				 */
				e.x = xpos;
				e.y = ypos;
				
				addChild(e);
				addChild(ui);
			}
		}
		
		private function spawnSplicers(number:int):void
		{
			for (var i:int = 0; i < number; i++)
			{
				var e:SplicerEnemy = splicerPool[i];//new SplicerEnemy(this);
												
				e.addEventListener(Enemy.ENEMY_DIES, onEnemyDeath);
				enemies.push(e);
				splicerPool.splice(i, 1);
				
				addChild(e);
				e.x = 10 + Math.round(Math.random() * stage.stageWidth - 20);
				e.y = -100;
				e.ySpeed = 3 + Math.round(Math.random() * 3);
				e.xSpeed = -6 + Math.round(Math.random() * 12);
				while (e.xSpeed < 1 && e.xSpeed > -1) e.xSpeed = -12 + Math.round(Math.random() * 24);
				
			}
			addChild(ui)
		}
		
		private function onEnemyDeath(e:Event):void
		{
			var enemy:Enemy = e.target as Enemy;
			enemy.removeEventListener(Enemy.ENEMY_DIES, onEnemyDeath);
			shake(2, 20);
		
		}
		
		public function shake(frames:int = 3, intensity:int = 45):void
		{
			addEventListener(Event.ENTER_FRAME, onFrame);
			cf = 0;
			framesToShake = frames;
			_shakeIntensity = intensity;
		}
		
		private function onFrame(e:Event):void
		{
			this.y = -_shakeIntensity + Math.random() * 2 * _shakeIntensity;
			space.y = -this.y;
			cf++;
			if (cf == framesToShake)
			{
				removeEventListener(Event.ENTER_FRAME, onFrame);
				this.y = 0;
				space.y = 0;
			}
		}
		
		private function loop(e:Event):void
		{
			/*
			-----------------------------Nextframe actions:-------------------------------------
			*/
			//remove lasers
			for (var l:int = 0; l < lasers.length; l++)
			{
				if (lasers[l].toRemove)
				{
					removeChild(lasers[l]);
					if(lasers[l] is libRapidLaser){
						rapidLaserPool.push(lasers[l]);
					}else{
						laserPool.push(lasers[l]);
					}					
					lasers.splice(l, 1);
					
					//trace("laserpool " + laserPool.length);
					//trace("rapidlaserpool " + rapidLaserPool.length);
				}
			}
			
			
		
			
			
			
			/*
			-----------------------------Currentframe actions:-------------------------------------
			*/
			_fingerPos.x = mouseX;
			_fingerPos.y = mouseY;			
			
			
			
			//keep shiut in screen
			//update ui
			if (plane != null)
			{
				keepInScreen(plane);
				
				ui.update(plane.doubleShotsLeft, plane.rapidShotsLeft, plane.angle45ShotsLeft, plane.angle90ShotsLeft, wave, highestWave);
			}
			
			//update powerups
			if (powerup != null)
			{
				powerup.update();
				//player picks up powerup
				if (plane != null)
				{
					
					if (plane.hitTestPoint(powerup.x, powerup.y, true))
					{
						//determine and activate powerup
						if (powerup.currentLabel == "double") plane.activatePowerup(plane.powerupTypes.double, 5, true);//plane.activateDouble(25, true); 
						if (powerup.currentLabel == "special") {
							special = new Special(this, 4500); //tweakpunt 13: "Hoe lang duren de powerups?"
							plane.specialActive = true;
						}
						if (powerup.currentLabel == "rapid") plane.activatePowerup(plane.powerupTypes.rapid, 5, true);//plane.activateRapid(25, true); 
						if (powerup.currentLabel == "45angle") plane.activatePowerup(plane.powerupTypes.degrees45, 5, true);//plane.activate45Angle(30, true); //tweakpunt 15 - "Hoe lang duren de powerups?"
						if (powerup.currentLabel == "90angle") plane.activatePowerup(plane.powerupTypes.degrees90, 5, true);//plane.activate90Angle(30, true); //tweakpunt 16 - "Hoe lang duren de powerups?"
						combo.pickup(powerup.currentLabel);
						powerup.destroy = true;
					}
				}
				//remove powerup
				if (powerup.destroy) powerup.remove();
			}
			//new wave if all enemies are gone
			if (enemies.length == 0 && !betweenWaves)
			{
				//nextWave
				waitForWaveMessage();
				
			}
			//update player
			if (plane != null)
			{
				plane.update();
				for (var o:int = 0; o < wingmen.length; o++)
				{
					wingmen[o].update();
				}
			}
			
			//update special (lightning)
			if (special != null)
			{
				special.update()
			}
			//scroll background
			space.scroll(scrollSpeed);
			//update lasers
			
			
			for (var i:int = 0; i < lasers.length; i++)
			{
				lasers[i].update();
				if (lasers[i].y < -lasers[i].height || lasers[i].x < -lasers[i].height || lasers[i].x > stage.stageWidth + lasers[i].height)
				{
					lasers[i].toRemove = true;
				}
			}
			//update enemies
		//	trace(enemies.length);
			
			for (var j:int = 0; j < enemies.length; j++)
			{
				enemies[j].update();
				//hitTest with special
				if (special != null && !enemies[j].invulnerable)
				{
					if (special.hitTestPoint(enemies[j].x, enemies[j].y, true))
					{
						enemies[j].loseLife();
						//enemies[j].mustDie = true;
					}
				}
				//kill player if it hits enemy
				
				if (plane != null)
				{
					for (var p:int = 0; p < wingmen.length; p++)
					{
						if (wingmen[p].hitTestObject(enemies[j]) && !wingmen[p].invulnerable)
						{
							wingmen[p].explode();
							
						}
					}
					
					if (plane.base.hitTestObject(enemies[j]) && special == null)
					{
						if (!plane.shielded)
						{
							plane.mustDie = true;
						}
						else
						{
							plane.destroyShield();
						}
					}
				}
				
				//check collision between enemies and lasers
				for (var k:int = 0; k < lasers.length; k++)
				{
					if (!enemies[j].invulnerable)
					{
						//check magnet proximity
						if (lasers[k] is Magnet)
						{
							//check distance
							//(a*a)+(b*b) = (c*c)
							var dx:Number = Math.abs(enemies[j].x - lasers[k].x);
							var dy:Number = Math.abs(enemies[j].y - lasers[k].y);
							var d:Number = Math.sqrt((dx * dx) + (dy * dy));
							
							var mag:Magnet = lasers[k] as Magnet;
							if (d < mag.range)
							{
								var rad:Number = Math.atan2((enemies[j].y -mag.y), (enemies[j].x - mag.x))//radians
								enemies[j].xSpeed = -(Math.cos(rad) * (d / 20));
								enemies[j].ySpeed = -(Math.sin(rad) * (d / 20));
							}
						}
						else if (enemies[j].hitTestPoint(lasers[k].x, lasers[k].y, true) || enemies[j].hitTestPoint(lasers[k].x, lasers[k].y - lasers[k].height, true))
						{
							
							//enemies[j].mustDie = true;							
							enemies[j].loseLife();
							lasers[k].toRemove = true;
						}
						
					}
				}
				//Bounce enemies 
				for (var m:int = 0; m < enemies.length; m++)
				{
					if (enemies[j] != enemies[m])
					{
						while (enemies[j].hitTestPoint(enemies[m].x - enemies[m].width / 2, enemies[m].y, true))
						{
							enemies[m].x++;
							enemies[m].xSpeed = Math.abs(enemies[m].xSpeed);
							enemies[j].xSpeed = -Math.abs(enemies[j].xSpeed);
						}
						while (enemies[j].hitTestPoint(enemies[m].x + enemies[m].width / 2, enemies[m].y, true))
						{
							enemies[m].x--;
							enemies[m].xSpeed = -Math.abs(enemies[m].xSpeed);
							enemies[j].xSpeed = Math.abs(enemies[j].xSpeed);
						}
						
						while (enemies[j].hitTestPoint(enemies[m].x, enemies[m].y - enemies[m].height / 2, true))
						{
							enemies[m].y++;
							enemies[m].ySpeed = Math.abs(enemies[m].ySpeed);
							enemies[j].ySpeed = -Math.abs(enemies[j].ySpeed);
						}
						while (enemies[j].hitTestPoint(enemies[m].x, enemies[m].y + enemies[m].height / 2, true))
						{
							enemies[m].y--;
							enemies[m].ySpeed = -Math.abs(enemies[m].ySpeed);
							enemies[j].ySpeed = Math.abs(enemies[j].ySpeed);
						}
					}
				}
				//remove plane
				if (plane != null)
				{
					if (plane.mustDie)
					{
						plane.explode();
					}
				}
				
				//remove enemies
				for (var n:int = 0; n < enemies.length; n++)
				{
					if (enemies[n].mustDie)
					{
						if (enemies[n] is SplicerEnemy) 
						{
							var spl:SplicerEnemy = enemies[n] as SplicerEnemy;
							spl.splitUp();
						}
						enemies[n].explode();
					}
				}
				if (plane == null && !gameEnded)
				{
					
					gameEnded = true;
					//	trace("dood")
					//removeEventListener(Event.ENTER_FRAME, loop);	
					addChild(new Message(this, 150, "Game Over", 200, 10, 40));
					addChild(new Message(this, 200, "@ wave " + wave, 100, 30, 30));
					var resetTimer:Timer = new Timer(3500, 1);
					resetTimer.addEventListener(TimerEvent.TIMER_COMPLETE, destroyGame);
					resetTimer.start();
					var snd:Sound = new LoseSound();
					snd.play();
				}
			}
		}
		
		private function endWaitForMessage(e:TimerEvent):void 
		{
			e.target.removeEventListener(TimerEvent.TIMER_COMPLETE, endWaitForMessage);
			wave++;
			placeWaveMessage();
		}
		
		private function destroyGame(e:TimerEvent):void
		{
			if (wave > highestWave) highestWave = wave;
			
			//save highscore in shared object.
			saveHighScore();
			
			var timer:Timer = e.target as Timer;
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, initGame);
			
			for (var i:int = 0; i < lasers.length; i++)
			{
				removeChild(lasers[i]);
			}
			for (i = 0; i < enemies.length; i++)
			{
				removeChild(enemies[i]);
			}
			for (i = 0; i < wingmen.length; i++)
			{
				if (contains(wingmen[i])) removeChild(wingmen[i]);
			}
			removeChild(combo)
			combo = null;
			removeChild(space);
			removeChild(ui);
			enemies.splice(0, enemies.length);
			lasers.splice(0, lasers.length);
			if (wingmen.length > 0) wingmen.splice(0, wingmen.length);
			ui = null;
			plane = null;
			space = null;
			powerup = null;
			initGame();
		
		}
	
	}

}