package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class FuelCan extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/fuelCan.png")] private var graphic:Class;
		
		public function FuelCan() 
		{
			loadGraphic(graphic);
		}
		
	}

}