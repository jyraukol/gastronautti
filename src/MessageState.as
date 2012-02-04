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
			Registry.levelIndex++;
			FlxG.switchState(new PlayState);				
		}
		
	}

}