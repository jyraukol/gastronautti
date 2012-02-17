package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class SpaceShip extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/spacemoped.png")] private var shipPNG:Class;
		
		public function SpaceShip(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(shipPNG);
			
		}
		
	}

}