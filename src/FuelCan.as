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
		public var fuelAmount:int;
        
		public function FuelCan(x:int, y:int, amount:int = 25) 
		{			
			super(x, y -4);
			loadGraphic(graphic);
			height = 16
			centerOffsets();
            fuelAmount = amount;
		}
		
	}

}