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
			
			var starsAchieved:int = Registry.player.fuel / 25;
			
			for (var i:int = 0; i < starsAchieved; i++)
			{
				add(new SpinningStar(FlxG.width / 2 - 16  + i * 16, 100));
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