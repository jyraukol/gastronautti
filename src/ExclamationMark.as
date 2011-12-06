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
		private var text:FlashingText;
		
		public function ExclamationMark(x:int, y:int) 
		{
			super(x, y, image);
			text = new FlashingText(y - 2, "Fuel Low", -1, 0xFF0000, x + width + 10, false);
			text.visible = false;
			Registry.playState.add(text);
		}
		
		override public function update():void 
		{
			text.visible = true;
			if (fading)
			{
				visible = false;
				//text.visible = false;
			} else
			{
				visible = true;
				//text.visible = true;
			}
			
			flashCounter += FlxG.elapsed;
			if (flashCounter > 0.3) 
			{
				fading = !fading;
				flashCounter = 0;
			}
			super.update();
		}
	}

}