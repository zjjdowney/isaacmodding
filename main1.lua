local Mod = RegisterMod("!!!Scaling Familiars", 1)

function Mod:BBUpdate(BB)

local game = Game()
local stage = game:GetLevel():GetStage()
local entities = Isaac.GetRoomEntities()
	
	for i = 1, #entities do
		local data = entities[i]:GetData()
			if entities[i].Type == EntityType.ENTITY_TEAR and entities[i].SpawnerVariant == FamiliarVariant.BROTHER_BOBBY then
				if stage == LevelStage.STAGE1_1 or stage == LevelStage.STAGE1_2 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 3.5
				elseif stage == LevelStage.STAGE2_1 or stage == LevelStage.STAGE2_2 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 4.5
				elseif stage == LevelStage.STAGE3_1 or stage == LevelStage.STAGE3_2 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 5.5
				elseif stage == LevelStage.STAGE4_1 or stage == LevelStage.STAGE4_2 or stage == LevelStage.STAGE4_3 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 6.5
				elseif stage == LevelStage.STAGE5 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 7.5
				elseif stage == LevelStage.STAGE6 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 8
				elseif stage == LevelStage.STAGE7 or stage == LevelStage.STAGE8 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 8.5
				else 
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 3.5
				end
			end
	end
end
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Mod.BBUpdate, FamiliarVariant.BROTHER_BOBBY)

function Mod:SMUpdate(SM)

local game = Game()
local stage = game:GetLevel():GetStage()
local entities = Isaac.GetRoomEntities()
	
	for i = 1, #entities do
		local data = entities[i]:GetData()
			if entities[i].Type == EntityType.ENTITY_TEAR and entities[i].SpawnerVariant == FamiliarVariant.SISTER_MAGGY then
				if stage == LevelStage.STAGE1_1 or stage == LevelStage.STAGE1_2 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 6
				elseif stage == LevelStage.STAGE2_1 or stage == LevelStage.STAGE2_2 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 7.5
				elseif stage == LevelStage.STAGE3_1 or stage == LevelStage.STAGE3_2 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 8.5
				elseif stage == LevelStage.STAGE4_1 or stage == LevelStage.STAGE4_2 or stage == LevelStage.STAGE4_3 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 9.5
				elseif stage == LevelStage.STAGE5 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 10.5
				elseif stage == LevelStage.STAGE6 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 11
				elseif stage == LevelStage.STAGE7 or stage == LevelStage.STAGE8 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 11.5
				else 
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 6
				end
			end
	end
end
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Mod.SMUpdate, FamiliarVariant.SISTER_MAGGY)

function Mod:LGUpdate(LG)

local game = Game()
local stage = game:GetLevel():GetStage()
local entities = Isaac.GetRoomEntities()
	
	for i = 1, #entities do
		local data = entities[i]:GetData()
			if entities[i].Type == EntityType.ENTITY_TEAR and entities[i].SpawnerVariant == FamiliarVariant.LITTLE_GISH then
				if stage == LevelStage.STAGE1_1 or stage == LevelStage.STAGE1_2 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 3.5
				elseif stage == LevelStage.STAGE2_1 or stage == LevelStage.STAGE2_2 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 4.5
				elseif stage == LevelStage.STAGE3_1 or stage == LevelStage.STAGE3_2 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 5.5
				elseif stage == LevelStage.STAGE4_1 or stage == LevelStage.STAGE4_2 or stage == LevelStage.STAGE4_3 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 6.5
				elseif stage == LevelStage.STAGE5 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 7.5
				elseif stage == LevelStage.STAGE6 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 8
				elseif stage == LevelStage.STAGE7 or stage == LevelStage.STAGE8 then
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 8.5
				else 
					entities[i]:ToTear().Scale = 1
					entities[i].CollisionDamage = 3.5
				end
			end
	end
end
Mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, Mod.LGUpdate, FamiliarVariant.LITTLE_GISH)