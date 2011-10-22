package
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	import org.flixel.plugin.photonstorm.FlxBar;
 
	public class PlayState extends FlxState
	{
		private var floor:FlxTileblock;
		private var player:Gastronaut;
		private var platform:FlxTileblock;
		private var fuelBar:FlxBar;
		
		override public function create():void
		{
			FlxG.bgColor = 0xff144954;
			player = new Gastronaut();
			fuelBar = new FlxBar(16, 10, FlxBar.FILL_LEFT_TO_RIGHT, 80, 10, player, "fuel");
			
			floor = new FlxTileblock(0, 208, 320, 32);
			floor.makeGraphic(320, 32, 0xff689c16);
			
			platform = new FlxTileblock(100, 50, 64, 32);
			platform.makeGraphic(64, 32, 0xff689c16);
			
			add(player);
			add(floor);
			add(platform);
			add(fuelBar);
		}
		
		override public function update():void
		{
			super.update();
			
			FlxG.collide(player, floor);
			FlxG.collide(player, platform);
			
		}
	}
}