package
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
 
	public class PlayState extends FlxState
	{
		private var floor:FlxTileblock;
		private var player:Gastronaut;
		private var platform:FlxTileblock;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff144954;
			player = new Gastronaut();
		
			floor = new FlxTileblock(0, 208, 320, 32);
			floor.makeGraphic(320, 32, 0xff689c16);
			
			platform = new FlxTileblock(100, 50, 64, 32);
			platform.makeGraphic(64, 32, 0xff689c16);
			
			add(player);
			add(floor);
			add(platform);
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(player, floor);
			FlxG.collide(player, platform);
			
		}
	}
}