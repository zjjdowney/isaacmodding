local mod = RegisterMod("Tainted Forgotten turns Red Hearts into Bone Orbitals", 1)


function mod:heartCollision(pickup, collider, _)
	if collider:ToPlayer() and (collider:ToPlayer():GetPlayerType() == 35 or collider:ToPlayer():GetPlayerType() == 40) and (pickup.SubType == 1 or pickup.SubType == 2 or pickup.SubType == 5 or pickup.SubType == 9 or pickup.SubType == 12) then
		local player = collider:ToPlayer()
		local legal = false
		if pickup:IsShopItem() then
			if player:GetNumCoins() >= pickup.Price then
				player:AddCoins(-pickup.Price)
				legal = true
			end
		else
			legal = true
		end
		if legal then
			local amount
			if pickup.SubType == 2 then
				amount = 1
				SFXManager():Play(185, 1, 2, false, 1, 0)
			elseif pickup.SubType == 1 or pickup.SubType == 9 then
				amount = 2
				SFXManager():Play(185, 1, 2, false, 1, 0)
			elseif pickup.SubType == 5 then
				amount = 4
				SFXManager():Play(185, 1, 2, false, 1, 0)
			elseif pickup.SubType == 12 then
				amount = 1
				SFXManager():Play(497, 1, 2, false, 1, 0)
				player:AddBlueFlies(3, player.Position, nil)
			end
			if player:HasCollectible(312) then amount = amount * 2 end
			if player:GetPlayerType() == 40 then
				for _, entity in pairs(Isaac.FindByType(1, -1, -1)) do
					local target = entity:ToPlayer()
					if target:GetPlayerType() == 35 and player.ControllerIndex == target.ControllerIndex then
						for i = 1, amount do Isaac.Spawn(3, 128, 0, pickup.Position, Vector.FromAngle(math.random(360)) * 3, target) end
					end
				end
			else
				for i = 1, amount do Isaac.Spawn(3, 128, 0, pickup.Position, Vector.FromAngle(math.random(360)) * 3, player) end
			end
			if pickup.OptionsPickupIndex > 0 then
				for _, entity in pairs(Isaac.FindByType(5, -1, -1)) do
					if entity:ToPickup().OptionsPickupIndex and entity:ToPickup().OptionsPickupIndex == pickup.OptionsPickupIndex and GetPtrHash(entity:ToPickup()) ~= GetPtrHash(pickup) then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil)
					entity:Remove()
					end
				end
			end
			pickup:Remove()
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.heartCollision, 10)