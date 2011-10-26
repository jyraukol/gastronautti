package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class MenuState extends FlxState 
	{
		private var starField:StarField;
		
		public function MenuState() 
		{
			//var level:Level1 = 
			//Registry.level = new Level1();
			//trace(Registry.level.houses);
			starField = new StarField(0, 2);
			add(starField);
			//add(Registry.level);
			
			//Registry.spaceShip = new SpaceShip(Registry.level.spaceShipPosition.x, Registry.level.spaceShipPosition.y);
			//add(Registry.spaceShip);
			var title:FlxText
			title = new FlxText(0, (FlxG.width / 2) - 80, FlxG.width, "Gastronaut")
			title.setFormat(null,16,0xFFFFFFFF,"center")
			this.add(title);
		}
		
		override public function update():void
		{    
			if (FlxG.keys.pressed("X"))
			{
				FlxG.flash(0xffffffff, 0.75);
				FlxG.fade(0xff000000, 1, onFade);
			}
		
			super.update();
		}
		
		private function onFade():void
		{
			FlxG.switchState(new PlayState);
		}
		
	}

}