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
        
        public function Portal(x:int, y:int, portalId:int) 
		{
			super(x, y);
			
			loadGraphic(graphic, false, false, 12, 12);			
			this.immovable = true;
			this.portalId = portalId;
		}
        
        // Connects two portals together
        public function connectToPortal(otherPortalId:Portal) {
            this.connectingPortal = otherPortal;
            otherPortal.connectToPortal(this);
        }
        
        public function goThroughPortal():void {
			Registry.playState.player.x = connectingPortal.x;
            Registry.playState.player.y = connectingPortal.y;
		}
    }
}