package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Jyri Raukola
	 */
	public class MessageState extends FlxState 
	{
		private var messageOverlay:FlxSprite;
		private var levelMessageObject:FlxBasic;
		private var boss:FlxSprite;
		private var incomingTransmissionText:FlashingText;
		private var levelMessage:FlxText;
		private var level:Level1;
		private var player:Gastronaut = null;
		private var portals:FlxGroup;
		private var portalLastUsed:Number = 0;
		
		[Embed(source = "../assets/graphics/transmissionBackground.png")] private var transmissionBackground:Class;
		[Embed(source = "../assets/graphics/boss.png")] private var bossImage:Class;
				
		public function MessageState() 
		{
			initState();
		}
		
		private function initState():void
		{
			level = Registry.level;
			messageOverlay = new FlxSprite(0, 0, transmissionBackground);			
			add(messageOverlay);
			add(Registry.transmissionStarField);
			add(levelMessage = new FlxText(50, 50, 230, level.levelMessage));
			boss = new FlxSprite(5, 180);
			boss.loadGraphic(bossImage, true, false, 100, 50);
			boss.addAnimation("speaking", [0, 1, 2, 0, 2, 1], 5, true);
			boss.play("speaking");
			
			add(boss);
			
			
			if (level.levelMessageObject.search("fuelcan") != -1) {					
					levelMessageObject = new FuelCan(150, 100)
					add(levelMessageObject);				
			}
			if (level.levelMessageObject.search("laser") != -1) {
					levelMessageObject = new LaserEmitter(150, 100, 0, 0, 3, true);
					(levelMessageObject as LaserEmitter).generateLaser();
					add(levelMessageObject);					
					
			}
			if (level.levelMessageObject.search("leverDoor") != -1) {				
					levelMessageObject = new FlxGroup();
					(levelMessageObject as FlxGroup).add(new Lever(130, 120, 1));
					(levelMessageObject as FlxGroup).add(new Door(170, 120, 1, 32));					
					add(levelMessageObject);										
			}
			
			if (level.levelMessageObject.search("portal") != -1) {
				portals = new FlxGroup();
				
					portals.add(new Portal(100, 100, 1, 2));									
					portals.add(new Portal(200, 100, 2, 1));
					add(portals);
					
					for (var i:int = 0; i < portals.members.length; i++ )
					{
						var port:Portal = portals.members[i];
						add(port.emitter);
					}
					
					player = new Gastronaut(150, 100, true, false);
					player.velocity.x = -50;
					player.hasGravity = false;					
					add(player);
			}
			
			add(incomingTransmissionText = new FlashingText(10, "Incoming transmission", -1));
		}
		
		override public function update():void 
		{	
			if (FlxG.keys.ENTER) {
				level.levelMessageDisplayed = true;	
				FlxG.switchState(new PlayState);			
			}
			
			if (player != null) {
				FlxG.overlap(player, portals, playerEnteredPortal);	
				portalLastUsed += FlxG.elapsed;
			}
			super.update();
		}
		
		override public function destroy():void 
		{
			//super.destroy();
		}
		
		private function playerEnteredPortal(player:Gastronaut, portal:Portal):void {
			if (portalLastUsed > 1)
			{
				var portalId:int = portal.connectingPortalId;
				var connectingPortal:Portal = portals.members[portalId - 1];
				player.x = connectingPortal.x;
				player.y = connectingPortal.y;
				portal.emitter.start(true, 1);
				portal.timeSincePortalUsed = 0;
				portalLastUsed = 0;
				portal.emitter.start(true, 1);
				connectingPortal.emitter.start(true, 1);
			}
		}
	}

}