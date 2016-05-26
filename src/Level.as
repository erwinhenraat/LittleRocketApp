package src 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Level extends MovieClip
	{
		private var panels:Array = [new libSpaceLayer(), new libSpaceLayer(), new libSpaceLayer()];
		private var main:Main;
		private var bg:MovieClip;
		private var stars:Array = new Array();
	
		
		public function Level($main:Main) 
		{
			bg = new libSpace();
			addChild(bg);
			
			main = $main;
			for (var j:int = 0; j < panels.length; j++) 
			{
				panels[j].y = -j * panels[j].height;
				addChild(panels[j]);
			}
			
			for (var i:int = 0; i < (5+Math.ceil(Math.random()*2)); i++) 
			{
				newStar();
				stars[i].y = Math.random() * main.stage.stageHeight;
			}
		}
		private function newStar()
		{
			var star:MovieClip = new libStar();
			star.alpha = 0.3 + ((Math.random()*7)/ 10);
			star.speed = 5+ Math.random()*5//8+Math.ceil(Math.random() * 10);
			star.scaleY = 0.5 + Math.random();
			stars.push(star);
			star.x = Math.random() * main.stage.stageWidth;
			addChild(star);
		}
		public function scroll($speed:Number)
		{
			
			for (var i:int = 0; i < stars.length; i++) 
			{
				stars[i].y += $speed * stars[i].speed;//stars[i].speed;
				if (stars[i].y > main.stage.stageHeight + stars[i].height)
				{
					removeChild(stars[i]);
					stars.splice(i, 1);
					
					if (stars.length < 15)
					{					
						newStar();
					}
					
				}
			}
			
			for (var j:int = 0; j < panels.length; j++) 
			{
				var k:int = j - 1;
				if (k < 0) k = panels.length-1;
				panels[j].y += $speed;
				if (panels[j].y > main.stage.stageHeight)
				{
					panels[j].y = panels[k].y - panels[k].height + $speed;
				}
			}
			
		}
		
		
		
	}

}