package  
{
	import org.flixel.FlxPath;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxBar;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class ShopState extends FlxState 
	{
		private var starField:StarField;
		private var currentSelection:int = 0;
		private var refuelText:FlxText;
		private var upgradeSpeedText:FlxText;
		private var upgradeFuelConsumption:FlxText;
		private var continueText:FlxText;
		private var moneyText:FlxText;
		private var infoText:FlashingText;
		
		public function ShopState() 
		{			
			starField = new StarField(0, 2);
			add(starField);
			
			var shopText:FlxText;
			shopText = new FlxText(0, 18, FlxG.width, "Shop!");
			shopText.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(shopText);
						
			moneyText = new FlxText(0, shopText.y + 16, FlxG.width, "Gigazoids: " + Registry.money);
			moneyText.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(moneyText);
					
			var bar:FlxBar = new FlxBar(FlxG.width / 2 - 40, moneyText.y + 16, FlxBar.FILL_LEFT_TO_RIGHT, 80, 10, Registry, "fuel");
			add(bar);
						
			refuelText = new FlxText(0, bar.y + 16, FlxG.width, "Refuel: 15 Gigazoids");
			refuelText.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(refuelText);
			
			upgradeSpeedText = new FlxText(0, refuelText.y + 16, FlxG.width, "Upgrade jetpack power: 100 Gigazoids");
			upgradeSpeedText.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(upgradeSpeedText);
						
			upgradeFuelConsumption = new FlxText(0, upgradeSpeedText.y + 16, FlxG.width, "Less consuming motors: 200 Gigazoids");
			upgradeFuelConsumption.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(upgradeFuelConsumption);
			
			infoText = new FlashingText(upgradeFuelConsumption.y + 26, "", 3);			
			add(infoText);
			
			continueText:FlxText;
			continueText = new FlxText(0, FlxG.height - 25, FlxG.width, "Continue");			
			continueText.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(continueText); 
		}
		
		override public function update():void
		{    
			if (currentSelection == 0) {
				continueText.color = 0xFFFFFFFF;
				refuelText.color = 0xFF80FF80;
				upgradeSpeedText.color = 0xFFFFFFFF;
			} else if (currentSelection == 1) {
				refuelText.color = 0xFFFFFFFF;
				upgradeSpeedText.color = 0xFF80FF80;
				upgradeFuelConsumption.color = 0xFFFFFFFF;
			} else if (currentSelection == 2) {
				upgradeSpeedText.color = 0xFFFFFFFF;
				upgradeFuelConsumption.color = 0xFF80FF80;
				continueText.color = 0xFFFFFFFF;
			} else if (currentSelection == 3) {
				upgradeFuelConsumption.color = 0xFFFFFFFF;
				continueText.color = 0xFF80FF80;
				refuelText.color = 0xFFFFFFFF;
			}
			
			if (FlxG.keys.justPressed("DOWN")) {
				moveSelectionDown();
			}
			
			if (FlxG.keys.justPressed("UP")) {
				moveSelectionUp();
			}
			
			if (FlxG.keys.justPressed("ENTER")) 
			{
				if (currentSelection == 0) {
					purchaseFuel();					
				} else if (currentSelection == 1) {
					purchaseSpeedUpgrade();
				} else if (currentSelection == 2) {
					purchaseFuelUpgrade();
				}
				else if (currentSelection == 3) {
					FlxG.flash(0xffffffff, 0.75);
					FlxG.fade(0xff000000, 1, onFade);
				}
				
			}
			
			super.update();		
		}
		
		private function moveSelectionDown():void {
			currentSelection++;
			
			if (currentSelection > 3) {
				currentSelection = 0;
			}
		}
		
		private function moveSelectionUp():void {
			currentSelection--;
			
			if (currentSelection < 0) {
				currentSelection = 3;
			}
		}
		
		private function purchaseFuel():void {
			if (Registry.money >= 15 && Registry.fuel < 100.0) {
				Registry.money -= 15;
				Registry.fuel = 100.0;
				moneyText.text = "Gigazoids " + Registry.money;
				infoMessage("Full tank of fuel!");
			} else {
				if (Registry.fuel == 100.0) {
					infoMessage("Your tank is already full!");
				} else {
					infoMessage("You need more Gigazoids!");
				}				
			}
			
		}
		
		private function purchaseSpeedUpgrade():void {
			if (Registry.money >= 100 ) {
				Registry.money -= 100;
				infoMessage("Your jetpack is now more powerful!");
				Registry.playerXSpeedBoost += 5;
				Registry.playerYSpeedBoost += 5;
				moneyText.text = "Gigazoids " + Registry.money;
			} else {
				infoMessage("You need more Gigazoids!");
			}			
		}
		
		private function purchaseFuelUpgrade():void {
			if (Registry.money >= 200 ) {								
				var upgradeable:Boolean = false;
				
				if (Registry.fuelConsumption >= 0.2) {
					Registry.fuelConsumption -= 0.1;
					upgradeable = true;					
				} else if (Registry.fuelConsumption >= 0.06) {
					Registry.fuelConsumption -= 0.04;
					upgradeable = true;					
				}
				
				if (upgradeable) {
					infoMessage("Your jetpack spends less fuel!");
					Registry.money -= 200;
					moneyText.text = "Gigazoids " + Registry.money;
				} else {
					infoMessage("Your jetpack cannot be upgraded any more!");
				}
				
			} else {
				infoMessage("You need more Gigazoids!");
			}
			
		}
		
		private function infoMessage(message:String):void {
			infoText.text = message;
			infoText.restartFlashing(5);
		}
		
		private function onFade():void
		{	
			Registry.loadNextLevel();
			
		}
		
	}

}