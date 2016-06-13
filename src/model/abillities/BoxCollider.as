package src.model.abillities 
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
			height = h;
			width = w;
			trace("drw that sht");
			var s:Shape = new Shape();
			
			s.graphics.beginFill(0xff00ff, 1);
			s.graphics.drawRect( 0, 0, w, h);
			s.graphics.endFill();
			
			addChild(s)
			
		}
		
		
	}

}