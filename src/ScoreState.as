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
			scoreText = new FlxText(100, 50, 100, "Level Complete!");
			scoreText.alignment = "left";
			fuelText = new FlxText(100, 70, 100, "Fuel Left: " + int(Registry.player.fuel));
			fuelText.alignment = "left";
			add(fuelText);
			
			
			for (var i:int = 1; i < Registry.player.fuel / 25; i++)
			{
				add(new SpinningStar(100 + i * 16, 100));
			}
			
			add(scoreText);
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
			FlxG.switchState(new PlayState);
		}
	}

}