package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class FlashingText extends FlxText
	{		
		private var duration:int;
		private var flashInterval:int = 1;
		private var flashCounter:Number = 0;
		private var fading:Boolean = true;
		
		public function FlashingText(y:int, text:String, duration:int) 
		{
			super(0, y, FlxG.width, text);			
			setFormat(null, 8, 0xFFFFFFFF, "center");
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
			
		}
	}

}