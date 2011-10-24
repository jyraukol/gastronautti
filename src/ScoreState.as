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
			scoreText = new FlxText(150, 50, 100, "Level Complete!");
			fuelText = new FlxText(200, 70, 100, "Fuel Left: " + Registry.player.fuel);
			add(fuelText);
			
			
			for (var i:int = 1; i < Registry.player.fuel / 25; i++)
			{
				add(new SpinningStar(50 + i * 16, 100));
			}
			
			add(scoreText);
			super.create();		
		}
	}

}