package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FX.*;	
	import org.flixel.plugin.photonstorm.*;	
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.FlxSound;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../assets/graphics/spaceship2.png")] private var spaceshipPNG:Class;
		[Embed(source = "../assets/graphics/starsBackground.jpg")] private var starBackground:Class;
		[Embed(source = "../assets/graphics/barBackground.png")] private var hudBackground:Class;
		[Embed(source = "../assets/graphics/exclamation.png")] private var exclamationImage:Class;
		[Embed(source = "../assets/graphics/moon.png")] private var moonImage:Class;
		//[Embed(source = "../assets/music/CD2.mp3")] private var bgmusic:Class; // Music from http://soundcloud.com/juniorkobbe
		private var player:Gastronaut;
		private var fuelBar:FlxBar;
		private var bar:FlxSprite;		
		
		private var foodText:FlxText;
		private var foodNum:int;
		private var thankText:FlxText;
		private var restartText:FlxText;
		
		private var spaceHouses:FlxGroup = new FlxGroup();
		private var spaceShip:FlxSprite;
		private var starField:FlxSprite;
		private var fuelCans:FlxGroup = new FlxGroup();
		private var laserEmitters:FlxGroup = new FlxGroup();
		private var fuelLow:ExclamationMark;
		private var laserEmitter:LaserEmitter;
		private var moon:FlxSprite;
		
		//private var fuelPickupText:FlxText;
		
		public var level:Level1;
		public var stars:StarfieldFX;
		
		private var deathTimer:Number = 0;		
		
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			level = new Level1();
			Registry.playState = this;
			
			createLevelObjects();
			
			foodNum = spaceHouses.length;
            
            // Is this really needed, the graphics tell you how much food is left
			//foodText = new FlxText(260, 2, 60, "Food " + foodNum);
			//foodText.setFormat(null, 8, 0xff000000);
			
            // This was used when players fuel reached 0, but now the player dies and restart is automatic
			restartText = new FlashingText(20, "R to restart", 0);
			restartText.visible = false;
			
			spaceShip = new FlxSprite(level.spaceShipPosition.x, level.spaceShipPosition.y, spaceshipPNG);
			player = new Gastronaut(spaceShip.x + spaceShip.width / 2, 0);
			player.y = spaceShip.y + spaceShip.height - player.height;
			Registry.player = player;
			fuelBar = new FlxBar(46, 2, FlxBar.FILL_LEFT_TO_RIGHT, 80, 10, player, "fuel");
			
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			stars = FlxSpecialFX.starfield();			
			starField = stars.create(0, 0, FlxG.width, FlxG.height, 50, 1, 20);
			
			add(starField);
			moon = new FlxSprite(280, 50, moonImage);
			moon.velocity.x = -0.3;
			add(moon);
			add(level);
			
			// Add a bar for hud background
			bar = new FlxSprite(0, 0);
			bar.loadGraphic(hudBackground, false, false, 32, 15);
			bar.scale.x = FlxG.width;
			bar.width = FlxG.width;
			bar.alpha = 1;
			bar.immovable = true;
			add(bar);
			Registry.topBarHeight = bar.height;
						
			add(spaceHouses);
			add(spaceShip);
						
			add(laserEmitters);
			add(player);
			
			add(fuelCans);
			add(fuelBar);
			var fuelText:FlxText = new FlxText(2, 2, 50, "Fuel:");
			fuelText.setFormat(null, 8, 0xff000000);
			add(fuelText);
			//add(foodText);
			
			thankText = new FlxText(0, 0, 75, "");
			thankText.alignment = "center"; 
			resetThankText();
			thankText.setFormat(null, 8, 0xFFFFFFFF);
			thankText.visible = false;
			add(thankText);
			add(restartText);
			
			fuelLow = new ExclamationMark(fuelBar.x + fuelBar.width + 10, fuelBar.y);
			fuelLow.exists = false;
			add(fuelLow);
			//FlxG.playMusic(bgmusic, 1);
			
		}
		        
		override public function update():void
		{
			super.update();
			
			FlxG.collide(player, level);
			FlxG.collide(player, bar);
			FlxG.overlap(player, spaceHouses, foodDelivered);
			FlxG.overlap(player, fuelCans, fuelPickUp);
			
			FlxG.overlap(player, laserEmitters, playerHitLaser);
			
			
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
			
			/*if (fuelPickupText.visible)
			{
				fuelPickupText.alpha -= 0.01;
				if (fuelPickupText.alpha <= 0)
				{
					fuelPickupText.visible = false;
					fuelPickupText.alpha = 1;
				}
			}*/
			
			if (player.fuel < 25)
			{
				
				fuelLow.exists = true;
			} else
			{
				fuelLow.exists = false;
			}
			
			
			if (player.fuel == 0)
			{
				//restartText.visible = true;				
				// First thing
				if (deathTimer == 0)
				{
					// Slow down the game
					FlxG.timeScale = 0.3;
					// Set the timer
					deathTimer = 1.5;
					
				}
				else
				{
										
					deathTimer -= FlxG.elapsed;
						
					player.scale.x *= 0.97;
					player.scale.y *= 0.97;
					if (deathTimer <= 1)
					{
						FlxG.fade(0xff000000, 1);					
					}
					// The last tick
					if (deathTimer <= FlxG.elapsed)
					{
						FlxG.timeScale = 1.0;
						// Restart
						FlxG.flash(0xff000000, 1, resetLevel);
						
					}
				}
			}
			
			if (FlxG.keys.R)
			{
				remove(starField);
				FlxG.switchState(new PlayState);
			}
			
			if (FlxG.keys.N)
			{
				levelClear(player, spaceShip);
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
				//foodText.text = "Food " + foodNum;
				house.thankYou();
				thankText.x = house.x - 22;
				thankText.y = house.y - 15;
				thankText.visible = true;
			}
			
		}
		
		private function resetLevel():void 
		{
			remove(starField);
			FlxG.switchState(new PlayState);
		}
		
		private function fuelPickUp(player:Gastronaut, fuelcan:FuelCan):void
		{
			player.fuel += fuelcan.fuelAmount;
			
			//fuelPickupText.x = fuelcan.x;
			//fuelPickupText.y = fuelcan.y -10;
			add(new FlashingText(20, "+" + fuelcan.fuelAmount + " Fuel!", 3.5));
			//fuelPickupText.visible = true;
			if (player.fuel > 100)
			{
				player.fuel = 100;
			}
			
			fuelcan.kill();
		}
		
		private function playerHitLaser(player:Gastronaut, laser:FlxSprite):void
		{
            // Laser isn't on screen (active) so player can pass
			if (!laser.visible) 
			{
				return;
			}
            
            // Player hit active laser, resetLevel
			player.visible = false;
			player.moves = false;
			FlxG.shake(0.05, 0.05, resetLevel);
		}
		
		private function levelClear(player:Gastronaut, ship:FlxSprite):void
		{
			remove(starField);
			FlxG.switchState(new ScoreState);
		}
        
        // Function for reading each level object (houses, fuelcans...) from level
        // and adding them to the flxGroup objects
        private function createLevelObjects():void
        {
            for each (var house:SpaceHouse in level.houses)
			{
				spaceHouses.add(house);
			}
			
			for each (var can:FuelCan in level.fuelCans)
			{
				fuelCans.add(can);
			}
            
            for each (var laserEmitter:LaserEmitter in level.laserEmitters)
			{
				laserEmitter.generateLaser();
				laserEmitters.add(laserEmitter);
			}
        }
        
	}
}