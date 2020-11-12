ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.Author = "LeoLuxo"
ENT.Contact = ""

ENT.PrintName = "Green Rupee (1)"
ENT.Category = "Rupees"
ENT.Purpose = "Gives you 1 health"
ENT.Instructions = ""

ENT.Spawnable = true
ENT.AdminSpawnable = false


if SERVER then
	
	function ENT:Initialize()
		self:SetModel( "models/green_rupee/green_rupee.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		self:SetTrigger( true )
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
	
	function ENT:Touch( ent )
		
		if ( ent:IsPlayer() and ent:IsValid() ) then
			if ( GetConVar( "gmod_functional_rupees_armor" ):GetBool() ) then
				ent:SetArmor( ent:Armor() + 1 )
			else
				ent:SetHealth( ent:Health() + 1 )
			end
			
			self:EmitSound( "rupee1.wav", 150, 100, 1, CHAN_AUTO )
			self:Remove()
		end
		
	end
	
end