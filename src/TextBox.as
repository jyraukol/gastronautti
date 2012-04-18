package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class TextBox extends FlxGroup 
	{
		private var text:FlxText;
		
		public function TextBox() 
		{
			var sprite:FlxSprite = new FlxSprite(50, 50);
			sprite.makeGraphic(50, 90, 0xff000000);
			add(sprite);
			
			text = new FlxText(50, 90, 50, "Test 123456:");
			add(text);
		}
		
	}

}