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
		[Embed(source = "../assets/maps/level4.oel", mimeType = "application/octet-stream")] public static const ogmoLevel4:Class;
		[Embed(source = "../assets/maps/level5.oel", mimeType = "application/octet-stream")] public static const ogmoLevel5:Class;
		
		private var levelDataXML:Class;
		private var mapCSV:Class;
		
		public var LevelData:XML;
		public var map:FlxTilemap;
		public var houses:Vector.<SpaceHouse>;
		public var fuelCans:Vector.<FuelCan>;
		public var laserEmitters:Vector.<LaserEmitter>;
		public var levers:Vector.<Lever>;
		public var doors:Vector.<FlxSprite>; // Flxsprite for now
		public var spaceShipPosition:Point;
		
		public var levelMessageDisplayed:Boolean = true;
		public var levelMessageExists:Boolean = false;
		public var levelMessage:String;
		public var levelMessageObject:String = "";
		
		public function Level1() 
		{
			super();
			
			
			this.mapCSV = map1CSV;
			
			
			houses = new Vector.<SpaceHouse>();
			fuelCans = new Vector.<FuelCan>();
			laserEmitters = new Vector.<LaserEmitter>();
			levers = new Vector.<Lever>();
			doors = new Vector.<FlxSprite>();
			
			Registry.level = this;
		
						
					
			loadLevel();
		}
		
		public function loadLevel():void {			
			map = new FlxTilemap();						
			map.loadMap(new mapCSV, mapTilesPNG, 12, 12, 0, 0, 1, 1); 
			map.setTileProperties(2, FlxObject.NONE);
			map.setTileProperties(3, FlxObject.NONE);
			map.setTileProperties(4, FlxObject.NONE);
			map.setTileProperties(5, FlxObject.NONE);
			map.setTileProperties(6, FlxObject.NONE);
			map.setTileProperties(7, FlxObject.NONE);
			add(map);
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
			} else if (Registry.levelIndex == 5)
			{
				createCSVFromXML(ogmoLevel5);
			}
			
		}
		
		private function createCSVFromXML(map:Class):void {			
			var bytes:ByteArray = new map;
			var file:XML = new XML(bytes.readUTFBytes(bytes.length));			
			levelMessageExists = false;
						
			// Do we have a level spesific message to display?
			if (file.hasOwnProperty("@messageBeforeLevel") && file.attribute("messageBeforeLevel") != "") {
				levelMessage = file.attribute("messageBeforeLevel");
				levelMessageExists = true;
				levelMessageDisplayed = false;
				levelMessageObject = file.attribute("messageImageFileName");
				trace(levelMessageObject);
			}
			
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
				
				// Levers
				for each (var lever:Object in file.objects.levers) {
					levers.push(new Lever(int(lever.@x), int(lever.@y), int(lever.@leverId) ));			
				}
				
				
			}
		}
		
	}
	
	

}