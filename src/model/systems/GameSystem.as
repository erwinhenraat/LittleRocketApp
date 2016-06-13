package src.model.systems 
{
	import flash.display.Sprite;
	import src.model.gameObjects.GameObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class GameSystem extends Sprite
	{
		private var _list:Array;
		public function get list():Array
		{
			return _list;			
		}
		public function GameSystem() 
		{
			_list = [];
			this.addEventListener(Event.ENTER_FRAME, loop);	
		}		
		private function loop(e:Event):void 
		{				
			for each(var go:GameObject in _list)
			{
				systemAction(go);
			}			
		}	
		
		public function systemAction(go:GameObject):void
		{
			trace("abstract system action performs");
		}
		public function add(go:GameObject):void
		{
			list.push(go);
		}
		
	}

}