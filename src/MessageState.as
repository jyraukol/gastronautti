package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class MessageState extends FlxState 
	{
		
		public function MessageState() 
		{
			add(new FlxText(100, 50, 100, "Testiviesti"));
		}
		
		override public function update():void 
		{
			if (FlxG.keys.ENTER)
			{
				FlxG.fade(0xFFFFFFFF, 1.5, switchState);				
			}
				
			super.update();
		}
				
		private function switchState():void
		{
			
			FlxG.switchState(Registry.playState);			
		}
		
	}

}