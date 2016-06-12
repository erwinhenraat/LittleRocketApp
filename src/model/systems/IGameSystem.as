package src.model.systems 
{
	import src.model.gameObjects.GameObject;
	
	/**
	 * ...
	 * @author erwin henraat
	 */
	public interface IGameSystem 
	{
		function systemAction(go:GameObject):void;
	}
	
	
}