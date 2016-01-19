package src 
{
	import flash.filters.GlowFilter;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class SplicerEnemy extends Enemy 
	{
		private var timesSpliced:int = 0;
		private var maxSpliced:int = 2;
		
		
		public function SplicerEnemy($main:Main) 
		{
			
			super($main);			
			main = $main; 			
			gotoAndStop(2);
			animation.gotoAndPlay(Math.ceil(Math.random() * framesLoaded));
		
		}
		public function splitUp()
		{		
			var e:Enemy = new Enemy(main);			
			e.width = e.width*0.8;
			e.height = e.height*0.8;
			e.x = x+e.width;
			e.y = y;
			e.xSpeed = (3 + Math.random() * 3);
			e.ySpeed = ySpeed;
		
			
						
			var e2:Enemy = new Enemy(main);			
			e2.width = e2.width*0.8;
			e2.height = e2.height*0.8;
			e2.x = x-e.width;
			e2.y = y;
			e2.xSpeed = -(3 + Math.random() * 3);
			e2.ySpeed = ySpeed;
			
			
			main.enemies.push(e);			
			main.addChild(e);
			
			main.enemies.push(e2);			
			main.addChild(e2);					
		}
		
	}

}