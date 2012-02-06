package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Door extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/door.png")] private var graphic:Class;
		private var leverId:int; // Which lever opens this door.
		
		public function Door(x:int, y:int, leverId:int, height:int) 
		{
			super(x, y);
			
			loadGraphic(graphic, false, false, 12, 12);
			this.height = height;
			this.immovable = true;
			this.scale.y = height * 1.0 / 12;
			centerOffsets();
			this.leverId = leverId;
		}
		
	}

}