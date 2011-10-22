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
		public var fuel:Number = 100.0;
		private var MAXXSPEED:int = 50;
		private var MAXYSPEED:int = 200;
		private var XSPEED:int = 50;
		private var YSPEED:int = 100;
		private var FUELCONSUMPTION:Number = 1;
		private var outOfFuel:Boolean = false;
		
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
			
			FlxControl.player1.setMovementSpeed(XSPEED, YSPEED, MAXXSPEED, MAXYSPEED, 0, 0);			
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.keys.LEFT )
			{				
				if (FlxG.keys.RIGHT)
				{
					velocity.x = 0;
				} else
				{
					facing = LEFT;
				}			
			} 
			
			if (FlxG.keys.RIGHT )
			{					
				if (FlxG.keys.LEFT)
				{
					velocity.x = 0;
				} else
				{
					facing = RIGHT;
				}	
			}
			
			if (FlxG.keys.UP)
			{				
				fuel -= FUELCONSUMPTION;
			}
			
			if (touching == FlxObject.FLOOR && !FlxG.keys.LEFT && !FlxG.keys.RIGHT)
			{
				velocity.x = 0;
			}
			
			if (!outOfFuel && fuel <= 0)
			{
				FlxControl.player1.setCursorControl(false, false, true, true);
				outOfFuel = true;
				FlxControl.player1.setMovementSpeed(XSPEED, 0, MAXXSPEED, MAXYSPEED, 0, 0);				
			}
		}
		
	}

}