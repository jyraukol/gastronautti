package {
    import org.flixel.FlxG;
	import org.flixel.FlxSprite;
    
    /**
	 * ...
	 * @author Jyri Raukola
	 */
	public class Portal extends FlxSprite 
	{
        [Embed(source = "../assets/graphics/portal.png")] private var graphic:Class;
        private var connectingPortalId:int; // Which portal is this portal connected to?
        private var connectingPortal:Portal; // Reference to that portal.
        private var portalId:int;
		public var timeSincePortalUsed:Number = 0;
		
        public function Portal(x:int, y:int, portalId:int) 
		{
			super(x, y);
			
			loadGraphic(graphic, false, false, 10, 32);			
			this.immovable = true;
			this.portalId = portalId;
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
			}
			
		}
		
		override public function update():void 
		{
			timeSincePortalUsed += FlxG.elapsed;
			super.update();
		}
    }
}