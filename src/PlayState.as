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
		private var thankText:FlxText;
		
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
			
			thankText = new FlxText(0, 0, 65, "Thanks!");
			resetThankText();
			thankText.setFormat(null, 8, 0xFFFFFFFF);
			thankText.visible = false;
			add(thankText);
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
			
			if (thankText.visible)
			{
				thankText.alpha -= 0.01;
				if (thankText.alpha <= 0)
				{
					resetThankText();
				}
			}
		}
		
		private function resetThankText():void
		{
			thankText.visible = false;
			thankText.alpha = 1;
			var random:Number = Math.floor(Math.random() * (Registry.thanksText.length - 1)) + 1;
			trace(random);
			trace(Registry.thanksText[random]);
			thankText.text = Registry.thanksText[random];
		}
		
		private function foodDelivered(player:FlxObject, houseObject:FlxObject):void
		{
			var house:SpaceHouse = SpaceHouse(houseObject);
			if (!house.foodDeliveredHere)
			{
				foodNum -= 1;
				foodText.text = "Food " + foodNum;
				house.foodDeliveredHere = true;
				thankText.x = house.x;
				thankText.y = house.y - 10;
				thankText.visible = true;
			}
			
		}
		
		private function levelClear(player:Gastronaut, ship:FlxSprite):void
		{
			FlxG.switchState(new ScoreState);
		}
	}
}