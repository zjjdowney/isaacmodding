local Tether = RegisterMod("!!!Jacob and Esau Tether", 1)

-- variables
local TetherSettings = {
    ["tetherLength"] = 25,
    ["activationDistance"] = 50,
    ["teleportDistance"] = 60,
    ["pushForce"] = 0.2
}

local characters = {
    { characterEntities = {}, tetherStatus = false },
    { characterEntities = {}, tetherStatus = false },
    { characterEntities = {}, tetherStatus = false },
    { characterEntities = {}, tetherStatus = false },
    { characterEntities = {}, tetherStatus = false },
}

--costume location
local RED_ANGEL_COSTUME = Isaac.GetCostumeIdByPath("gfx/characters/winged.anm2")

--give esau flight and spectral
function Tether:BaseStats(player, cacheFlag)
	if player:GetPlayerType() == PlayerType.PLAYER_ESAU then
        -- Permanent flight
        if cacheFlag == CacheFlag.CACHE_FLYING then
            player.CanFly = true
		end
		
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | TearFlags.TEAR_SPECTRAL
        end
	end
end

--give esau winged costume
function Tether:AddCostumes(playerEntity)
    local playerType = playerEntity:GetPlayerType()
    if playerType == PlayerType.PLAYER_ESAU then
        playerEntity:AddNullCostume(RED_ANGEL_COSTUME)
    end
end

--disable mod outside of game
function Tether:postGameEnd()
    characters = {
        { characterEntities = {}, tetherStatus = false },
        { characterEntities = {}, tetherStatus = false },
        { characterEntities = {}, tetherStatus = false },
        { characterEntities = {}, tetherStatus = false },
        { characterEntities = {}, tetherStatus = false },
    }
end

--tells physics function when to act
function Tether:onEveryFrame(player)
    local amountOfPlayers = Isaac.CountEntities(nil, EntityType.ENTITY_PLAYER)

    -- maintain player lists for physics interactions
    if (amountOfPlayers ~= (#characters[player.ControllerIndex + 1].characterEntities)) then
        characters = {
            { characterEntities = {}, tetherStatus = false },
            { characterEntities = {}, tetherStatus = false },
            { characterEntities = {}, tetherStatus = false },
            { characterEntities = {}, tetherStatus = false },
            { characterEntities = {}, tetherStatus = false },
        }
        for i = 1, amountOfPlayers do
            local cPlayer = Isaac.GetPlayer(i - 1)

            -- disable mod for custom characters and all variants of The Forgotten
            if (
                cPlayer:GetPlayerType() >= 41
                or cPlayer:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN
                or cPlayer:GetPlayerType() == PlayerType.PLAYER_THESOUL
                or cPlayer:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B
                or cPlayer:GetPlayerType() == PlayerType.PLAYER_THESOUL_B
            ) then
                table.insert(characters[cPlayer.ControllerIndex + 1].characterEntities, nil)
                return
            end

            table.insert(characters[cPlayer.ControllerIndex + 1].characterEntities, cPlayer)
        end
    end

    -- do nothing in solo runs
    if (amountOfPlayers == 1) then
        return
    end

    -- if drop button is pressed, disable tether
    if (Input.IsActionPressed(ButtonAction.ACTION_DROP, 0)) then
        characters[1].tetherStatus = false
    end
    if (Input.IsActionPressed(ButtonAction.ACTION_DROP, 1)) then
        characters[2].tetherStatus = false
    end
    if (Input.IsActionPressed(ButtonAction.ACTION_DROP, 2)) then
        characters[3].tetherStatus = false
    end
    if (Input.IsActionPressed(ButtonAction.ACTION_DROP, 3)) then
        characters[4].tetherStatus = false
    end
    if (Input.IsActionPressed(ButtonAction.ACTION_DROP, 4)) then
        characters[5].tetherStatus = false
    end

    for i, character in ipairs(characters) do
        for y, characterEntity in ipairs(character.characterEntities) do
            if (not (character.characterEntities[y - 1] == nil)) then
                Tether:handlePhysics(character.characterEntities[y - 1], characterEntity, i - 1)
            end
        end
    end
end

-- physics functions
function Tether:handlePhysics(mainPlayer, subPlayer, controllerIndex)
    if (type(mainPlayer) == "nil" or type(subPlayer) == "nil") then return end

    if (mainPlayer.Position:Distance(subPlayer.Position) < TetherSettings["activationDistance"] and
        (not characters[controllerIndex + 1].tetherStatus) and
        (not Input.IsActionPressed(ButtonAction.ACTION_DROP, controllerIndex))) then
            characters[controllerIndex + 1].tetherStatus = true
    end

    -- do nothing if not tethered
    if (not (characters[controllerIndex + 1].tetherStatus)) then
        return
    end

    -- do nothing if within tether length
    if (mainPlayer.Position:Distance(subPlayer.Position) < TetherSettings["tetherLength"]) then
        return
    end

    -- if characters are too far away, teleport them back
    if (mainPlayer.Position:Distance(subPlayer.Position) > TetherSettings["teleportDistance"]) then
        Tether:teleportToPlayer(mainPlayer, subPlayer)
    else
        -- if tethered but not far away (stuck on something), smoothly return
        local mainPos = mainPlayer.Position
        local subPos = subPlayer.Position
        local distance = mainPos:Distance(subPos) - TetherSettings["tetherLength"]
        if (distance > 0) then
            subPlayer.Velocity = subPlayer.Velocity + (mainPos - subPos):Normalized() * distance *
                                      TetherSettings["pushForce"] * mainPlayer.MoveSpeed
        end
    end
end

function Tether:teleportToPlayer(destination, target)
    target.Position = destination.Position + (target.Position - destination.Position):Normalized() * 30
    target.Velocity = (destination.Position - target.Position):Normalized() * 3
end

Tether:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Tether.onEveryFrame)
Tether:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, Tether.postGameEnd)
Tether:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, Tether.AddCostumes)
Tether:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Tether.BaseStats)