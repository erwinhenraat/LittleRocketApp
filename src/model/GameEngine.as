package src.model 
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import src.model.abillities.Health;
	import src.model.colliders.BoxCollider;
	import src.model.colliders.CircleCollider;
	import src.model.colliders.Collider;
	import src.model.abillities.Movement;
	import src.model.abillities.Rotation;
	import src.model.gameObjects.GameObject;
	import src.model.gameObjects.powerups.Powerup;
	import src.model.gameObjects.projectiles.Projectile;
	import src.model.gameObjects.projectiles.Laser;
	import src.model.gameObjects.projectiles.RailBeam;
	import src.model.gameObjects.projectiles.SpecialBeam;
	import src.model.gameObjects.units.Enemy;
	import src.model.gameObjects.units.Plane;
	import src.model.systems.CollisionSystem;
	import src.model.systems.HealthSystem;
	import src.model.systems.MovementSystem;
	import flash.events.Event;
	import src.model.events.GameEvent;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameEngine extends Sprite 
	{		
		
		//all projectiles are put in the projectiles array
		private var gameObjects:Vector.<GameObject>;
		
		//game system variables
		private var movementSystem:MovementSystem;
		private var _gamedataVisible:Boolean;
		private var collisionSystem:CollisionSystem;
		private var healthSystem:HealthSystem;
		
		public function GameEngine() 
		{
			gameObjects = new Vector.<GameObject>();
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
			//setup Systems
			movementSystem = new MovementSystem(gameObjects);
			collisionSystem = new CollisionSystem(gameObjects);
			collisionSystem.addEventListener(GameEvent.COLLISION, onGOCollision);
			healthSystem = new HealthSystem()
		}			
		
		private function onGOCollision(e:GameEvent):void 
		{
			var go:GameObject = e.target as GameObject;
			var hc:Health = go.abillities[Health] as Health;
			if (hc != null)
			{
				trace("!!!!!");
				hc.amount--;
			}
		}
		/*
		 * use this function to create the gameobjects at startup
		 * 
		 */			
		private function createStartingGameobjects():void
		{	
			var gameObjectTypes:Vector.<Class> = new Vector.<Class>();
			gameObjectTypes[0] = Plane;
			gameObjectTypes[1] = Enemy;
			gameObjectTypes[2] = Laser;
			gameObjectTypes[3] = SpecialBeam;
			gameObjectTypes[4] = Powerup;
			
			//create a gameobject
			var go:GameObject = addGameobject(gameObjectTypes[Math.floor(Math.random()*5)]);
			go.addAbillity(new Movement(1,0,2));
			go.x = 100;
			go.y = 500;
			go.addAbillity(new Health(10, go));
			go.addCollider(new BoxCollider(100, 100));
			
			
			var go2:GameObject = addGameobject(gameObjectTypes[Math.floor(Math.random()*5)]);
			go2.addAbillity(new Movement(-1,0,2));
			go2.x = 200;
			go2.y = 500;
			go2.addCollider(new CircleCollider(50));
			go2.addAbillity(new Health(10, go2));
		
			var go3:GameObject = addGameobject(gameObjectTypes[Math.floor(Math.random() * 5)]);
			go3.addAbillity(new Movement(0.6, 0.3, 3));
			go3.addCollider(new CircleCollider(50));
						
			go.addEventListener(GameEvent.GAMEOBJECT_DIES, removeGameobject);
			
		}
		
		private function removeGameobject(e:GameEvent):void 
		{
			var go:GameObject = e.target as GameObject;
			gameObjects.splice(gameObjects.indexOf(go), 1);
			if (this.contains(go)) removeChild(go);
		}
		/*
		 * function dynamiccaly creates gameobject bij type
		 * also enables rendering when _gamedataVisible is true
		 */
		private function addGameobject(ClassType:Class):GameObject
		{
			var go:GameObject = new ClassType();
			gameObjects.push(go);
			if (_gamedataVisible)
			{
				addChild(go);
				go.visible = true;
			}
			return go;
			
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
		
		
	}

}