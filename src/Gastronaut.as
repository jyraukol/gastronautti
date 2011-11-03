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
		[Embed(source = "../assets/graphics/gastronautAnim.png")] private var playerPNG:Class;
		public var fuel:Number = 100.0;
		private var XSPEED:int = 50;
		private var MAXXSPEED:int = 50;
		
		private var YSPEED:int = 100;		
		private var MAXYSPEED:int = 200;
		
		private var FUELCONSUMPTION:Number = 0.2;
		private var outOfFuel:Boolean = false;
		
		public function Gastronaut(x:int, y:int) 
		{
			super(x, y);
			loadGraphic(playerPNG, true, true, 16, 16);
			
			width = 9;
			height = 13;
			offset.y = -3;
			offset.x = 3;
			addAnimation("idle", [0], 0, false);
			addAnimation("walk", [0, 1, 0, 2], 5, true);
			addAnimation("fly", [3, 4, 5, 4, 3], 10, true);
			
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
				if (velocity.y == 0)
				{
					play("walk");
				}
				
			} else
			
			if (FlxG.keys.RIGHT )
			{					
				if (FlxG.keys.LEFT)
				{
					velocity.x = 0;
				} else
				{
					facing = RIGHT;
				}	
				if (velocity.y == 0)
				{
					play("walk");
				}
			}
			
			if (FlxG.keys.UP)
			{				
				fuel -= FUELCONSUMPTION;
				if (fuel < 0)
				{
					fuel = 0;
				}
				else {
					play("fly");
				}
				
			}
			
			if (touching == FlxObject.FLOOR && !FlxG.keys.LEFT && !FlxG.keys.RIGHT)
			{
				velocity.x = 0;
				play("idle");
			}
			
			if (velocity.y > 0 )
			{
				play("idle");
			}
			
			if (!outOfFuel && fuel <= 0)
			{
				FlxControl.player1.setCursorControl(false, false, true, true);
				outOfFuel = true;
				FlxControl.player1.setMovementSpeed(XSPEED, 0, MAXXSPEED, MAXYSPEED, 0, 0);				
			}
			
			if (x < 0)
			{
				x = 0;
				velocity.x = 0;
			}
			
			if (x + width > FlxG.width)
			{
				x = FlxG.width - width;
				velocity.x = 0;
			}
		}
		
	}

}