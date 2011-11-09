package  
{
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Registry 
	{
		
		
		public static var player:Gastronaut;
		public static var level:Level1;
		public static var spaceShip:SpaceShip;
		public static const thanksText:Array = new Array("Thanks!", "OMNOMNOM!", "Finally!", "Sweet!", "Pizza!");
		public static var topBarHeight:int;
		public static var levelIndex:uint = 1;
		public static var levelScores:Array = new Array();
		public static var levelNumber:uint = 3; // save the number of levels the game has
				
		public function Registry() 
		{
			
		}
		
	}

}