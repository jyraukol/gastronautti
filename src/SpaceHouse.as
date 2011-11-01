package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
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
			loadGraphic(housePNG, true, false,32, 32);	
			
			addAnimation("open", [0], 0, false);
			addAnimation("closed", [1], 0, false);
			
			play("open");
			
		}
		
		public function thankYou():void
		{
			foodDeliveredHere = true;
			play("closed");
		}
	}

}