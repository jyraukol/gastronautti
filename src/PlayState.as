package
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	import org.flixel.plugin.photonstorm.FlxBar;
 
	public class PlayState extends FlxState
	{
		[Embed(source = "../assets/graphics/spaceship.png")] private var spaceshipPNG:Class;
		[Embed(source = "../assets/graphics/starsBackground.jpg")] private var starBackground:Class;
		private var floor:FlxTileblock;
		private var player:Gastronaut;
		private var platform:FlxTileblock;
		private var fuelBar:FlxBar;
		
		private var foodText:FlxText;
		private var foodNum:int;
		
		private var spaceHouses:FlxGroup = new FlxGroup();
		private var spaceShip:FlxSprite;
		private var starField:StarField;
		private var level:Level1;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			level = new Level1;
						
			
			
			for each (var house:SpaceHouse in level.houses)
			{
				spaceHouses.add(house);
			}
			
			foodNum = spaceHouses.length;
			
			foodText = new FlxText(260, 10, 60, "Food " + foodNum);
			
			spaceShip = new FlxSprite(level.spaceShipPosition.x, level.spaceShipPosition.y, spaceshipPNG);
			player = new Gastronaut(spaceShip.x, spaceShip.y);
			Registry.player = player;
			fuelBar = new FlxBar(16, 10, FlxBar.FILL_LEFT_TO_RIGHT, 80, 10, player, "fuel");
			//add(new FlxSprite(0, 0, starBackground));
			add(new StarField(0, 2));
			add(level);
			add(spaceHouses);
			add(spaceShip);
			add(player);		
			add(fuelBar);
			add(foodText);
			
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(player, level);
			
			FlxG.overlap(player, spaceHouses, foodDelivered);
			
			if (foodNum == 0)
			{
				FlxG.overlap(player, spaceShip, levelClear);
			}
		}
		
		private function foodDelivered(player:FlxObject, houseObject:FlxObject):void
		{
			var house:SpaceHouse = SpaceHouse(houseObject);
			if (!house.foodDeliveredHere)
			{
				foodNum -= 1;
				foodText.text = "Food " + foodNum;
				house.foodDeliveredHere = true;
			}
			
		}
		
		private function levelClear(player:Gastronaut, ship:FlxSprite):void
		{
			FlxG.switchState(new ScoreState);
		}
	}
}