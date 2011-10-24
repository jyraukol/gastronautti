package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class SpinningStar extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/star.png")] private var starPNG:Class;
		
		public function SpinningStar(x:int, y:int) 
		{
			super(x, y);
			loadRotatedGraphic(starPNG, 30, -1, false, false);
			
		}
		
		override public function update():void 
		{
			angle += 5;
			super.update();
		}
		
	}

}