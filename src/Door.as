package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxParticle;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Door extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/door.png")] private var graphic:Class;
		private var leverId:int; // Which lever opens this door.
		private var opening:Boolean = false;
		public var emitter:FlxEmitter;
		
		public function Door(x:int, y:int, leverId:int, height:int) 
		{
			super(x, y);
			
			loadGraphic(graphic, true, false, 12, 12);
			this.height = height;
			this.immovable = true;
			addAnimation("alive", [0,1], 10, true);
			this.scale.y = height * 1.0 / 12;
			centerOffsets();
			this.leverId = leverId;		
			play("alive");
			emitter = new FlxEmitter(x + width / 2, y + height / 2, 50);
			emitter.setXSpeed( -50, 50);
			emitter.setYSpeed( -30, 30);
			var whitePixel:FlxParticle;
			for (var i:int = 0; i < emitter.maxSize; i++) 
			{
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(2, 2, 0xFF0AD1842);
				whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
				emitter.add(whitePixel);
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(1, 1, 0xFF02C472);
				whitePixel.visible = false;
				emitter.add(whitePixel);
			}			
		}
		
		override public function update():void 
		{
						
			if (opening) {
				// just decreasing the scale creates a nice effect also
				scale.y -= FlxG.elapsed * 1.2;

				if (scale.y < 0) {
					emitter.kill();
					this.exists = false;
					//emitter.exists = false;
				}
			}
			super.update();
		}
		public function openDoor(leverId:int):Boolean {
			if (leverId == this.leverId) {								
				opening = true;
				return true;
			}
			return false;
		}
		
	}

}