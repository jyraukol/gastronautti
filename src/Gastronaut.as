package  
{
	import org.flixel.FlxG;	
	import org.flixel.FlxObject;
	import org.flixel.plugin.photonstorm.FlxControl;
	import org.flixel.plugin.photonstorm.FlxControlHandler;
	import org.flixel.plugin.photonstorm.FlxExtendedSprite;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Gastronaut extends FlxExtendedSprite 
	{
		[Embed(source = "../assets/graphics/gastronaut.png")] private var playerPNG:Class;
		
		public function Gastronaut() 
		{
			super(FlxG.width / 2, FlxG.height - 50);
			loadGraphic(playerPNG, false, true, 16, 16);
			
			
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES);
			FlxControl.player1.setCursorControl(true, false, true, true);
			FlxControl.player1.setGravity(0, 75);
			
			FlxControl.player1.setMovementSpeed(100, 100, 200, 200, 0, 0);			
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
			} 
			if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
			}
			
			if (touching == FlxObject.FLOOR && !FlxG.keys.LEFT && !FlxG.keys.RIGHT)
			{
				velocity.x = 0;
			}
		}
		
	}

}