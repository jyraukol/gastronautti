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
				
				if (i % 2 == 0) {
					shuttle.x = - 10;
					shuttle.velocity.x = FlxG.random() * 200;
					shuttle.facing = FlxObject.LEFT;
				} else {
					shuttle.x = FlxG.width + 10;
					shuttle.velocity.x = -FlxG.random() * 200;
				}
				
				shuttle.y = FlxG.random() * FlxG.height + 20;
				
				add(shuttle);
			}
		}
	}

}