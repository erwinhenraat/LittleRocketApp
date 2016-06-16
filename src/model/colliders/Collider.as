package src.model.colliders 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Collider extends Sprite
	{
		public function Collider(thick:Number, color:uint, a:Number) 
		{
//super(color, a);
			this.graphics.lineStyle(thick ,color, a);
		}		
	
	}

}