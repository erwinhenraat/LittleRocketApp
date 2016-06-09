package src.gameObjects 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Enemy extends Unit
	{
		
		public function Enemy() 
		{
			addChild(new libEnemy());
			var clip:MovieClip  = this.getChildAt(0) as MovieClip;
			clip.stop();
		}
		
	}

}