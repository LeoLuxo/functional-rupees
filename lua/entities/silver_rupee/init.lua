AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )

include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/silver_rupee/silver_rupee.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
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

function ENT:Think()
	players = player.GetAll()
	
	for i, p in pairs( players ) do
		d = math.Distance( p:GetPos().x, p:GetPos().y, self:GetPos().x, self:GetPos().y )
		
		if ( d <= p:BoundingRadius() and self:GetPos().z + 12 >= p:GetPos().z and self:GetPos().z <= p:OBBMaxs().z and p:Alive() ) then
			p:SetHealth( p:Health() + 100 )
			self:EmitSound( "rupee3.wav", 150, 100, 1, CHAN_AUTO )
			self:Remove()
		end
	end

	self:NextThink( CurTime() )
	return true
end