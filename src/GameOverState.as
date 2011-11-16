package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class GameOverState extends FlxState 
	{
		
		public function GameOverState() 
		{
			// Print all the level names and achieved star amounts.
			for (var i:uint = 0; i < Registry.levelNumber; i++)
			{
				add(new FlxText(30, 50 + i * 12, 50, "Level " + (i + 1)));
				
				for (var j:int = 0; j < Registry.levelScores[i +1]; j++)
				{
					add(new SpinningStar(80 + j * 16, 48 + i * 12));
				}
			}
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
			
			Registry.levelIndex = 1;
			FlxG.switchState(new MenuState);
						
		}
		
	}

}