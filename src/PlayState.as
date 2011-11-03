package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FX.*;	
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.system.FlxTile;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.FlxSound;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../assets/graphics/spaceship.png")] private var spaceshipPNG:Class;
		[Embed(source = "../assets/graphics/starsBackground.jpg")] private var starBackground:Class;
		[Embed(source = "../assets/music/CD2.mp3")] private var bgmusic:Class; // Music from http://soundcloud.com/juniorkobbe
		private var floor:FlxTileblock;
		private var player:Gastronaut;
		private var platform:FlxTileblock;
		private var fuelBar:FlxBar;
		private var bar:FlxSprite;
		
		private var foodText:FlxText;
		private var foodNum:int;
		private var thankText:FlxText;
		
		private var spaceHouses:FlxGroup = new FlxGroup();
		private var spaceShip:FlxSprite;
		private var starField:FlxSprite;
		private var fuelCan:FuelCan;
		private var fuelPickupText:FlxText;
		
		private var level:Level1;
		public var stars:StarfieldFX;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			if (Registry.levelIndex == 1)
			{
				level = new Level1(Registry.map1CSV, Registry.level1DataXML);									
				Registry.levelIndex = 2;
			} else if (Registry.levelIndex == 2)
			{
				level = new Level1(Registry.map2CSV, Registry.level2DataXML);									
				Registry.levelIndex = 1;
			}
			
			
			for each (var house:SpaceHouse in level.houses)
			{
				spaceHouses.add(house);
			}
			
			foodNum = spaceHouses.length;
			
			foodText = new FlxText(260, 2, 60, "Food " + foodNum);
			foodText.setFormat(null, 8, 0xff000000);
			
			spaceShip = new FlxSprite(level.spaceShipPosition.x, level.spaceShipPosition.y, spaceshipPNG);
			player = new Gastronaut(spaceShip.x, spaceShip.y);
			Registry.player = player;
			fuelBar = new FlxBar(46, 2, FlxBar.FILL_LEFT_TO_RIGHT, 80, 10, player, "fuel");
			
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			stars = FlxSpecialFX.starfield();			
			starField = stars.create(0, 0, FlxG.width, FlxG.height, 50, 1, 20);
			
			add(starField);
			add(level);
			
			// Add a bar for hud background
			bar = new FlxSprite(0, 0);
			bar.makeGraphic(FlxG.width, 15, 0xFFC0C0C0);
			bar.alpha = 1;
			bar.immovable = true;
			add(bar);
			Registry.topBarHeight = bar.height;
			
			
			add(spaceHouses);
			add(spaceShip);
			add(player);
			fuelCan = new FuelCan();
			fuelCan.x = 50;
			fuelCan.y = 50;
			add(fuelCan);
			add(fuelBar);
			var fuelText:FlxText = new FlxText(2, 2, 50, "Fuel:");
			fuelText.setFormat(null, 8, 0xff000000);
			add(fuelText);
			add(foodText);
			
			fuelPickupText = new FlxText(0, 0, 75, "+25 fuel!");
			fuelPickupText.setFormat(null, 8, 0xFFFFFFFF);
			fuelPickupText.visible = false;
			add(fuelPickupText);
			
			thankText = new FlxText(0, 0, 75, "");
			resetThankText();
			thankText.setFormat(null, 8, 0xFFFFFFFF);
			thankText.visible = false;
			add(thankText);
			//FlxG.playMusic(bgmusic, 1);
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(player, level);
			FlxG.collide(player, bar);
			FlxG.overlap(player, spaceHouses, foodDelivered);
			FlxG.overlap(player, fuelCan, fuelPickUp);
			
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
			
			if (fuelPickupText.visible)
			{
				fuelPickupText.alpha -= 0.01;
				if (fuelPickupText.alpha <= 0)
				{
					fuelPickupText.visible = false;
					fuelPickupText.alpha = 1;
				}
			}
			
			if (FlxG.keys.R)
			{
				remove(starField);
				FlxG.switchState(new PlayState);
			}
		}
		
		private function resetThankText():void
		{
			thankText.visible = false;
			thankText.alpha = 1;

			var random:Number = Math.floor(Math.random() * Registry.thanksText.length);			
			thankText.text = Registry.thanksText[random];
		}
		
		private function foodDelivered(player:FlxObject, houseObject:FlxObject):void
		{
			var house:SpaceHouse = SpaceHouse(houseObject);
			if (!house.foodDeliveredHere)
			{
				foodNum -= 1;
				foodText.text = "Food " + foodNum;
				house.thankYou();
				thankText.x = house.x;
				thankText.y = house.y - 10;
				thankText.visible = true;
			}
			
		}
		
		private function fuelPickUp(player:Gastronaut, fuelcan:FuelCan):void
		{
			player.fuel += 25;
			
			fuelPickupText.x = fuelcan.x;
			fuelPickupText.y = fuelcan.y -10;
			
			fuelPickupText.visible = true;
			if (player.fuel > 100)
			{
				player.fuel = 100;
			}
			
			fuelcan.kill();
		}
		
		private function levelClear(player:Gastronaut, ship:FlxSprite):void
		{
			remove(starField);
			FlxG.switchState(new ScoreState);
		}
	}
}