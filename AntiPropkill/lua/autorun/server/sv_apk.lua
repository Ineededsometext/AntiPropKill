AddCSLuaFile()
if file.Exists("apkconfig.lua", "LUA") then
    include("apkconfig.lua")
end

hook.Add("Initialize", "AddonStartUp", function()
    print("[APK v1.0 has intialized.]")
end)

--< Sets the spawned prop's owner >-- 
hook.Add("PlayerSpawnedProp", "SetPropOwner", function(ply, mdl, ent)
    --< Check if the entity doesn't have an owner >--
    if ent.antiPropKillOwner == nil then
        --< Sets the entity's owner >--
        ent.antiPropKillOwner = ply
        ent:SetCustomCollisionCheck(true)
    end
end)

hook.Add("ShouldCollide", "RemovePropCollision", function(ent1, ent2)
    if APKconfig.collideWithNotFrozen or 1 == 2 then
        if IsValid(ent1) and IsValid(ent2) then
            if ent1.antiPropKillOwner != nil and ent2.antiPropKillOwner != nil then
                if ent1.pickedUp == true or ent2.pickedUp == true then
                    if ent1.antiPropKillOwner != ent2.antiPropKillOwner then
                        if ent1:GetPhysicsObject():IsMoveable() == true and ent2:GetPhysicsObject():IsMoveable() == true then 
                            return false
                        else
                            return true
                        end
                    end

                    if ent1.antiPropKillOwner == ent2.antiPropKillOwner then
                        if ent1:GetPhysicsObject():IsMoveable() == true and ent2:GetPhysicsObject():IsMoveable() == true then 
                            return false
                        else
                            return true
                        end
                    end
                end
            end
        end
    end
end)

--< Disable collision on players and vehicles on prop pickup >--
hook.Add("PhysgunPickup", "AntiPropKill", function(ply, ent)
    if table.HasValue(APKconfig.disablePickup or {}, ply:Nick()) then return false end
    ent.pickedUp = true

    if not APKconfig.disablePropGhosting or 1 == 1 then
        if not table.HasValue(APKconfig.pickupWhitelist or {}, ent:GetClass()) then
            if not table.HasValue(APKconfig.playerPickupWhitelist or {}, ply:Nick()) then
                --< Check if the thing that's been pickup is a player or an NPC >--
                if ent:IsPlayer() or ent:IsNPC() then return end

                --< Removes the timer if it exists on the entity that has been picked up and all the constarined objects >--
                if timer.Exists("AntiPropKill"..ent:EntIndex()) then timer.Remove("AntiPropKill"..ent:EntIndex()) end
                for i, v in pairs(constraint.GetAllConstrainedEntities(ent)) do
                    if IsValid(v) then
                        if timer.Exists("AntiPropKill"..v:EntIndex()) then timer.Remove("AntiPropKill"..v:EntIndex()) end
                    end
                end

                --< Grab the data from the prop >--
                if ent.color == nil then
                    ent.color = ent:GetColor()
                end

                if ent.material == nil then
                    ent.material = ent:GetMaterial()
                end

                if ent.collision == nil then
                    ent.collision = ent:GetCollisionGroup()
                end

                if ent.rendermode == nil then
                    ent.rendermode = ent:GetRenderMode()
                end

                --< Change prop collision group and make it transparent >--
                ent:SetRenderMode(APKconfig.renderMode or RENDERMODE_TRANSALPHA)
                ent:SetCollisionGroup(APKconfig.collisionGroup or COLLISION_GROUP_WEAPON)
                ent:SetColor(APKconfig.color or Color(0, 0, 0, 100))
                ent:SetMaterial(APKconfig.material or "models/debug/debugwhite")

                --< Grab all the constrained objects to the prop that has been picked up >--
                for k, v in pairs(constraint.GetAllConstrainedEntities(ent)) do
                    --< Check if there are any constrained object(s) >--
                    if IsValid(v) then

                        --< Grab the data of the constarined object(s) >--
                        if v.color == nil then
                            v.color = v:GetColor()
                        end

                        if v.material == nil then
                            v.material = v:GetMaterial()
                        end

                        if v.collision == nil then
                            v.collision = v:GetCollisionGroup()
                        end

                        if v.rendermode == nil then
                            v.rendermode = v:GetRenderMode()
                        end

                        --< Change constrained object(s) collision group and make it transparent >-- 
                        v:SetRenderMode(APKconfig.renderMode or RENDERMODE_TRANSALPHA)
                        v:SetCollisionGroup(APKconfig.collisionGroup or COLLISION_GROUP_WEAPON)
                        v:SetColor(APKconfig.color or Color(0, 0, 0, 100))
                        v:SetMaterial(APKconfig.material or "models/debug/debugwhite")
                    end
                end
            end
        end
    end
end)

hook.Add("PhysgunDrop", "AntiPropKill", function(ply, ent)
    ent.pickedUp = false
    if not ent:IsPlayer() or not ent:IsNPC() then
        --< Resets the prop back to normal >--
        timer.Create("AntiPropKill"..ent:EntIndex(), APKconfig.timer or 5, 1, function()
            if IsValid(ent) then
                ent:SetRenderMode(ent.rendermode)
                ent:SetCollisionGroup(ent.collision)
                ent:SetColor(ent.color)
                ent:SetMaterial(ent.material)
                for i, v in pairs(constraint.GetAllConstrainedEntities(ent)) do
                    if IsValid(v) and v != ent then
                        v:SetRenderMode(v.rendermode)
                        v:SetCollisionGroup(v.collision)
                        v:SetColor(v.color)
                        v:SetMaterial(v.material)

                        v.rendermode = nil 
                        v.collision = nil
                        v.color = nil
                        v.material = nil
                    end
                end

                ent.rendermode = nil 
                ent.collision = nil
                ent.color = nil
                ent.material = nil
            end
        end)
    end
end)

--< Anti prop damage >--
hook.Add("EntityTakeDamage", "DisablePropDamage", function(t, d)
    if APKconfig.DisablePropDamage or 1 == 1 then
        if d:GetInflictor():GetClass() == "prop_physics" then 
            d:SetDamage(0) 
        end
    end
end)

--< Anti gravity gun punt >--
hook.Add("GravGunPunt", "DisableGravityGunPunt", function(ply, ent)
    if APKconfig.disablePunt or 1 == 2 then
        if not table.HasValue(APKconfig.playerPuntWhitelist or {}, tostring(ply:Nick())) then
            if not table.HasValue(APKconfig.puntWhitelist or {}, ent:GetClass()) then
                return false
            end   
        end
    end
end)
