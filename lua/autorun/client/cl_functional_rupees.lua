hook.Add( "PopulateToolMenu", "FunctionalRupeesCustomMenuSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "Stuff", "functional_rupees", "Functional Rupees", "", "", function( panel )
		panel:Help( "These settings are all serversided\nand should be the same for all the players" )
		
		panel:Help( "" )
		
		panel:CheckBox( "Rupees give armor instead of health", "gmod_functional_rupees_armor" )
		
		panel:Help( "" )
		
		panel:CheckBox( "Spawn rupees on NPC death", "gmod_functional_rupees_spawn_npc" )
		panel:CheckBox( "Spawn rupees on player death", "gmod_functional_rupees_spawn_player" )
		
		panel:Help( "" )
		
		panel:NumSlider( "Despawn time in secs\n(0 = never despawn)", "gmod_functional_rupees_despawn", 0, 60, 0 )
		
		panel:Help( "" )
		
		panel:NumSlider( "Rupee value multiplier", "gmod_functional_rupees_value_mul", 0, 10 )
	end )
end )