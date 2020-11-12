
hook.Add( "OnNPCKilled", "FunctionalRupeeNPCDeath", function( victim, attacker, inflictor )
	if ( GetConVar( "gmod_functional_rupees_spawn_npc" ):GetBool() ) then
		SpawnRupees( victim:GetPos(), victim:GetMaxHealth()  )
	end
end )

hook.Add( "PlayerDeath", "FunctionalRupeePlayerDeath", function( victim, inflictor, attacker )
	if ( GetConVar( "gmod_functional_rupees_spawn_player" ):GetBool() ) then
		SpawnRupees( victim:GetPos(), victim:GetMaxHealth() )
	end
end )

function SpawnRupees( pos, value )
	pos.z = pos.z + 20
	
	local valuemul = GetConVar( "gmod_functional_rupees_value_mul" ):GetFloat()
	
	value = math.floor(value * valuemul)
	
	gre = (((value % 300) % 100) % 20) % 5
	blu = ((((value - gre) % 300) % 100) % 20) / 5
	red = (((value - (blu * 5) - gre) % 300) % 100) / 20
	sil = ((value - (red * 20) - (blu * 5) - gre) % 300) / 100
	gol = (value - (sil * 100) - (red * 20) - (blu * 5) - gre) / 300
	
	for i=1,gre do
		SpawnSingleRupee( 1, pos )
	end
	for i=1,blu do
		SpawnSingleRupee( 2, pos )
	end
	for i=1,red do
		SpawnSingleRupee( 3, pos )
	end
	for i=1,sil do
		SpawnSingleRupee( 4, pos )
	end
	for i=1,gol do
		SpawnSingleRupee( 5, pos )
	end
end

function SpawnSingleRupee( rupeetype, pos )
	pos.x = pos.x + math.random( -20, 20)
	pos.y = pos.y + math.random( -20, 20)
	
	typestring = ""
	
	if rupeetype == 1 then
		typestring = "green_rupee"
	elseif rupeetype == 2 then
		typestring = "blue_rupee"
	elseif rupeetype == 3 then
		typestring = "red_rupee"
	elseif rupeetype == 4 then
		typestring = "silver_rupee"
	elseif rupeetype == 5 then
		typestring = "gold_rupee"
	else
		return
	end
	
	local rupee = ents.Create( typestring )
	
	if ( IsValid( rupee ) ) then
		rupee:SetPos( pos )
		rupee:SetAngles( Angle( math.random( 360 ), math.random( 360 ), math.random( 360 ) ) )
		rupee:Spawn()
		rupee:PhysWake()
		rupee:EmitSound( "rupeespawn" .. math.random( 1, 5 ) .. ".wav")
		
		local despawntime = GetConVar( "gmod_functional_rupees_despawn" ):GetFloat()
		
		if (despawntime > 0) then
			timer.Simple( despawntime, function()
				if ( IsValid( rupee ) ) then
					FadeOutRupee( rupee, 50, 0.08 )
				end
			end	)
		end
	end
end

function FadeOutRupee( rupee, retry, speed )
	c = rupee:GetColor()
	rupee:SetRenderMode( RENDERMODE_TRANSALPHA )
	
	rupee:SetColor( Color( c.r, c.g, c.b, (retry % 2) * 255 ) )
	
	timer.Simple( speed, function()
		if ( IsValid( rupee ) ) then
			if ( retry > 0 ) then
				if ( speed > 0.02 ) then
					FadeOutRupee( rupee, retry - 1, speed - 0.002 )
				else
					FadeOutRupee( rupee, retry - 1, 0.02 )
				end
			else
				rupee:Remove()
			end
		end
	end )
end
