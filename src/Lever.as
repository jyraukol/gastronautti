package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Lever extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/lever.png")] private var graphic:Class;
		private var pulled:Boolean = false;
		private var leverId:int;
		
		public function Lever(x:int, y:int, leverId:int) 
		{
			super(x, y);
			loadGraphic(graphic, true, true, 16, 16);
			
			addAnimation("notPulled", [0], 0, false);
			addAnimation("pulled", [1, 2, 3], 6, false);
			
			play("notPulled");
			this.leverId = leverId;
			trace("leverin id on " + this.leverId);
		}
		
		public function pull():void {
			if (!pulled) {
				play("pulled");	
				pulled = true;
			}
			
		}
		
		public function getID():int {
			return leverId;
		}
		
		public function getPulled():Boolean {
			return pulled;
		}
		override public function update():void 
		{
			super.update();
		}
		
	}

}