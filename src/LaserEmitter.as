package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class LaserEmitter extends FlxGroup
	{
		[Embed(source = "../assets/graphics/laser.png")] private var laserImage:Class;
		private var laser:FlxSprite;
		private var fireIntervalLimit:Number = 5;
		private var fireIntervalCounter:Number = 0;
		private var activeLimit:Number = 2;
		private var activeCounter:Number = 0;

		public function LaserEmitter(startX:int, startY:int, endX:int, endY:int) 
		{
			super();
			
			laser = new FlxSprite(startX, startY, laserImage);
			laser.scale.y = (endY - startY) / laser.height;
			laser.y = startY;
			laser.height = laser.height * laser.scale.y;
			laser.centerOffsets();
			laser.visible = false;
			var emitterStart:FlxSprite = new FlxSprite(startX -2, startY - 3);
			emitterStart.makeGraphic(laser.width + 4, 3, 0xFFC0C0C0);
			
			var emitterEnd:FlxSprite = new FlxSprite(endX -2, endY);
			emitterEnd.makeGraphic(laser.width + 4, 3, 0xFFC0C0C0);
			
			add(laser);
			add(emitterStart);
			add(emitterEnd);
		
		}
		
		override public function update():void 
		{
			super.update();
			
			fireIntervalCounter += FlxG.elapsed;
			
			if (fireIntervalCounter > fireIntervalLimit)
			{
				if (activeCounter == 0)
				{
					laser.visible = true;
					laser.flicker(2);
				}
				
				activeCounter += FlxG.elapsed;
				if (activeCounter > activeLimit)
				{
					fireIntervalCounter = 0;
					activeCounter = 0;
					laser.visible = false;
				} 
			}
		}
		
	}

}