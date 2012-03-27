package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class SpaceHouse extends FlxSprite 
	{
		[Embed(source = "../assets/graphics/spacehouse2.png")] private var housePNG:Class;
		[Embed(source = "../assets/sounds/foodDeliverSound.mp3")] private var foodDeliverSound:Class;
		public var foodDeliveredHere:Boolean = false;
		public var tipTimer:Number;
		
		
		public function SpaceHouse(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(housePNG, true, false,32, 32);	
			
			addAnimation("open", [0], 0, false);
			addAnimation("closed", [1], 0, false);
			
			tipTimer = FlxG.random() * 10 + 10;
			tipTimer = Math.round(tipTimer);
			play("open");
			
		}
	
		override public function update():void 
		{
			super.update();
			
			if (!foodDeliveredHere && tipTimer > 0) {
				tipTimer -= FlxG.elapsed;
			}
		}
		public function thankYou():void
		{
			foodDeliveredHere = true;
			FlxG.play(foodDeliverSound);
			if (tipTimer > 0)
			{
				Registry.money += 10;
			}
			
			play("closed");
		}
	}

}