package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class GameEndState extends FlxState 
	{
		private var starField:StarField;
		public function GameEndState() 
		{
			starField = new StarField(0, 2);
			add(starField);
			
			var congratulationsText:FlashingText = new FlashingText(20, "CONGRATULATIONS!", 0);
			congratulationsText.size = 20;
			add(congratulationsText);
			
			var instructions:FlxText;
			instructions = new FlxText(0, (FlxG.width / 2) - 20, FlxG.width, "The galaxy has been fed! And it's all thanks to you!");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			var instructions2:FlxText;
			instructions2 = new FlxText(0, instructions.y + 20, FlxG.width, "Thank you for playing");
			instructions2.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions2);
			
			var instructions3:FlxText;
			instructions3 = new FlashingText(FlxG.height - 25, "Press Enter", 0);			
			add(instructions3); 
		}
		
	}

}