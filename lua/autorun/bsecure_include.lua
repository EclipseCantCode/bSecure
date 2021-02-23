bSecure = {}

bSecure.ConCommands = {}
function bSecure.ConCommandAdd( strName, callback )
    bSecure.ConCommands[strName] = callback
end
concommand.Add("bsecure", function(ply,cmd,args)
    if not args[1] then return end
    if bSecure.ConCommands[args[1]] then
        return bSecure.ConCommands[args[1]](ply,cmd,args)
    end
end)

local prefixCol = Color(160,200,80)
function bSecure.Print(...)
    MsgC(prefixCol,"bSecure | ",color_white,...,"\n")
end

function bSecure.IncludeModules()
    local tFiles,tFolders = file.Find("bsecure/modules/*","LUA")
    for k,sModule in ipairs(tFolders) do

        local tModuleShared,_ = file.Find("bsecure/modules/"..sModule.."/sh*.lua","LUA")
        for k,sFolder in ipairs(tModuleShared) do
            if SERVER then
                IncludeCS("bsecure/modules/"..sModule.."/"..sFolder)
            else
                include("bsecure/modules/"..sModule.."/"..sFolder)
            end
        end

        local tModuleServer,_ = file.Find("bsecure/modules/"..sModule.."/sv*.lua","LUA")
        for k,sFile in ipairs(tModuleServer) do
            if SERVER then
                include("bsecure/modules/"..sModule.."/"..sFile)
            end
        end

        local tModuleClient,_ = file.Find("bsecure/modules/"..sModule.."/cl*.lua","LUA")
        for k,sFolder in ipairs(tModuleClient) do
            if SERVER then
                AddCSLuaFile("bsecure/modules/"..sModule.."/"..sFolder)
            else
                include("bsecure/modules/"..sModule.."/"..sFolder)
            end
        end

    end
end


bSecure.IncludeModules()