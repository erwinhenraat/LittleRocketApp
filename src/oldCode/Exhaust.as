package src.oldCode 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class Exhaust extends MovieClip
	{
		private var fumes:Array = new Array();
		private var lastAmount:int = 1;
		public var numFumes:int = 1;
		public function Exhaust() 
		{
			fumes.push(new libVuur());
			addChild(fumes[0]);
			fumes[0].gotoAndPlay(Math.ceil(Math.random() * fumes[0].framesLoaded));
			
		}
		public function change($newAmount:Number)
		{		
			numFumes = $newAmount;
			
			while (numFumes < lastAmount) 
			{
				removeChild(fumes[fumes.length - 1]);
				fumes.splice(fumes.length - 1, 1);
				lastAmount--;
			}
			while (numFumes > lastAmount) 
			{ 
				fumes.push(new libVuur());
				addChild(fumes[fumes.length - 1]);
				fumes[fumes.length - 1].gotoAndPlay(Math.ceil(Math.random() * fumes[fumes.length - 1].framesLoaded));
				lastAmount++;
			}			
			
		}
		
	}

}