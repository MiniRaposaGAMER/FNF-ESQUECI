package;

import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;

/**
 * Handles initialization of variables when first opening the game.
**/
class InitState extends flixel.FlxState {
    override function create():Void {
        super.create();

        // -- FLIXEL STUFF -- //

        FlxG.game.focusLostFramerate = 60;
		FlxG.sound.muteKeys = TitleState.muteKeys;
		FlxG.sound.volumeDownKeys = TitleState.volumeDownKeys;
		FlxG.sound.volumeUpKeys = TitleState.volumeUpKeys;
		FlxG.keys.preventDefaultKeys = [TAB];

        FlxTransitionableState.skipNextTransIn = true;

        // -- SETTINGS -- //

		FlxG.save.bind('funkin', CoolUtil.getSavePath());

        Controls.instance = new Controls();

        ClientPrefs.loadDefaultKeys();
		ClientPrefs.loadPrefs();

        // -- MODS -- //

		#if LUA_ALLOWED
		Paths.pushGlobalMods();
		#end
		// Just to load a mod on start up if ya got one. For mods that change the menu music and bg
		WeekData.loadTheFirstEnabledMod();

        // -- -- -- //

        Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

        FlxG.switchState(Type.createInstance(Main.initialState, []));
    }
}