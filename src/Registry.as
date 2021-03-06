package  
{
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Registry 
	{
		
		[Embed(source = "../assets/sounds/foodDeliverSound.mp3")] public static var blingSound:Class;
		[Embed(source = "../assets/sounds/selection.mp3")] public static var selectionSound:Class;
		[Embed(source = "../assets/sounds/explosion.mp3")] public static var explosionSound:Class;
		
		public static var player:Gastronaut;
		public static var playerXSpeedBoost:int = 0;
		public static var playerYSpeedBoost:int = 0;
		
		public static var playState:PlayState;
		public static var spaceShip:SpaceShip;
		public static const thanksText:Array = new Array("Thanks!", "OMNOMNOM!", "Great service dude!", "Sweet!", "Pizza!");
		public static const notOnTimeText:Array = new Array("You are late!", "No tip for you!", "What took you so long?");
		public static var topBarHeight:int;
		public static var levelIndex:uint = 1;
		public static var levelScores:Array = new Array();
		public static var levelNumber:uint = 7; // save the number of levels the game has
		public static var transmissionStarField:StarField = new StarField(0, 3);
		public static var money:int;
		public static var baseDeliveryAmount:int = 15;
		public static var tipAmount:int = 15;
		public static var fuel:Number;
		public static var fuelAtStartOfLevel:Number;
		public static var fuelConsumption:Number = 0.2;
		public static var level:Level1;
		
		public function Registry() 
		{
			
		}
		
		public static function restartLevel():void {
			Registry.fuel = fuelAtStartOfLevel;
			Registry.level = new Level1();
			FlxG.switchState(new PlayState);
		}
		
		public static function loadNextLevel():void {
			fuelAtStartOfLevel = fuel;
			if (Registry.levelIndex == Registry.levelNumber)
			{
				FlxG.switchState(new GameEndState);
			} else 
			{				
				Registry.levelIndex++;
				Registry.level = new Level1();				
				if (Registry.level.levelMessageExists)
				{
					FlxG.switchState(new MessageState);
				} else {
					FlxG.switchState(new PlayState);
				}				
			}
		}
	}

}