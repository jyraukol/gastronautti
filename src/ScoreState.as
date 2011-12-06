package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class ScoreState extends FlxState 
	{
		private var scoreText:FlxText;
		private var fuelText:FlxText;
		
		public function ScoreState() 
		{
			
		}
		
		override public function create():void 
		{
			FlxG.bgColor = 0xff000000;
			scoreText = new FlxText(0, 50, FlxG.width, "Level Complete!");
			scoreText.alignment = "center";
			fuelText = new FlxText(0, scoreText.y + 20, FlxG.width, "Fuel Left: " + int(Registry.player.fuel));
			fuelText.alignment = "center";
			add(fuelText);
			
			var starsAchieved:int = Registry.player.fuel / 25 +1;
			if (starsAchieved > 3)
			{
				starsAchieved = 3;
			}
			
			if (starsAchieved == 1 || starsAchieved == 3)
			{
				add(new SpinningStar(FlxG.width / 2 -10, 100));
			}
			
			if (starsAchieved == 2)
			{
				add(new SpinningStar(FlxG.width / 2 - 15, 100));
				add(new SpinningStar(FlxG.width / 2 , 100));
			}
			
			if (starsAchieved == 3)
			{
				add(new SpinningStar(FlxG.width / 2 - 25, 100));
				add(new SpinningStar(FlxG.width / 2 + 5, 100));
			}
						
			add(scoreText);
			
			var instructions:FlxText = new FlxText(0, fuelText.y + 80, FlxG.width, "Press Enter to continue");
			instructions.alignment = "center";
			add(instructions);
			trace(starsAchieved);
			Registry.levelScores[Registry.levelIndex] = starsAchieved;
			
			super.create();		
		}
		
		override public function update():void 
		{
			if (FlxG.keys.ENTER)
			{
				FlxG.fade(0xFFFFFFFF, 1.5, switchState);
				
			}
			super.update();
		}
		
		private function switchState():void
		{
			
			if (Registry.levelIndex == Registry.levelNumber)
			{
				FlxG.switchState(new GameOverState);
			} else 
			{
				Registry.levelIndex++;
				FlxG.switchState(new PlayState);
			}
			
		}
	}

}