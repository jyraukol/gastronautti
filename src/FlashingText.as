package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * A simple flashing text. Is centered horizontally, you can give the y-parameter. Duration controls
	 * how long the text will flash (0 for infinity).
	 * @author Jyri Raukola
	 */
	public class FlashingText extends FlxText
	{		
		private var duration:Number;
		private var flashInterval:int = 1;
		private var flashCounter:Number = 0;
		private var fading:Boolean = true;
		
		public function FlashingText(y:int, text:String, duration:Number, color:uint = 0xFFFFFFFF, x:int = 0, centered:Boolean = true) 
		{
			super(x, y, FlxG.width, text);			
			setFormat(null, 8, color);
			if (centered)
			{
				alignment = "center";
			}
			
			this.duration = duration;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (fading)
			{
				alpha -= FlxG.elapsed;
			} else
			{
				alpha += FlxG.elapsed;
			}
			
			flashCounter += FlxG.elapsed;
			if (flashCounter > flashInterval) 
			{
				fading = !fading;
				flashCounter = 0;
			}
			
			if (duration > 0)
			{
				duration -= FlxG.elapsed;
				if (duration <= 0) 
				{
					kill();
				}
			}
			
		}
	}

}