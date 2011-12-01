package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class ExclamationMark extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/exclamation.png")] private var image:Class;
		private var fading:Boolean = false;
		private var flashCounter:Number = 0;
		
		public function ExclamationMark(x:int, y:int) 
		{
			super(x, y, image);
		}
		
		override public function update():void 
		{
			super.update();
			if (fading)
			{
				visible = false;
			} else
			{
				visible = true;
			}
			
			flashCounter += FlxG.elapsed;
			if (flashCounter > 0.3) 
			{
				fading = !fading;
				flashCounter = 0;
			}
		}
	}

}