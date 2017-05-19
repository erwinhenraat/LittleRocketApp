package src.oldCode
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class SpaceShip extends MovieClip
	{
		private var exploded:Boolean
		private var explosion:MovieClip;
		public var main:Main;
		public var mustDie:Boolean = false;
		
		public function SpaceShip() 
		{
			exploded = false;
		}
		
		public function explode()
		{
			if (!exploded)
			{
				exploded = true; 
				stop();
				for (var i:int = 0; i < numChildren; i++) 
				{
					removeChild(getChildAt(i));
				}
				var ex:Explosion = new Explosion(main);
				main.explosions.push(ex);
				ex.x = x;
				ex.y = y;
				main.addChild(ex);
								
				if(main.contains(this))main.removeChild(this);
							
				if (this is Enemy) {
					var newPwr:Boolean = false;
					var index:int = main.enemies.indexOf(this);
					if(this is SplicerEnemy){
						main.splicerPool.push(main.enemies[index]);
						main.enemies.splice(index, 1);
					}
					else{
						main.enemyPool.push(main.enemies[index]);
						main.enemies.splice(index, 1);	
					}
					
					
								
					if(Math.random()*16<1 && main.powerup==null && main.special==null){
						main.powerup = new PowerUp(main,"special");
						newPwr = true;
					}
					else if (Math.random() * 8 < 1 && main.powerup==null)//terugveranderen naar 7
					{
						main.powerup = new PowerUp(main, "double");
						newPwr = true;
					}
					else if (Math.random() * 7 < 1 && main.powerup == null)
					{
						main.powerup = new PowerUp(main, "rapid");
						newPwr = true;
					}
					else if (Math.random() * 6 < 1 && main.powerup == null)
					{
						main.powerup = new PowerUp(main, "45angle");
						newPwr=true
					}
					else if (Math.random() * 5 < 1 && main.powerup == null)
					{
						main.powerup = new PowerUp(main, "90angle");
						newPwr = true;
					}
					if(newPwr){
						main.powerup.x = x;
						main.powerup.y = y;
						main.addChild(main.powerup);
					}
					
				}else if (this is Wingman)
				{
					main.wingmen.splice(main.wingmen.indexOf(this), 1);
				}
				else
				{
					main.plane = null;
				}
			}
		}
		
	
		
	}

}