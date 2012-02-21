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
	public class BackgroundEntities extends FlxGroup 
	{
		[Embed(source = "../assets/graphics/spaceShuttle.png")] private var image:Class;
		
		public function BackgroundEntities() 
		{
			createSpaceShuttles(6);
		}
		
		
		private function createSpaceShuttles(howMany:int):void {
			for (var i:int = 0; i < howMany; i++) 
			{
				var shuttle:FlxSprite = new FlxSprite();
				shuttle.loadGraphic(image, false, true);
				shuttle.scale.x = FlxG.random();
				shuttle.scale.y = shuttle.scale.x;
				if (i % 2 == 0) {
					shuttle.x = - 10;
					shuttle.velocity.x = FlxG.random() * 300;
					shuttle.facing = FlxObject.LEFT;
				} else {
					shuttle.x = FlxG.width + 10;
					shuttle.velocity.x = -FlxG.random() * 300;
				}
				
				shuttle.y = FlxG.random() * FlxG.height + 20;
				
				add(shuttle);
			}
		}
		
		override public function update():void 
		{
			super.update();
			if (members.length > 0) 
			{			
				for (var i:int = 0; i < members.length; i++) 
				{
					var shuttle:FlxSprite = members[i] as FlxSprite;
					
					if (shuttle != null && (shuttle.x < -50 || shuttle.x > FlxG.width + 50)) {
						launchShuttle(shuttle);						
					}
				}			
			}
		}
		private function launchShuttle(shuttle:FlxSprite):void 
		{
			if (FlxG.random() < 0.001)
			{
				var shuttleSpeedMultiplier:int = 300;
				// Shuttle moving to left
				if (shuttle.x < 0) {
						shuttle.x = -10;
						shuttle.velocity.x = FlxG.random() * shuttleSpeedMultiplier + 50;
						shuttle.facing = FlxObject.LEFT;
				} else if (shuttle.x >= FlxG.width + 20) {
					shuttle.x = FlxG.width + 10;
					shuttle.velocity.x = -FlxG.random() * shuttleSpeedMultiplier - 50;
					shuttle.facing = FlxObject.RIGHT;
				}
					
					shuttle.y = FlxG.random() * FlxG.height + 20;
			}
		}
	}

}