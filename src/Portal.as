package {
	import org.flixel.FlxEmitter;
    import org.flixel.FlxG;
	import org.flixel.FlxSprite;
    import org.flixel.FlxParticle;
	
    /**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Portal extends FlxSprite 
	{
        [Embed(source = "../assets/graphics/portal.png")] private var graphic:Class;
        public var connectingPortalId:int; // Which portal is this portal connected to?
        public var connectingPortal:Portal; // Reference to that portal.
        private var portalId:int;
		public var timeSincePortalUsed:Number = 0;
		public var emitter:FlxEmitter;
		
        public function Portal(x:int, y:int, portalId:int, connectingId:int) 
		{
			super(x, y);
			
			loadGraphic(graphic, false, false, 10, 32);
			height = 22;
			centerOffsets();
			this.immovable = true;
			this.portalId = portalId;
			this.connectingPortalId = connectingId;
			
			emitter = new FlxEmitter(x + width / 2, y + height / 2, 50);
			emitter.setXSpeed( -50, 50);
			emitter.setYSpeed( -30, 30);
			var whitePixel:FlxParticle;
			for (var i:int = 0; i < emitter.maxSize; i++) 
			{
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(2, 2, 0xFFFFFFFF);
				whitePixel.visible = false; //Make sure the particle doesn't show up at (0, 0)
				emitter.add(whitePixel);
				whitePixel = new FlxParticle();
				whitePixel.makeGraphic(1, 1, 0xFFC1CDDB);
				whitePixel.visible = false;				
				emitter.add(whitePixel);
			}			
		}
        
        // Connects two portals together
        public function connectToPortal(otherPortal:Portal):void {
            this.connectingPortal = otherPortal;            
        }
        
        public function goThroughPortal():void {
			if (timeSincePortalUsed > 3) {
				Registry.playState.player.x = connectingPortal.x;
				Registry.playState.player.y = connectingPortal.y;
				timeSincePortalUsed = 0;
				connectingPortal.timeSincePortalUsed = 0;
				connectingPortal.emitter.start(true, 1);
			}
			
		}
		
		public function canPortalBeUsed():Boolean {
			return timeSincePortalUsed > 3;
		}
		override public function update():void 
		{
			timeSincePortalUsed += FlxG.elapsed;
			super.update();
		}
    }
}