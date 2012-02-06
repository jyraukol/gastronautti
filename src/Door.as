package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Door extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/door.png")] private var graphic:Class;
		private var leverId:int; // Which lever opens this door.
		private var opening:Boolean = false;
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
		}
		
		override public function update():void 
		{
			super.update();
			
			if (opening) {
				// just decreasing the scale creates a nice effect also
				scale.y -= FlxG.elapsed * 1.2;
							
				if (scale.y < 0) {
					this.exists = false;
				}
			}
		}
		public function openDoor(leverId:int):void {
			if (leverId == this.leverId) {								
				opening = true;
			}
		}
		
	}

}