--[[
                     Anti prop kill config
                                                                ]]--

--< If the config gets deleted it will set everything to default settings >--

APKconfig = APKconfig or {}

APKconfig.color = Color(0, 0, 0, 100)          -- The color of the prop when you pick it up (Red, Greeb, Blue, Alpha). Alpha determines the transparency.
APKconfig.material = "models/debug/debugwhite" -- The material of the prop when you pick it up, leave it blank if you don't want to set it's material.
APKconfig.timer = 5                            -- How long until the prop returns back to normal after dropping.
APKconfig.disablePropDamage = true             -- Disables prop damage.

--< Don't touch these unless you know what you are doing >--
APKconfig.renderMode = RENDERMODE_TRANSALPHA
APKconfig.collisionGroup = COLLISION_GROUP_WEAPON