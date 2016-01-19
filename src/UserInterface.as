package src 
{
	/**
	 * ...
	 * @author erwin henraat
	 */
	public class UserInterface extends libUserInterface
	{
		
		public function UserInterface() 
		{
			
		}
		public function update($doubleCount:int, $rapidCount:int, $a45Count:int, $a90Count:int, $wave:int, $highestWave)
		{
			/*doubleCount.text = String($doubleCount);
			rapidCount.text = String($rapidCount);
			angle45Count.text = String($a45Count);
			angle90Count.text = String($a90Count);*/
			waveCount.text = String("Wave - " + $wave);
			highestWave.text = String("Highest - " + $highestWave);
		}
		
	}

}