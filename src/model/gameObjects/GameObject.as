package src.model.gameObjects 
{
	import fl.motion.Color;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import src.model.abillities.Abillity;
	import src.utils.MovementVector;
	import flash.utils.getQualifiedClassName;

	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameObject extends Sprite 
	{
		private var _abillities:Dictionary
		public function get abillities():Dictionary
		{			
			return _abillities;
		}
		public function GameObject(color:uint) 
		{	
			_abillities = new Dictionary();
			
			this.graphics.beginFill(0xffffff, 1);
			this.graphics.drawCircle(0, 0, 3);
			this.graphics.endFill();			
			
			this.graphics.lineStyle(1,color, 1);
			this.graphics.moveTo(10, 0);
			this.graphics.lineTo(0, 8);
			this.graphics.lineTo(0, 4);
			this.graphics.lineTo(-10, 4);
			this.graphics.lineTo(-10, -4);
			this.graphics.lineTo(0, -4);
			this.graphics.lineTo(0, -8);
			this.graphics.lineTo(10, 0);		
			
			//use the .visible property to show gameobject position dots.
			this.visible = false;
		}	
		public function addAbillity(abillity:Abillity):void
		{			
			/*
			var abillityName:String = getQualifiedClassName(abillity) as String;
			var index:int = abillityName.indexOf(":") + 2;
			abillityName = abillityName.slice(index, abillityName.length);
			*/
			
			
			var AbillityClass:Class = Object(abillity).constructor; 
			_abillities[AbillityClass] = abillity;
			
			addChild(abillity);
			
			//_abillities.push(abillity);
			
			
			
		}		
		
	}

}