--< Anti Prop Kill config >--

APKconfig = APKconfig or {}

--< Whitelists >--
APKconfig.pickupWhitelist = {""}                      -- Disables the ghosting of the whitelisted class.
APKconfig.puntWhitelist = {""}                        -- Allows punting of the whitelisted class when punting is disabled.
APKconfig.playerPuntWhitelist = {""}                  -- The players that can punt even if the punting is disabled.
APKconfig.playerPickupWhitelist = {""}                -- The players that can pick up props without ghosting them.

--< Blacklist >--
APKconfig.disablePickup = {""}                        -- Prevents the users on picking up anything using the physgun.

--< Settings >--
APKconfig.disablePropDamage = true                    -- Disables prop damage.
APKconfig.disablePropGhosting = false                 -- Disables prop ghosting on physgun pickup.
APKconfig.disablePunt = false                         -- Disables the gravity gun punt.

--< Ghosting settings >--
APKconfig.color = Color(0, 0, 0, 100)                 -- The color of the prop when you pick it up (Red, Green, Blue, Alpha). Alpha determines the transparency.
APKconfig.material = "models/debug/debugwhite"        -- The material of the prop when you pick it up, leave it blank if you don't want to set it's material.
APKconfig.timer = 5                                   -- How long until the prop returns back to normal after dropping.
APKconfig.collideWithNotFrozen = false                -- Disables collision to other props that are not frozen when you're using the physgun (makes it harder to build IMO, but it does prevent a method of prop boosting).
APKconfig.renderMode = RENDERMODE_TRANSALPHA          -- The rendermode on physgun pickup.
APKconfig.collisionGroup = COLLISION_GROUP_WEAPON     -- The collision group on physgun pickup.
