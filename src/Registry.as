package  
{
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Registry 
	{
		[Embed(source="../assets/mapCSV_Group1_Level2.csv", mimeType="application/octet-stream")] public static var mapCSV:Class;
		
		[Embed(source="../assets/maps/Level_level2.xml", mimeType = "application/octet-stream")]public static const levelDataXML:Class;
		public static var player:Gastronaut;
		public static var level:Level1;
		public static var spaceShip:SpaceShip;
		public static const thanksText:Array = new Array("Thanks!", "OMNOMNOM!", "Finally!", "Sweet!", "Pizza!");
		public static var topBarHeight:int;
		
		public function Registry() 
		{
			
		}
		
	}

}