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
		private var continueText:FlxText;
		private var moneyText:FlxText;
		
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
			} else if (currentSelection == 1) {
				refuelText.color = 0xFFFFFFFF;
				continueText.color = 0xFF80FF80;
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
				}
				else if (currentSelection == 1) {
					FlxG.flash(0xffffffff, 0.75);
					FlxG.fade(0xff000000, 1, onFade);
				}
				
			}
			
			super.update();		
		}
		
		private function moveSelectionDown():void {
			currentSelection++;
			
			if (currentSelection > 1) {
				currentSelection = 0;
			}
		}
		
		private function moveSelectionUp():void {
			currentSelection--;
			
			if (currentSelection < 0) {
				currentSelection = 1;
			}
		}
		
		private function purchaseFuel():void {
			if (Registry.money >= 15 && Registry.fuel < 100.0) {
				Registry.money -= 15;
				Registry.fuel = 100.0;
				moneyText.text = "Gigazoids " + Registry.money;
			}
			
		}
		
		private function onFade():void
		{			
			FlxG.switchState(new PlayState);
		}
		
	}

}