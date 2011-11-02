package  
{
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Registry 
	{
		[Embed(source="../assets/maps/mapCSV_Group1_Level2.csv", mimeType="application/octet-stream")] public static var map2CSV:Class;		
		[Embed(source = "../assets/maps/Level_level2.xml", mimeType = "application/octet-stream")]public static const level2DataXML:Class;
		[Embed(source="../assets/maps/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public static var map1CSV:Class;		
		[Embed(source = "../assets/maps/Level_level1.xml", mimeType = "application/octet-stream")]public static const level1DataXML:Class;
		
		public static var player:Gastronaut;
		public static var level:Level1;
		public static var spaceShip:SpaceShip;
		public static const thanksText:Array = new Array("Thanks!", "OMNOMNOM!", "Finally!", "Sweet!", "Pizza!");
		public static var topBarHeight:int;
		public static var levelIndex:uint = 1;
				
		public function Registry() 
		{
			
		}
		
	}

}