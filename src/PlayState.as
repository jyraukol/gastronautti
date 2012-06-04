package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FX.*;	
	import org.flixel.plugin.photonstorm.*;	
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.FlxSound;
	
	public class PlayState extends FlxState
	{
		[Embed(source = "../assets/graphics/spaceMoped.png")] private var spaceshipPNG:Class;
		[Embed(source = "../assets/graphics/starsBackground.jpg")] private var starBackground:Class;
		[Embed(source = "../assets/graphics/barBackground.png")] private var hudBackground:Class;
		[Embed(source = "../assets/graphics/exclamation.png")] private var exclamationImage:Class;
		[Embed(source = "../assets/graphics/moon.png")] private var moonImage:Class;
		//[Embed(source = "../assets/music/CD2.mp3")] private var bgmusic:Class; // Music from http://soundcloud.com/juniorkobbe
		
		public var player:Gastronaut;
		private var fuelBar:FlxBar;
		private var bar:FlxSprite;		
		
		private var moneyText:FlxText;
		private var foodNum:int;
		private var thankText:FlxText;
		private var restartText:FlxText;
				
		private var spaceHouses:FlxGroup = new FlxGroup();
		private var tipTexts:FlxGroup = new FlxGroup();
		private var spaceShip:FlxSprite;
		private var starField:StarField;
		private var fuelCans:FlxGroup = new FlxGroup();
		private var laserEmitters:FlxGroup = new FlxGroup();
		private var levers:FlxGroup = new FlxGroup();
		private var doors:FlxGroup = new FlxGroup();
		private var portals:FlxGroup = new FlxGroup();
		private var fuelLow:ExclamationMark;
		private var laserEmitter:LaserEmitter;
		private var moon:FlxSprite;
				
		
		
		public var level:Level1;		
		
		private var deathTimer:Number = 0;		
				
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			
			level = Registry.level;
			if (level == null) {
				level = new Level1();
			}
			startLevel();			
		}
		
        private function startLevel():void {			
			createLevelObjects();
			Registry.playState = this;
			
			foodNum = spaceHouses.length;
            
            
			moneyText = new FlxText(200, 0, 150, "Money " + Registry.money);
			moneyText.setFormat(null, 8, 0xff000000);
			
            // This was used when players fuel reached 0, but now the player dies and restart is automatic
			restartText = new FlashingText(20, "R to restart", 0);
			restartText.visible = false;
			
			spaceShip = new FlxSprite(level.spaceShipPosition.x, level.spaceShipPosition.y, spaceshipPNG);
			player = new Gastronaut(spaceShip.x - 10, 0);
			player.y = spaceShip.y + spaceShip.height - player.height;
			Registry.player = player;
			player.setSpeed(Registry.playerXSpeedBoost, Registry.playerYSpeedBoost);
			
			fuelBar = new FlxBar(46, 2, FlxBar.FILL_LEFT_TO_RIGHT, 80, 10, player, "fuel");
			fuelBar.createGradientBar([0xFF000000], [0xffFF0000, 0xffFF8B17, 0xffFFFF00], 1, 180, false);
			
			starField = new StarField(0, 2);
			add(starField);
			moon = new FlxSprite(280, 50, moonImage);
			moon.velocity.x = -0.3;
			add(moon);
			add(new BackgroundEntities());
			add(level);
			
			// Add a bar for hud background
			bar = new FlxSprite(0, 0);
			bar.loadGraphic(hudBackground, false, false, 32, 13);
			bar.scale.x = FlxG.width;
			bar.width = FlxG.width;
			bar.alpha = 1;
			bar.immovable = true;
			add(bar);
			Registry.topBarHeight = bar.height;
						
			add(spaceHouses);
			add(tipTexts);
			add(spaceShip);
						
			add(laserEmitters);
			add(levers);
			add(doors);
			for each (var door:Door in doors.members ) {
				add(door.emitter);
			}
			
			add(portals);
			
			add(player);
			
			add(fuelCans);
			add(fuelBar);
			var fuelText:FlxText = new FlxText(2, 0, 50, "Fuel:");
			fuelText.setFormat(null, 8, 0xff000000);
			add(fuelText);
			add(moneyText);
			
			thankText = new FlxText(0, 0, 115, ""); 
			resetThankText();
			thankText.setFormat(null, 8, 0xFFFFFFFF);
			thankText.visible = false;
			add(thankText);
			add(restartText);
			
			fuelLow = new ExclamationMark(fuelBar.x + fuelBar.width + 10, fuelBar.y);
			fuelLow.exists = false;
			add(fuelLow);
			
			
			//add(new TextBox());
		}
				
		override public function update():void
		{
			
			
			super.update();
									
				FlxG.collide(player, level);
				FlxG.collide(player, bar);
				FlxG.collide(player, doors);
				FlxG.overlap(player, spaceHouses, foodDelivered);
				FlxG.overlap(player, fuelCans, fuelPickUp);
				FlxG.overlap(player, levers, pullLever);
				
				FlxG.overlap(player, laserEmitters, playerHitLaser);
				FlxG.overlap(player, portals, playerEnteredPortal);
				
				var tipTextNumber:int = 0;
				for each (var tipText:FlxText in level.houseTexts)
				{
										
					if (tipText.alive) {
						tipText.text = (level.houses[tipTextNumber].tipTimer).toFixed(2);
					}
					
					if (level.houses[tipTextNumber].tipTimer < 5 && tipText.color != 0xFFFF0000) {						
						tipText.color = 0xFFFF0000;
					}
					if (level.houses[tipTextNumber].tipTimer < 0) {
						tipText.alive = false;
						tipText.visible = false;
					}
					tipTextNumber++;
				}
			
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
				
				
				
				if (player.fuel < 25)
				{
					
					fuelLow.exists = true;
				} else
				{
					fuelLow.exists = false;
				}
				
				
				if (player.fuel == 0 || player.y > FlxG.height)
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
							Registry.fuel = Registry.fuelAtStartOfLevel;
							// Restart
							FlxG.flash(0xff000000, 1, Registry.restartLevel);
							
						}
					}
				}
				
				if (FlxG.keys.R)
				{
					Registry.restartLevel();
				}
				
				if (FlxG.keys.N)
				{
					levelClear(player, spaceShip);
				}
				
				if (FlxG.keys.I)
				{
					player.setSpeed(2, 2);
				}
				
				if (FlxG.keys.O)
				{
					player.setSpeed(-2, -2);
				}
				if (FlxG.keys.T)
				{
					Registry.money += 100;
				}
			
			
		}
		
		private function resetThankText():void
		{
			thankText.visible = false;
			thankText.alpha = 1;			
		}
		
		private function foodDelivered(player:FlxObject, houseObject:FlxObject):void
		{
			var house:SpaceHouse = SpaceHouse(houseObject);
			if (!house.foodDeliveredHere)
			{
				foodNum -= 1;
				add(new FlashingText(23, house.thankYou(), 3.5));
	
				
				tipTexts.members[house.houseNumber].alive = false;
				tipTexts.members[house.houseNumber].visible = false;
				moneyText.text = "Money " + Registry.money;
			}
			
		}
		
		public function clearStartField(): void {
			remove(starField);
		}
		
		private function fuelPickUp(player:Gastronaut, fuelcan:FuelCan):void
		{
			player.fuel += fuelcan.fuelAmount;
			
			add(new FlashingText(20, "+" + fuelcan.fuelAmount + " Fuel!", 3.5));
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
            
            // Player hit active laser, reset
			if (player.visible) {
				FlxG.play(Registry.explosionSound);
			}
				
			player.visible = false;
			player.moves = false;			
			
			FlxG.shake(0.05, 0.05, Registry.restartLevel);
		}
		
		private function pullLever(player:Gastronaut, lever:Lever):void {
			if (!lever.getPulled()) {
				lever.pull();
			
				for each (var door:Door in doors.members) {
					if (door.openDoor(lever.getID())) {
						door.emitter.start(false, 5);	
					}
					
				}
			}			
		}
		
		private function playerEnteredPortal(player:Gastronaut, portal:Portal):void {
			if (portal.canPortalBeUsed())
			{
				portal.goThroughPortal();
				portal.emitter.start(true, 1);
			}			
		}
		
		private function levelClear(player:Gastronaut, ship:FlxSprite):void
		{
			if ( Registry.levelIndex < Registry.levelNumber)
			{
				FlxG.switchState(new ShopState);		
			} else {
				FlxG.switchState(new MenuState);
			}
		}
        
        // Function for reading each level object (houses, fuelcans...) from level
        // and adding them to the flxGroup objects
        private function createLevelObjects():void
        {
            for each (var house:SpaceHouse in level.houses)
			{
				spaceHouses.add(house);
			}
			
			for each (var tipText:FlxText in level.houseTexts)
			{				
				tipTexts.add(tipText);
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
			
			for each (var lever:Lever in level.levers)
			{				
				levers.add(lever);
			}
			
			for each (var door:Door in level.doors)
			{								
				doors.add(door);				
			}
			
			for each (var portal:Portal in level.portals)
			{								
				portals.add(portal);				
				add(portal.emitter);
			}
        }
        
		override public function destroy():void 
		{			
			//super.destroy();			
		}
	}
}