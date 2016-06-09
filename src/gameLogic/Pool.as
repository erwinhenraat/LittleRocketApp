package src.gameLogic 
{
	import flash.events.EventDispatcher;
	import src.gameObjects.Enemy;
	import src.gameObjects.GameObject;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Pool extends EventDispatcher 
	{
		private var _gameObjects:Array;
		private var _classType:Class;
		public function Pool(classType:Class, startSize:int = 20) 
		{
			_classType = classType;
			_gameObjects = [];
			
			for (var i:int = 0; i < startSize; i++ )
			{
				create();				
			}		
			
		}
		public function create():void
		{
			_gameObjects.push(new _classType());
			
		}
		public function unpool():GameObject
		{
			if(_gameObjects.length > 0){
				return _gameObjects.pop();
			}
			else
			{
				create();
				return new _classType();
			}
			
		}
		public function pool(go:GameObject):void
		{
			_gameObjects.push(go);
			
		}
		public function destroy(go:GameObject):void
		{
			_gameObjects.splice(_gameObjects.indexOf(go), 1);
		}
	}

}