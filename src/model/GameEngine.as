package src.model 
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import src.model.gameObjects.GameObject;
	import src.model.gameObjects.powerups.Powerup;
	import src.model.gameObjects.projectiles.Projectile;
	import src.model.gameObjects.projectiles.Laser;
	import src.model.gameObjects.projectiles.RailBeam;
	import src.model.gameObjects.projectiles.SpecialBeam;
	import src.model.gameObjects.units.Enemy;
	import src.model.gameObjects.units.Plane;
	import src.model.systems.CollisionSystem;
	import src.model.systems.MovementSystem;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameEngine extends Sprite 
	{		
		//game objects are put in different lists depending on its ability each abillity has its own list.
		private var haveHealth:Array = [];
		private var areMovable:Array = [];
		private var canStackLasers:Array = [];
		private var areMagnetic:Array = [];
		private var canShield:Array = [];
		private var canShoot:Array = [];
		private var canSplit:Array = [];
		
		//all projectiles are put in the projectiles array
		private var projectiles:Array = [];
		
		//game system variables
		private var movementSystem:MovementSystem;
		private var _gamedataVisible:Boolean;
		private var collisionSystem:CollisionSystem;
		
		public function GameEngine() 
		{
			_gamedataVisible = false;			
			this.addEventListener(Event.ADDED_TO_STAGE, makeGamedataVisible);
		}
		/*
		 * Start the engine
		 * this enables datavisualisation
		 * engine optionally starts after it's added to the stage
		 */		
		public function start()
		{
			setupSystems();
			createStartingGameobjects();
			
		}
		/*
		 * setup used game systems in this function
		 * 
		 */
		private function setupSystems():void 
		{
			//setup movementSystem
			movementSystem = new MovementSystem();
			collisionSystem = new CollisionSystem();
		}	
		
		/*
		 * use this function to create the gameobjects at startup
		 * 
		 */
		
		private var gameObjectTypes:Vector.<Class> = new Vector.<Class>();		
		private function createStartingGameobjects():void
		{			
			gameObjectTypes[0] = Plane;
			gameObjectTypes[1] = Enemy;
			gameObjectTypes[2] = Laser;
			gameObjectTypes[3] = SpecialBeam;
			gameObjectTypes[4] = Powerup;			
			for (var i:int = 0; i < 40; i++) 
			{				
				//create a gameobject
				var p:GameObject = addGameobject(gameObjectTypes[Math.floor(Math.random()*5)]);
				
				//add gameobject to gamesystems
				movementSystem.add(p);
					
				//change gameobject settings
				p.movementVector.x = Math.random();
				p.movementVector.y = Math.random();
				p.movementVector.speed = Math.random() * 6;
								
				p.rotationDegrees = Math.random() * 360;
				p.x = Math.random() * stage.stageWidth;
				p.y = Math.random() * stage.stageHeight;
			}			
			
			
		}
		/*
		 * function reacts to the Event.ADDED_TO_STAGE event and enables data visualisation
		 * 
		 */		
		private function makeGamedataVisible(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, makeGamedataVisible);
			_gamedataVisible = true;
		}
		/*
		 * function dynamiccaly creates gameobject bij type
		 * also enables rendering when _gamedataVisible is true
		 */
		private function addGameobject(ClassType:Class):GameObject
		{
			var go:GameObject = new ClassType();
			if (_gamedataVisible)
			{
				addChild(go);
				go.visible = true;
			}
			return go;
			
		}	
		
	}

}