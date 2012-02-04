package  
{
	import flash.geom.Point;
	import flash.xml.XMLNode;
	import org.flixel.FlxG;
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
		[Embed(source="../assets/maps/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public static var map1CSV:Class;						
		[Embed(source = "../assets/maps/level1.oel", mimeType = "application/octet-stream")] public static const ogmoLevel1:Class;
		[Embed(source = "../assets/maps/level2.oel", mimeType = "application/octet-stream")] public static const ogmoLevel2:Class;
		[Embed(source = "../assets/maps/level3.oel", mimeType = "application/octet-stream")] public static const ogmoLevel3:Class;
		[Embed(source = "../assets/maps/level3.oel", mimeType = "application/octet-stream")] public static const ogmoLevel4:Class;
		
		private var levelDataXML:Class;
		private var mapCSV:Class;
		
		public var LevelData:XML;
		public var map:FlxTilemap;
		public var houses:Vector.<SpaceHouse>;
		public var fuelCans:Vector.<FuelCan>;
		public var laserEmitters:Vector.<LaserEmitter>;
		public var spaceShipPosition:Point;
		
		public var levelMessageDisplayed:Boolean = false;
		
		public function Level1() 
		{
			super();
			
			map = new FlxTilemap();			
			this.mapCSV = map1CSV;
			
			
			houses = new Vector.<SpaceHouse>();
			fuelCans = new Vector.<FuelCan>();
			laserEmitters = new Vector.<LaserEmitter>();
			
			map.loadMap(new mapCSV, mapTilesPNG, 12, 12, 0, 0, 1, 1); 
			Registry.level = this;
						
			loadLevel();
		}
		
		public function loadLevel():void {
			if (Registry.levelIndex == 1)
			{								
				createCSVFromXML(ogmoLevel1);
			} else if (Registry.levelIndex == 2)
			{
				createCSVFromXML(ogmoLevel2);
			} else if (Registry.levelIndex == 3)
			{
				createCSVFromXML(ogmoLevel3);
			}  else if (Registry.levelIndex == 4)
			{
				createCSVFromXML(ogmoLevel4);
			}
			else
			{
				// Load the first level for now
				
				this.mapCSV = map1CSV;
			}
								
			add(map);
						
			map.setTileProperties(2, FlxObject.NONE);
			map.setTileProperties(3, FlxObject.NONE);
			map.setTileProperties(4, FlxObject.NONE);
			map.setTileProperties(5, FlxObject.NONE);
			map.setTileProperties(6, FlxObject.NONE);
			map.setTileProperties(7, FlxObject.NONE);
			
		}
		
		private function createCSVFromXML(map:Class):void {			
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
		}
		
	}
	
	

}