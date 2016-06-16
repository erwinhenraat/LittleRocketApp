package src.model.colliders 
{
	import flash.display.Shape;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class BoxCollider extends Collider 
	{
		public function BoxCollider(w:Number, h:Number) 
		{
			super(1, 0xffffff, 1);									
			this.graphics.drawRect( -w/2, -h/2, w, h);
			this.graphics.endFill();
			
			this.width = w;
			this.height = h;
		}
		
		
	}

}