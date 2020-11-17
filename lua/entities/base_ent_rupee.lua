AddCSLuaFile()


ENT.Type			= "anim"
ENT.Base			= "base_gmodentity"

ENT.PrintName		= "BASE ENT RUPEE"
ENT.Category		= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Author			= "LeoLuxo"
ENT.Contact			= ""

ENT.Spawnable		= false
ENT.AdminSpawnable	= false


ENT.RupeeModel		= "models/green_rupee/green_rupee.mdl"
ENT.RupeeValue		= 0
ENT.RupeeSound		= "rupee1.wav"


if SERVER then
	
	function ENT:Initialize()
		self:SetModel( self.RupeeModel )
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
			
			cap = GetConVar( "gmod_functional_rupees_cap" ):GetInt()
			
			if ( GetConVar( "gmod_functional_rupees_armor" ):GetBool() ) then
				if ( cap == 0 ) then
					ent:SetArmor( math.max( ent:Armor() + self.RupeeValue, 0 ) )
				else
					ent:SetArmor( math.Clamp( ent:Armor() + self.RupeeValue, 0, cap ) )
				end
			else
				if ( self.RupeeValue >= 0 ) then
					if ( cap == 0 ) then
						ent:SetHealth( ent:Health() + self.RupeeValue )
					elseif ( cap >= ent:Health() ) then
						ent:SetHealth( math.min( ent:Health() + self.RupeeValue, cap ) )
					end
				else
					ent:TakeDamage(-self.RupeeValue, ent, nil)
				end
			end
			
			self:EmitSound( self.RupeeSound, 150, 100, 1, CHAN_AUTO )
			self:Remove()
		end
		
	end
	
end