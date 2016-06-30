package src.oldCode 
{
	import flash.display.MovieClip;
	import flash.display.Shader;
	import flash.filters.GlowFilter;
	import flash.filters.ShaderFilter;
	import flash.geom.ColorTransform;
	import flash.utils.ByteArray;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Combobar extends MovieClip
	{
		public var fading = false;
		//private var order:Array;
		
		private var iconToCheck:Number;
		private var main:Main;
		private var validPowerups:Array;
		private var icons:Array = [];
		private var maxPickups:int = 4;
		private var superupIcons:Array = [];
		private var amountPicked:int = 0;
		private var superupLabel:String;
		private var largeSuperUp:MovieClip;
		private var aantalIcons:Number;
		private var numReached:int;
		private var middle:Number;
		private var uiCards:Array = [];
		
		
		public function Combobar($main:Main) 
		{
			main = $main;
			y = main.stage.stageHeight - 20;
			//main.addChild(this);		
			//initBar();			
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			//addTheUICards
			for (var i:int = 0; i < 5; i++) 
			{
				addChild(uiCards.push(new UICard()));
				uiCards[i].x = 100 + 85 * i;//
				uiCards[i].y = 500;//
			}
			
			
		}			
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onReleaseKey);
		}
		
		private function onReleaseKey(e:KeyboardEvent):void 
		{
			//trace("releasse");
			switch(e.keyCode)
			{
				case Keyboard.W:
					powerupWingmen();
					break;
				case Keyboard.Q:
					powerupShrink();
					break;
				case Keyboard.E:
					powerupMagnet();
					break;
				case Keyboard.R:
					powerupRapidInsanity();
					break;
				case Keyboard.T:
					powerupShield();
					break;
				
			}
		}
		private function initBar():void 
		{
			var timer:Timer = new Timer(100, 100);
			timer.addEventListener(TimerEvent.TIMER, fade);
			timer.start();
			
		
			//save labelNames
			
		}
		
		private function fade(e:TimerEvent):void 
		{
			fading = true;
			for (var i:int = 0; i < icons.length; i++) 
			{
				if (icons[i].alpha > 0)
				{	icons[i].alpha-=0.1
					
				}else
				{
					removeChild(icons[i]);
				}
			}
			if(icons.length>0){
				if (!contains(icons[icons.length - 1])) {
					icons = [];
					var t:Timer = e.target as Timer;
					t.stop();
					t.removeEventListener(TimerEvent.TIMER, fade);
					fading = false;
				}
			}
		}
		public function pickup($label:String)
		{		
			if(largeSuperUp==null && !fading){
				if (icons.length < maxPickups)
				{			
					var pu:MovieClip = new libPowerUp();
					icons.push(pu);
					pu.gotoAndStop($label);
					pu.x = (icons.length - 1) * (pu.width + 5) + 25;
					addChild(pu);
					if (icons.length >= 3 )
					{
						checkIcons($label);
					}				
				
				}
			}			
				
		}
		private var _iconsToAnimate:Array = [];
		private function checkIcons($label:String):void 
		{		
			var foundItems:Array = [["double",0,[]], ["45angle",0,[]], ["90angle",0,[]], ["rapid",0,[]], ["special",0,[]]];
			
			for (var i:int = 0; i < icons.length; i++) 
			{
				for (var j:int = 0; j < icons.length; j++) 
				{
					if (i != j)
					{
						if (icons[i].currentLabel == icons[j].currentLabel)
						{
							foundItems[icons[i].currentFrame-1][0] = icons[i].currentLabel;//label van het icon
							foundItems[icons[i].currentFrame-1][1]++;//hoeveelheid gevonden items
							foundItems[icons[i].currentFrame-1][2].push(icons[i]);//icon object reference
							
							
							
						}
					}
				}
			}
		
			trace("this is the collection"+ collection);
			
			var pairfound:Boolean = false;
			var tripletFound:Boolean = false;
			
			for (var k:int = 0; k < foundItems.length; k++) 
			{
				if (foundItems[k][1] >= 3)
				{					
					//-----------3 dezelfde gevonden----------------
					_iconsToAnimate = [];
					_iconsToAnimate.push(foundItems[k][2][2]);
					dispatchEvent(new Event(Combobar.PAIR_FOUND));
					tripletFound = true;
					break;
				}
				if (foundItems[k][1] == 2)
				{					
					_iconsToAnimate = [];
					_iconsToAnimate.push(foundItems[k][2][0]);
					_iconsToAnimate.push(foundItems[k][2][1]);
					dispatchEvent(new Event(Combobar.TRIPPLE_FOUND));
					pairfound = true;
					break;
				}
			}		
			
			
			//			
			
			if (tripletFound)
			{
				
				//-------------3 zelfde powerups gevonden----------
				createSuperup(foundItems[k][0]);
				
				initBar();
			}
			else if(icons.length == 4)
			{
				if (!pairfound)
				{
					//-------------4 unieke powerups gevonden----------
					createSuperup("shield");
							
					initBar();
				}
				else
				{
					initBar();
					
					poweDownSound.play(0, 1);
				}
			}		
		}		
		
		private function createSuperup($label:String):void 
		{		
			middle = 0;
			superupLabel = $label;			
			superupIcons = [];			
			for (var i:int = 0; i < icons.length; i++) 
			{					
				var make:Boolean = false;
				if ($label == "shield")
				{
					superupIcons.push(new libPowerUp());
					superupIcons[superupIcons.length - 1].gotoAndStop(icons[i].currentLabel)
					make = true;
				}				
				if (icons[i].currentLabel == $label)
				{
					superupIcons.push(new libPowerUp());
					superupIcons[superupIcons.length - 1].gotoAndStop($label);									
					make = true;
				}				
				if (make)
				{
					superupIcons[superupIcons.length - 1].reached = false;
					middle +=superupIcons[superupIcons.length - 1].x = icons[i].x;
					superupIcons[superupIcons.length - 1].y = icons[i].y;
					addChild(superupIcons[superupIcons.length - 1]);	
					 
				}				
			}	
			if(make){
			
				aantalIcons = superupIcons.length;
				//mergeSuperups aanroepen
				middle /= superupIcons.length;
				addEventListener(Event.ENTER_FRAME, handlePickupAnimation);
				numReached = 0;
			}
		}
		
		private function handlePickupAnimation(e:Event):void 
		{
			
			mergeSuperups(middle, aantalIcons);
		}
		public function mergeSuperups($targetPoint:Number = 0, $amount:int = 3)
		{			
			
			for (var i:int = 0; i < superupIcons.length; i++) 
			{
				
				
				var r:Number = superupIcons[i].transform.colorTransform.redMultiplier;
				var g:Number = superupIcons[i].transform.colorTransform.greenMultiplier;
				var b:Number = superupIcons[i].transform.colorTransform.blueMultiplier;
				var speed:Number = 0.5
			
				if(r+g+b < 50){
				
					superupIcons[i].transform.colorTransform = new ColorTransform(r+speed,g+speed,b+speed);
				}
				else if(!superupIcons[i].reached){
					superupIcons[i].x += ($targetPoint - superupIcons[i].x) / 7;
					if (superupIcons[i].x >= $targetPoint - 2 && superupIcons[i].x <= $targetPoint +2 )
					{
						superupIcons[i].reached = true;
						numReached++;
						
					}
				}
			}	
			if (numReached == $amount)
			{
				
				if (superupIcons.length > 0) {
					for (var j:int = 0; j < superupIcons.length; j++) 
					{				
						if(j>0){
							removeChild(superupIcons[j]);
						}
					}
					largeSuperUp = superupIcons[0];
					largeSuperUp.scaleY = largeSuperUp.scaleX = 1.5;
					largeSuperUp.filters = [new GlowFilter(0xffffff, 0.5, 6, 6, 2, 1, false, false)];
					superupIcons.splice(0, superupIcons.length);
					
					
				}
				//trace(superupLabel);
				if (superupLabel == "shield") largeSuperUp.play();
				if(main.plane != null){moveToPlayer();}
				else{removeEventListener(Event.ENTER_FRAME, handlePickupAnimation);}
			}
		}
		
		private function powerupWingmen():void
		{
			if(main.wingmen.length == 0)main.wingmen.push(new Wingman(main, 0, main.stage.stageHeight));
			if (main.wingmen.length == 1)
			{
				if (main.wingmen[0].x < main.plane.x)
				{
					main.wingmen.push(new Wingman(main, main.stage.stageWidth, main.stage.stageHeight));
				}else
				{
					main.wingmen.push(new Wingman(main, 0, main.stage.stageHeight))
				}
			}
			
		}		
		private function powerupShrink():void 
		{
			main.plane.shrink(30000);	
		}
		private function powerupMagnet():void 
		{
			main.plane.fireMagnet();
		}
		
		private function powerupRapidInsanity():void 
		{			
			main.plane.activatePowerup(main.plane.powerupTypes.rapid, 5, true);
			main.plane.activatePowerup(main.plane.powerupTypes.double, 5, true);
			main.plane.activatePowerup(main.plane.powerupTypes.degrees45, 5, true);
			main.plane.activatePowerup(main.plane.powerupTypes.degrees90, 5, true);
			main.plane.activatePowerup(main.plane.powerupTypes.degrees180, 5, true);
		}
		
		private function powerupShield():void 
		{
			if(!main.plane.shielded)main.plane.activateShield();
		}
		
		private var powerUpSound = new PowUpSound();
		private var poweDownSound = new PowDownSound();
		public function moveToPlayer():void
		{
			largeSuperUp.x -= ((largeSuperUp.x+x) - main.plane.x) / 6;
			largeSuperUp.y -= ((largeSuperUp.y + y) - main.plane.y) / 6;
			if (largeSuperUp.x+x <= main.plane.x+10 && largeSuperUp.x+x >= main.plane.x-10 && largeSuperUp.y+y <= main.plane.y+10 && largeSuperUp.y+y >= main.plane.y-10)
			{	
				
				powerUpSound.play(0, 1);
				removeChild(largeSuperUp);
				largeSuperUp = null;
				removeEventListener(Event.ENTER_FRAME, handlePickupAnimation);
				switch(superupLabel)
				{
					case "double":
						powerupWingmen();					
					//filter.color = 0xFFBBBB;
						break;
					case "45angle":
						powerupShrink();
						//filter.color = 0x61B9CC;
						break;
					case "90angle":
						powerupMagnet();
												
					//filter.color = 0x61B9CC;
						break;
					case "rapid":					
						powerupRapidInsanity();
					
					//filter.color = 0xEEC76C;
					break;
					case "special":
					//trace("screen clear attack");
					//filter.color = 0xDF9EE2;
					break;
					case "shield":
						powerupShield();
		
					break;
				}	
					//main.plane.filters = [filter];									
			}
			
		}
		
		
		
		
		
		/*
		public function moveToPlayer(e:Event)
		{
			if (main.plane != null) {
				
				
				for (var i:int = 0; i < superupIcons.length ; i++) 
				{
					superupIcons[i].x -= ((superupIcons[i].x+x) - main.plane.x) / 6;
					superupIcons[i].y -= ((superupIcons[i].y+y)- main.plane.y) / 6;
			
					if (superupIcons[i].x+x <= main.plane.x+10 && superupIcons[i].x+x >= main.plane.x-10 && superupIcons[i].y+y <= main.plane.y+10 && superupIcons[i].y+y >= main.plane.y-10)
					{	
						removeChild(superupIcons[i]);
						superupIcons.splice(i, 1);
						
					}
				}
			
				if (superupIcons.length == 0)
				{
					removeEventListener(Event.ENTER_FRAME, moveToPlayer);					
					//activate superup				
					//var filter:GlowFilter = new GlowFilter(0xffffff, 0, 7, 20, 20, 3, true);
					switch(superupLabel)
					{
						case "double":
						{
							
							if(main.wingmen.length == 0)main.wingmen.push(new Wingman(main, 0, main.stage.stageHeight));
							if (main.wingmen.length == 1)
							{
								if(main.wingmen[0].x < main.plane.x){
									main.wingmen.push(new Wingman(main, main.stage.stageWidth, main.stage.stageHeight));
								}else
								{
									main.wingmen.push(new Wingman(main, 0, main.stage.stageHeight))
								}
							}
							
						}
						//filter.color = 0xFFBBBB;
						break;
						case "45angle":
						main.plane.shrink(20000);
						//filter.color = 0x61B9CC;
						break;
						case "90angle":
						main.plane.fireMagnet();						
						//filter.color = 0x61B9CC;
						break;
						case "rapid":					
					
						main.plane.activate90Angle(160);
						main.plane.activate180Angle(80);
						main.plane.activateRapid(80);
						main.plane.activateDouble(160);
						//filter.color = 0xEEC76C;
						break;
						case "special":
						trace("screen clear attack");
						//filter.color = 0xDF9EE2;
						break;
						case "shield":
						if(!main.plane.shielded)main.plane.activateShield();
						break;
					}	
					//main.plane.filters = [filter];
									
				}
			}
		}
		*/
	}
}