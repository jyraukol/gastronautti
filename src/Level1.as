package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Level1 extends FlxGroup 
	{
		[Embed(source = "../assets/maps/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] public var mapCSV:Class;
		[Embed(source = "../assets/graphics/tilesTest.png")] public var mapTilesPNG:Class;
		
		public var map:FlxTilemap;
		
		public function Level1() 
		{
			super();
			
			map = new FlxTilemap;			
			map.loadMap(new mapCSV, mapTilesPNG, 16, 16, 0, 0, 1, 1); 
			
			add(map);
		}
		
		private function parseHouses():void
		{
			
		}
		
	}

}