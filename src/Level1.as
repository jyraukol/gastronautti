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
		private var levelDataXML:Class;
		public var LevelData:XML;
		public var map:FlxTilemap;
		public var houses:Vector.<SpaceHouse>;
		public var fuelCans:Vector.<FuelCan>;
		public var spaceShipPosition:Point;
		
		public function Level1(mapCSV:Class, levelDataXML:Class) 
		{
			super();
			this.levelDataXML = levelDataXML;
			map = new FlxTilemap;			
			
			map.loadMap(new mapCSV, mapTilesPNG, 12, 11, 0, 0, 1, 1); 
			
			add(map);
			houses = new Vector.<SpaceHouse>();
			fuelCans = new Vector.<FuelCan>();
			loadSprites();
			
			map.setTileProperties(4, FlxObject.NONE);
			map.setTileProperties(5, FlxObject.NONE);
			map.setTileProperties(6, FlxObject.UP);
			
			for each (var coords:FlxPoint in map.getTileCoords(4))
			{
				var sprite:FlxSprite = new FlxSprite(coords.x, coords.y);
				sprite.alpha = 0;
				sprite.offset.x = 3;
				sprite.immovable = true;
				add(sprite);
				
			}
			
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