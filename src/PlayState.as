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
		
		private var foodText:FlxText;
		private var foodNum:int;
		private var thankText:FlxText;
		
		private var spaceHouses:FlxGroup = new FlxGroup();
		private var spaceShip:FlxSprite;
		private var starField:FlxSprite;
		private var level:Level1;
		public var stars:StarfieldFX;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			level = new Level1;
						
			
			
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
			fuelBar = new FlxBar(16, 2, FlxBar.FILL_LEFT_TO_RIGHT, 80, 10, player, "fuel");
			
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			stars = FlxSpecialFX.starfield();			
			starField = stars.create(0, 0, FlxG.width, FlxG.height, 50, 1, 20);
			
			add(starField);
			
			// Add a bar for hud background
			var bar:FlxSprite = new FlxSprite(0, 0);
			bar.makeGraphic(FlxG.width, 15, 0xFFC0C0C0);
			bar.alpha = 1;
			add(bar);
			
			add(level);
			add(spaceHouses);
			add(spaceShip);
			add(player);		
			add(fuelBar);
			add(foodText);
			
			thankText = new FlxText(0, 0, 75, "");
			resetThankText();
			thankText.setFormat(null, 8, 0xFFFFFFFF);
			thankText.visible = false;
			add(thankText);
			FlxG.playMusic(bgmusic, 1);
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
				house.foodDeliveredHere = true;
				thankText.x = house.x;
				thankText.y = house.y - 10;
				thankText.visible = true;
			}
			
		}
		
		private function levelClear(player:Gastronaut, ship:FlxSprite):void
		{
			remove(starField);
			FlxG.switchState(new ScoreState);
		}
	}
}