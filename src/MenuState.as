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
		
		public function MenuState() 
		{
			var txt:FlxText
			txt = new FlxText(0, (FlxG.width / 2) - 80, FlxG.width, "Flixel Tutorial Game")
			txt.setFormat(null,16,0xFFFFFFFF,"center")
			this.add(txt);
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