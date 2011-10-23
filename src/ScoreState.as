package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class ScoreState extends FlxState 
	{
		private var scoreText:FlxText;
		
		public function ScoreState() 
		{
			
		}
		
		override public function create():void 
		{
			scoreText = new FlxText(150, 50, 100, "Level Complete!");
			add(scoreText);
			super.create();
		}
	}

}