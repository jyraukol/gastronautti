package
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	import org.flixel.plugin.photonstorm.FlxBar;
 
	public class PlayState extends FlxState
	{
		[Embed(source = "../assets/graphics/spaceship.png")] private var spaceshipPNG:Class;
		private var floor:FlxTileblock;
		private var player:Gastronaut;
		private var platform:FlxTileblock;
		private var fuelBar:FlxBar;
		
		private var foodText:FlxText;
		private var foodNum:int = 1;
		
		private var spaceHouse:SpaceHouse;
		private var spaceShip:FlxSprite;
		
		private var level:Level1;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff144954;
			
			level = new Level1;
			
			player = new Gastronaut();
			Registry.player = player;
			fuelBar = new FlxBar(16, 10, FlxBar.FILL_LEFT_TO_RIGHT, 80, 10, player, "fuel");
			
			floor = new FlxTileblock(0, 208, 320, 32);
			floor.makeGraphic(320, 32, 0xff689c16);
			
			platform = new FlxTileblock(100, 50, 64, 32);
			platform.makeGraphic(64, 32, 0xff689c16);
			
			foodText = new FlxText(260, 10, 60, "Food " + foodNum);
			
			spaceHouse = new SpaceHouse(116, 50 -30);
			spaceShip = new FlxSprite(FlxG.width - 62, 180, spaceshipPNG);
			add(level);
			add(spaceHouse);
			add(spaceShip);
			add(player);
			//add(floor);
			//add(platform);			
			add(fuelBar);
			add(foodText);
			
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(player, level);
			
			FlxG.overlap(player, spaceHouse, foodDelivered);
			
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