package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class LaserEmitter extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/laser.png")] private var lightningImage:Class;
		
		public function LaserEmitter(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(lightningImage, false, false, 7, 16);			
		}
		
		override public function update():void 
		{
			super.update();
		}
		
	}

}