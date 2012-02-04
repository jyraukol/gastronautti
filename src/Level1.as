package  
{
	import flash.geom.Point;
	import flash.xml.XMLNode;
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
		[Embed(source = "../assets/maps/Level_level2.xml", mimeType = "application/octet-stream")]public static const level2DataXML:Class;
		[Embed(source="../assets/maps/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public static var map1CSV:Class;		
		[Embed(source = "../assets/maps/Level_level1.xml", mimeType = "application/octet-stream")]public static const level1DataXML:Class;
		[Embed(source="../assets/maps/level3.csv", mimeType="application/octet-stream")] public static var map3CSV:Class;		
		[Embed(source = "../assets/maps/Level_level3.xml", mimeType = "application/octet-stream")]public static const level3DataXML:Class;
		[Embed(source = "../assets/maps/mapCSV_Level4_Map1.csv", mimeType = "application/octet-stream")] public static var map4CSV:Class;		
		[Embed(source = "../assets/maps/Level_Level4.xml", mimeType = "application/octet-stream")] public static const level4DataXML:Class;
		[Embed(source = "../assets/maps/ogmoTest.oel", mimeType = "application/octet-stream")] public static const ogmoLevel:Class;
		
		private var levelDataXML:Class;
		private var mapCSV:Class;
		
		public var LevelData:XML;
		public var map:FlxTilemap;
		public var houses:Vector.<SpaceHouse>;
		public var fuelCans:Vector.<FuelCan>;
		public var laserEmitters:Vector.<LaserEmitter>;
		public var spaceShipPosition:Point;
		
		public function Level1() 
		{
			super();
			
			if (Registry.levelIndex == 1)
			{								
				this.levelDataXML = level1DataXML;
				this.mapCSV = map1CSV;
			} else if (Registry.levelIndex == 2)
			{
				this.levelDataXML = level2DataXML;
				this.mapCSV = map2CSV;				
			} else if (Registry.levelIndex == 3)
			{
				this.levelDataXML = level3DataXML;
				this.mapCSV = map3CSV;
			}  else if (Registry.levelIndex == 4)
			{
				this.levelDataXML = level4DataXML;
				this.mapCSV = map4CSV;
			}
			else
			{
				// Load the first level for now
				this.levelDataXML = level1DataXML;
				this.mapCSV = map1CSV;
			}
			
			
			map = new FlxTilemap();			
						
			houses = new Vector.<SpaceHouse>();
			fuelCans = new Vector.<FuelCan>();
			laserEmitters = new Vector.<LaserEmitter>();
			
			map.loadMap(new mapCSV, mapTilesPNG, 12, 12, 0, 0, 1, 1); 
			var tempMap:Array = createCSVFromXML(ogmoLevel);
			
			add(map);
			
			loadSprites();
			
			map.setTileProperties(2, FlxObject.NONE);
			map.setTileProperties(3, FlxObject.NONE);
			map.setTileProperties(4, FlxObject.NONE);
			map.setTileProperties(5, FlxObject.NONE);
			map.setTileProperties(6, FlxObject.NONE);
			map.setTileProperties(7, FlxObject.NONE);
			Registry.level = this;
		}
		
		private function loadSprites():void
		{
			
			/* The old way commented out 
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
			
			
			
			dataList = LevelData.objects.LaserEmitter;
			
			var firstEmitter:Boolean = true;
			var startX:int;
			var startY:int;
			var fireInterval:int;
			
			for each (dataElement in dataList)
			{
				if (firstEmitter)
				{
					startX = int(dataElement.@x);
					startY = int(dataElement.@y);					
					fireInterval = int(dataElement.@fireInterval);
					firstEmitter = false;
				} else
				{					
					laserEmitters.push(new LaserEmitter(startX, startY,
										startX, int(dataElement.@y), fireInterval));
					firstEmitter = true;
				}
								
			}
			
			dataList = LevelData.objects.SpaceShip;
			spaceShipPosition = new Point(int(LevelData.objects.SpaceShip.@x), int(LevelData.objects.SpaceShip.@y)); */
			
		}
		
		private function createCSVFromXML(map:Class):Array {
			var array:Array = new Array();
			var bytes:ByteArray = new map;
			var file:XML = new XML(bytes.readUTFBytes(bytes.length));			
			
			
			if (file.level) {
				
				for each (var t:Object in file.level.tile) {									
					this.map.setTile(t.@x / 12, t.@y / 12, t.@id);
			
				}
			}
						
			if (file.objects) {
				
				// Only one spaceship
				var ship:Object = file.objects.spaceShip;
				spaceShipPosition = new Point(int(ship.@x), int(ship.@y))
				
				// Houses
				for each (var house:Object in file.objects.houses) {									
					houses.push(new SpaceHouse(int(house.@x), int(house.@y)));			
				}
				
				// Fuelcans
				for each (var can:Object in file.objects.fuelCans) {									
					fuelCans.push(new FuelCan(int(can.@x), int(can.@y)));			
				}
				
				// Lasers
				for each (var laser:Object in file.objects.lasers) {
					laserEmitters.push(new LaserEmitter(int(laser.@x), int(laser.@y), 0 ,0));			
				}
			}
			
			return array;
		}
		
	}
	
	

}