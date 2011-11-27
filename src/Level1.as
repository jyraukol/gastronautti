package  
{
	import flash.geom.Point;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import flash.utils.ByteArray;
	import XML;
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Level1 extends FlxGroup 
	{
		[Embed(source = "../assets/graphics/block2.png")] public static var mapTilesPNG:Class;
		[Embed(source="../assets/maps/mapCSV_Level3_Map1.csv", mimeType="application/octet-stream")] public static var map2CSV:Class;		
		[Embed(source = "../assets/maps/Level_level3.xml", mimeType = "application/octet-stream")]public static const level2DataXML:Class;
		[Embed(source="../assets/maps/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public static var map1CSV:Class;		
		[Embed(source = "../assets/maps/Level_level1.xml", mimeType = "application/octet-stream")]public static const level1DataXML:Class;
		[Embed(source="../assets/maps/mapCSV_Group1_level2.csv", mimeType="application/octet-stream")] public static var map3CSV:Class;		
		[Embed(source = "../assets/maps/Level_level2.xml", mimeType = "application/octet-stream")]public static const level3DataXML:Class;
		
		private var levelDataXML:Class;
		private var mapCSV:Class;
		
		public var LevelData:XML;
		public var map:FlxTilemap;
		public var houses:Vector.<SpaceHouse>;
		public var fuelCans:Vector.<FuelCan>;
		public var spaceShipPosition:Point;
		
		public function Level1() 
		{
			super();
			
			if (Registry.levelIndex == 1)
			{
				//level = new Level1(Registry.map1CSV, Registry.level1DataXML);									
				this.levelDataXML = level1DataXML;
				this.mapCSV = map1CSV;
				//Registry.levelIndex = 2;
			} else if (Registry.levelIndex == 2)
			{
				//level = new Level1(Registry.map2CSV, Registry.level2DataXML);									
				//Registry.levelIndex = 1;
				this.levelDataXML = level2DataXML;
				this.mapCSV = map2CSV;				
			} else if (Registry.levelIndex == 3)
			{
				//level = new Level1(Registry.map2CSV, Registry.level2DataXML);									
				//Registry.levelIndex = 1;
				this.levelDataXML = level3DataXML;
				this.mapCSV = map3CSV;
			}
			else
			{
				// Load the first level for now
				this.levelDataXML = level1DataXML;
				this.mapCSV = map1CSV;
			}
			
			
			map = new FlxTilemap;			
			
			map.loadMap(new mapCSV, mapTilesPNG, 12, 11, 0, 0, 1, 1); 
			
			add(map);
			houses = new Vector.<SpaceHouse>();
			fuelCans = new Vector.<FuelCan>();
			loadSprites();
			
			map.setTileProperties(2, FlxObject.NONE);
			map.setTileProperties(3, FlxObject.NONE);
			map.setTileProperties(4, FlxObject.NONE);
			map.setTileProperties(5, FlxObject.NONE);
			map.setTileProperties(6, FlxObject.NONE);
			map.setTileProperties(7, FlxObject.NONE);
			
			/*for each (var coords:FlxPoint in map.getTileCoords(4))
			{
				var sprite:FlxSprite = new FlxSprite(coords.x, coords.y);				
				sprite.offset.x = 3;
				sprite.immovable = true;
				sprite.visible = false;
				add(sprite);
				
			}
			
			for each (var coords:FlxPoint in map.getTileCoords(3))
			{
				var sprite:FlxSprite = new FlxSprite(coords.x, coords.y + 5);
				sprite.alpha = 0;
				sprite.height = 6;
				sprite.visible = false;
				sprite.immovable = true;
				add(sprite);
				
			}*/
			
			//add(new FlxSprite(50, 50, satellite));
			
		}
		
		private function loadSprites():void
		{
			
			
			var rawData:ByteArray = new levelDataXML;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			
			var LevelData:XML = new XML(dataString);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			dataList = LevelData.objects.SpaceHouse;
			
			for each (dataElement in dataList)
			{
				
				houses.push(new SpaceHouse(int(dataElement.@x), int(dataElement.@y)));
			}
			
			dataList = LevelData.objects.FuelCan;
			
			for each (dataElement in dataList)
			{
				
				fuelCans.push(new FuelCan(int(dataElement.@x), int(dataElement.@y)));
			}
			
			dataList = LevelData.objects.SpaceShip;
			spaceShipPosition = new Point(int(LevelData.objects.SpaceShip.@x), int(LevelData.objects.SpaceShip.@y));
			
		}
		
	}

}