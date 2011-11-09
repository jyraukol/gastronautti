package  
{
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
			for (var i:uint = 0; i < Registry.levelNumber; i++)
			{
				add(new FlxText(30, 50 + i * 12, 50, "Level " + (i + 1)));
				
				for (var j:int = 0; j < Registry.levelScores[i +1]; j++)
				{
					add(new SpinningStar(80 + j * 16, 48 + i * 12));
				}
			}
		}
		
	}

}