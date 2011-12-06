package  
{
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
		public function LaserEmitter(startX:int, startY:int, endX:int, endY:int) 
		{
			super();
			
			laser = new FlxSprite(startX, startY, laserImage);
			laser.scale.y = (endY - startY) / laser.height;
			laser.y = startY;
			laser.height = laser.height * laser.scale.y;
			laser.centerOffsets();
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
		}
		
	}

}