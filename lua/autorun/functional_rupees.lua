
hook.Add( "OnNPCKilled", "FunctionalRupeesNPCDeath", function( victim, attacker, inflictor )
	if ( GetConVar( "gmod_functional_rupees_spawn_npc" ):GetBool() ) then
		SpawnRupees( victim:GetPos(), victim:GetMaxHealth()  )
	end
end )

hook.Add( "DoPlayerDeath", "FunctionalRupeesPlayerDeath", function( ply, attacker, dmg )
	if ( GetConVar( "gmod_functional_rupees_spawn_player" ):GetBool() ) then
		if ( GetConVar( "gmod_functional_rupees_cap" ):GetInt() == 0 or !ply:IsPlayer() ) then
			SpawnRupees( ply:GetPos(), ply:GetMaxHealth() )
		elseif ( GetConVar( "gmod_functional_rupees_cap" ):GetInt() <= ply:GetMaxHealth() ) then
			SpawnRupees( ply:GetPos(), GetConVar( "gmod_functional_rupees_cap" ):GetInt() )
		else
			SpawnRupees( ply:GetPos(), GetConVar( "gmod_functional_rupees_cap" ):GetInt() - ply:GetMaxHealth() )
		end
	end
end )

function SpawnRupees( pos, value )
	pos.z = pos.z + 20
	
	local valuemul = GetConVar( "gmod_functional_rupees_value_mul" ):GetFloat()
	
	value = math.floor(value * valuemul)
	
	rupeeNames = {"gold_rupee", "orange_rupee", "silver_rupee", "purple_rupee", "red_rupee", "blue_rupee", "green_rupee"}
	rupeeValues = {300, 200, 100, 50, 20, 5, 1}
	
	totalValue = 0
	
	for i, v in ipairs( rupeeValues ) do
		r = math.floor((value - totalValue) / v)
		totalValue = totalValue + (v * r)
		for j=1,r do
			SpawnSingleRupee( rupeeNames[i], pos )
		end
	end
	
end

function SpawnSingleRupee( rupeetype, pos )
	pos.x = pos.x + math.random( -20, 20)
	pos.y = pos.y + math.random( -20, 20)
	
	local rupee = ents.Create( rupeetype )
	
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
