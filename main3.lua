local PocketMod =  RegisterMod("!!!Pocket Items on Default", 1)

local CharTable = {}
CharTable["Isaac"] = 105
CharTable["Magdalene"] = 45
CharTable["Cain"] = 0
CharTable["Judas"] = 34
CharTable["???"] = 36
CharTable["Eve"] = 126
CharTable["Samson"] = 0
CharTable["Azazel"] = 0
CharTable["Lazarus"] = 0
CharTable["Lazarus II"] = 0
CharTable["Eden"] = -1
CharTable["The Lost"] = 609
CharTable["Lilith"] = 357
CharTable["Keeper"] = 349
CharTable["Apollyon"] = 477
CharTable["The Forgotten"] = 0
CharTable["The Soul"] = 0
CharTable["Bethany"] = 0
CharTable["Jacob"] = 0
CharTable["Esau"] = 0
CharTable["Black Judas"] = 0

local ActiveCharsPocketActive = {0,0,0,0}
local eden = false
local moddedCharsEnabled = false

local MaxPlayers = 0
function PocketMod:AddPocketItem(_PocketMod)
    local playerCount = Game():GetNumPlayers()

    if playerCount >= MaxPlayers then
        for i = playerCount-1,MaxPlayers,1 do
            local player = Isaac.GetPlayer(i)
            local pname = player:GetName()

            if CharTable[pname] == nil then
                CharTable[pname] = -2
            end

            if CharTable[pname] > 0 and player:GetActiveItem(0) == CharTable[pname] and player:GetActiveItem(2) == 0 and player:GetPlayerType() < 21 then
                player:SetPocketActiveItem(CharTable[pname])
                player:RemoveCollectible(CharTable[pname])
                ActiveCharsPocketActive[i] = CharTable[pname]
                print("added item ", CharTable[pname], " to pocket")
            end

            if CharTable[pname] == -1 and player:GetActiveItem(2) == 0 and eden == true then
                player:SetPocketActiveItem(player:GetActiveItem())
                player:RemoveCollectible(player:GetActiveItem())
                
                print("Eden: added item ", player:GetActiveItem(2), " to pocket")
            end 

            if ActiveCharsPocketActive[i] ~= CharTable[pname] and player:GetActiveItem(2) == 0 and CharTable[pname] ~= -1 and player:GetPlayerType() < 21 then 
                player:SetPocketActiveItem(CharTable[pname])
            end

            if CharTable[pname] == -2 and player:GetActiveItem(2) == 0 and moddedCharsEnabled == true  then
                
                player:SetPocketActiveItem(player:GetActiveItem())
                player:RemoveCollectible(player:GetActiveItem())
                print("Modded Char: added item ", player:GetActiveItem(2), " to pocket")
            end
        end
    end
    MaxPlayers = playerCount
end
PocketMod:AddCallback(ModCallbacks.MC_POST_UPDATE, PocketMod.AddPocketItem)