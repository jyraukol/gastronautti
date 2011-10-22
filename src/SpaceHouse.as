package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class SpaceHouse extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/spacehouse.png")] private var housePNG:Class;
		public var foodDeliveredHere:Boolean = false;
		
		public function SpaceHouse(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(housePNG);
			
		}
		
	}

}