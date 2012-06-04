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
		public var foodDeliveredHere:Boolean = false;
		public var tipTimer:Number;
		public var houseNumber:int;
		
		public function SpaceHouse(x:int, y:int, houseNumber:int, tipTimer:int) 
		{
			super(x, y);
			this.houseNumber = houseNumber;
			loadGraphic(housePNG, true, false,32, 32);	
			
			addAnimation("open", [0], 0, false);
			addAnimation("closed", [1], 0, false);
			
			//tipTimer = FlxG.random() * 10 + 10;
			//tipTimer = Math.round(tipTimer);
			this.tipTimer = tipTimer;
			this.tipTimer += 0.00;
			play("open");
			
		}
	
		override public function update():void 
		{
			super.update();
			
			if (!foodDeliveredHere && tipTimer > 0) {
				tipTimer -= FlxG.elapsed;
			}
		}
		public function thankYou():String
		{
			foodDeliveredHere = true;
			FlxG.play(Registry.blingSound);
			if (tipTimer > 0)
			{
				Registry.money += 10;
			}
			Registry.money += 10;
			play("closed");
			var returnText:String;
			if (tipTimer > 0) {				
				returnText = Registry.thanksText[Math.floor(Math.random() * Registry.notOnTimeText.length)];
			} else {				
				returnText = Registry.notOnTimeText[Math.floor(Math.random() * Registry.notOnTimeText.length)];
			}
			
			return returnText;
		}
	}

}