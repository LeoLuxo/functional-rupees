AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )

include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/green_rupee/green_rupee.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 90

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()

	return ent

end

function ENT:Touch( entity ) 
	if ( entity:IsPlayer() and entity:IsValid() ) then
		entity:SetHealth( entity:Health() + 1 )
		self:EmitSound( "rupee1.wav", 150, 100, 1, CHAN_AUTO )
		self:Remove()
	end
end