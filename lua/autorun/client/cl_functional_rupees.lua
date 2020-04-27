hook.Add( "PopulateToolMenu", "CustomMenuSettings", function()
	spawnmenu.AddToolMenuOption( "Options", "Stuff", "functional_rupees", "Functional Rupees", "", "", function( panel )
		panel:CheckBox( "Spawn rupees on NPC death", "gmod_functional_rupees_spawn_npc" )
		panel:CheckBox( "Spawn rupees on player death", "gmod_functional_rupees_spawn_player" )
		
		panel:Help( "" )
		
		panel:NumSlider( "Despawn time in secs", "gmod_functional_rupees_despawn", 0, 60, 0 )
		panel:Help( "(set to 0 to never despawn)" )
		
		panel:Help( "" )
		
		panel:NumSlider( "Rupee value multiplier", "gmod_functional_rupees_value_mul", 0, 10 )
	end )
end )