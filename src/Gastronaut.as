package  
{
	import org.flixel.FlxG;	
	import org.flixel.FlxObject;
	import org.flixel.FlxSound;
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
		[Embed(source = "../assets/sounds/rocket.mp3")] private var rocketSoundClass:Class;
		[Embed(source = "../assets/sounds/landing.mp3")] private var landingSound:Class;
		
		public var fuel:Number = 100.0;
		private var XSPEED:int = 50;
		private var XSPEEDONGROUND:int = 30;
		private var MAXXSPEED:int = 50;
		
		private var YSPEED:int = 100;		
		private var MAXYSPEED:int = 200;
		
		private var FUELCONSUMPTION:Number = 0.2;
		private var outOfFuel:Boolean = false;
		private var flying:Boolean = false;
		private var rocketSound:FlxSound = new FlxSound();
		
		// Automation variables
		private var automated:Boolean;
		private var lastAutomatedAction:Number = 0.0;
		private var automatedActionLimit:Number = 1.5;
		private var actionTime:Number = 0.0;
		private var doingAction:Boolean = false;
		
		public function Gastronaut(x:int, y:int, automated:Boolean = false) 
		{
			super(x, y);
			loadGraphic(playerPNG, true, true, 16, 16);
			rocketSound.loadEmbedded(rocketSoundClass);
			
			height = 20;
			addAnimation("idle", [0], 0, false);
			addAnimation("walk", [0, 1, 0, 2], 5, true);
			addAnimation("fly", [3, 4, 5, 4, 3], 10, true);
			
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			this.automated = automated;
			if (!automated)
			{
				FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES);
				FlxControl.player1.setCursorControl(true, false, true, true);
				FlxControl.player1.setGravity(0, 75);
				
				FlxControl.player1.setMovementSpeed(XSPEED, YSPEED, MAXXSPEED, MAXYSPEED, 0, 0);						
			} else {
				velocity.y = 25;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if (automated) {
				autoPilot();
				return;
			}
			if (!flying)
			{
				velocity.x = 0;
			}
			
			if (FlxG.keys.LEFT )
			{				
				// If both buttons are pressed down stop movement
				if (FlxG.keys.RIGHT && !flying)
				{
					velocity.x = 0;
					play("idle");
				} else
				{
					facing = LEFT;
					if (!flying) 
					{
						velocity.x -= XSPEEDONGROUND;	
					}
					
				}
				if (velocity.y == 0)
				{
					play("walk");
				}
				
			} else
			
			if (FlxG.keys.RIGHT )
			{
				// If both buttons are pressed down stop movement
				if (FlxG.keys.LEFT && !flying)
				{
					velocity.x = 0;
					play("idle");
				} else
				{
					facing = RIGHT;
					if (!flying)
					{
						velocity.x = XSPEEDONGROUND;
					}
					
				}	
				if (velocity.y == 0)
				{
					play("walk");
				}
			}
			
			if (FlxG.keys.UP)
			{	
				flying = true;
				fuel -= FUELCONSUMPTION;
				
				if (!rocketSound.active)
				{
					rocketSound.play();
				}
				
				if (fuel < 0)
				{
					fuel = 0;
				}
				else {
					play("fly");
				}
				
			}
			
			if (justTouched(FlxObject.FLOOR))
			{
				velocity.x = 0;
				if (flying)
				{
					FlxG.play(landingSound);
				}
				flying = false;
				
				play("idle");
			}
			
			if (touching == FlxObject.FLOOR && (FlxG.keys.justReleased("LEFT") || FlxG.keys.justReleased("RIGHT")))
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
			
			if (isTouching(WALL)) {
				play("idle");
			}
		}
		
		public function setSpeed(xSpeed:int, ySpeed:int):void {
			XSPEED += xSpeed;
			YSPEED += ySpeed;
			MAXXSPEED += xSpeed;
			MAXYSPEED += ySpeed;
			FlxControl.player1.setMovementSpeed(XSPEED, YSPEED, MAXXSPEED, MAXYSPEED, 0, 0);
			trace("xspeed = " + XSPEED + "\nyspeed = " + YSPEED);
		}
		
		private function autoPilot():void {
			lastAutomatedAction += FlxG.elapsed;
			
			if (lastAutomatedAction > automatedActionLimit && !doingAction) {
				var x:int = FlxG.random() * 5 + 10;
				if (FlxG.random() < 0.5) {
					x = -x;
				}
				var y:int = -FlxG.random() * 5 - 10;
				
				velocity.x = x
				
				velocity.y = y;
				doingAction = true;
			}
				
			
			if (doingAction) {
				play("fly");
				actionTime += FlxG.elapsed;	
			}
			if (actionTime > 2.5) {
				lastAutomatedAction = 0.0;
				play("idle");
				actionTime = 0.0;
				velocity.y = 5;
				velocity.x = 0;
				doingAction = false;
			}
						
		}
		
	}

}