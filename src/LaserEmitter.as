package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class LaserEmitter extends FlxGroup
	{
		[Embed(source = "../assets/graphics/laser.png")] private var laserImage:Class;
		private var laser:FlxSprite;
		private var emitterStart:FlxSprite;
		private var emitterEnd:FlxSprite;
		private var fireIntervalLimit:Number = 5;
		private var fireIntervalCounter:Number = 0;
		private var activeLimit:Number = 2;
		private var activeCounter:Number = 0;
		public var laserActive:Boolean = false;
		private var laserGettingReady:Boolean = false;
		
		public function LaserEmitter(startX:int, startY:int, endX:int, endY:int) 
		{
			
			
			laser = new FlxSprite(startX, startY, laserImage);
			laser.scale.y = (endY - startY) / laser.height;
			laser.y = startY;
			laser.height = laser.height * laser.scale.y;
			laser.centerOffsets();
			laser.visible = false;
			emitterStart = new FlxSprite(startX -2, startY - 3);
			emitterStart.makeGraphic(laser.width + 4, 3, 0xFFC0C0C0);
			emitterStart.allowCollisions = FlxObject.NONE;
			
			emitterEnd = new FlxSprite(endX -2, endY);
			emitterEnd.makeGraphic(laser.width + 4, 3, 0xFFC0C0C0);
			emitterEnd.allowCollisions = FlxObject.NONE;
			
			
			add(emitterStart);
			add(emitterEnd);
			add(laser);
		
		}
		
		override public function update():void 
		{
			super.update();
			
			fireIntervalCounter += FlxG.elapsed;
			
			if (fireIntervalCounter > fireIntervalLimit - 1.5 && !laserGettingReady)
			{
				
				emitterStart.color = FlxG.RED;
				emitterStart.flicker(1.5);
				emitterEnd.color = FlxG.RED;
				emitterEnd.flicker(1.5);
				laserGettingReady = true;
			}
			if (fireIntervalCounter > fireIntervalLimit)
			{
				if (activeCounter == 0)
				{
					//laser.flicker(1);
					laserActive = true;
					laser.visible = true;
				}
				
				activeCounter += FlxG.elapsed;
				if (activeCounter > activeLimit)
				{
					fireIntervalCounter = 0;
					activeCounter = 0;
					laser.visible = false;
					laserActive = false;
					laserGettingReady = false;
					emitterStart.color = 0xFFC0C0C0;
					emitterEnd.color = 0xFFC0C0C0;
				} 
			}
		}
		
	}

}