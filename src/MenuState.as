package  
{
	import org.flixel.FlxPath;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxGradient;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class MenuState extends FlxState 
	{
		private var starField:StarField;
		[Embed(source = "../assets/music/FoxSynergy - Solar Powered Boy.mp3")] private var bgmusic:Class; //http://opengameart.org/content/solar-powered-boy
		[Embed(source = "../assets/graphics/gastronautTitle.png")] private var titleGraphic:Class;
		
		public function MenuState() 
		{
			Registry.fuel = 100.0;
			Registry.money = 0;
			Registry.levelIndex = 0;
			
			starField = new StarField(0, 2);
			add(starField);
			
			add(new Gastronaut(FlxG.width / 2, FlxG.height / 2, true, true));
			//var title:FlxText
			//title = new FlxText(0, (FlxG.width / 2) - 80, FlxG.width, "Gastronaut");
			//title.setFormat(null, 16, 0xFFFFFFFF, "center");
			var title:FlxSprite = new FlxSprite();
			title.loadGraphic(titleGraphic);
			title.x = FlxG.width / 2 - title.width / 2;
			title.y = 30;
			this.add(title);
						
			var instructions2:FlxText;
			instructions2 = new FlxText(0, (FlxG.width / 2) - 20, FlxG.width, "Press up to fire your jetpack!");
			instructions2.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions2);
			
			// Show a fuel bar sample
			//var bar:FlxSprite = new FlxSprite(FlxG.width / 2, instructions2.y + 40);
			//bar.makeGraphic(80, 10, 0xff00FF40);
			var gradient1:FlxSprite = FlxGradient.createGradientFlxSprite(80, 10, [0xffFF0000, 0xffFF8B17, 0xffFFFF00], 1, 180 );
			gradient1.x = FlxG.width / 2 - gradient1.width / 2;
			gradient1.y = instructions2.y + 40;
			add(gradient1);
			
			var instructions3:FlxText;
			instructions3 = new FlxText(0, gradient1.y + 10, FlxG.width, "Watch your fuel meter!");
			instructions3.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions3);
						
			var instructions4:FlxText;
			instructions4 = new FlashingText(FlxG.height - 25, "Enter to start", 0);			
			add(instructions4); 
			
			
		}
		
		override public function create():void 
		{
			super.create();
			FlxG.playMusic(bgmusic);
		}
		
		override public function update():void
		{    
			if (FlxG.keys.pressed("ENTER")) 
			{
				FlxG.flash(0xffffffff, 0.75);
				FlxG.fade(0xff000000, 1, onFade);
			}
			
			super.update();		
		}
		
		private function onFade():void
		{	
			Registry.loadNextLevel();
			
		}
		
	}

}