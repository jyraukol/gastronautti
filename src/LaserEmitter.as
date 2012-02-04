package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class LaserEmitter extends FlxGroup
	{
		[Embed(source = "../assets/graphics/laser.png")] private var laserImage:Class;
		[Embed(source = "../assets/graphics/laserEmitter.png")] private var emitterImage:Class;
		private var laser:FlxSprite;
		private var emitterStart:FlxSprite;		
		private var fireIntervalLimit:Number = 5;
		private var fireIntervalCounter:Number = 0;
		private var activeLimit:Number = 2;
		private var activeCounter:Number = 0;
		private var laserGettingReady:Boolean = false;
		
		public function LaserEmitter(startX:int, startY:int, endX:int, endY:int, fireInterval:int = 5) 
		{						
			emitterStart = new FlxSprite(startX -2, startY - 3, emitterImage);			
			emitterStart.allowCollisions = FlxObject.NONE;
			
			fireIntervalLimit = fireInterval;

			add(emitterStart);		
		}
		
		public function generateLaser():void {
			var x:int = emitterStart.x;
			var y:int = emitterStart.y;
						
			laser = new FlxSprite(x, y + 12, laserImage);
			
			var laserEndPoint:int = 1;
			var i:int = 0;
			
			while (!FlxG.collide(Registry.level.map, laser)) {				
				laser.y += laser.height; 			
			}
			
			laserEndPoint = laser.y + laser.height;
			laser.y = y;
			
			laser.x = x + emitterStart.width / 2.0 - Math.floor(laser.width / 2);
			laser.scale.y = (laserEndPoint - y - emitterStart.height) / laser.height ;
			laser.y = y + emitterStart.height;;
			laser.height = laser.height * laser.scale.y;
			laser.centerOffsets();
			laser.visible = false;
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
				//emitterEnd.color = FlxG.RED;
				//emitterEnd.flicker(1.5);
				laserGettingReady = true;
			}
			if (fireIntervalCounter > fireIntervalLimit)
			{
				if (activeCounter == 0)
				{
					laser.visible = true;
				}
				
				activeCounter += FlxG.elapsed;
				if (activeCounter > activeLimit)
				{
					fireIntervalCounter = 0;
					activeCounter = 0;
					laser.visible = false;
					laserGettingReady = false;
					emitterStart.color = 0xFFC0C0C0;
					//emitterEnd.color = 0xFFC0C0C0;
				} 
			}
		}
		
	}

}