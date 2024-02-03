HSN = {}

ServerConfig = {
    DiscordBotToken = "",
    DiscordWebhook = ""
}

GetPlayerCharacterNameESX = function(source)
    local Player = HSN.GetPlayer(source)
    identifier = Player.identifier
    local result = ExecuteSql("SELECT * FROM users WHERE identifier = '"..identifier.."'")
    if result[1] then 
        return result[1].firstname..' '..result[1].lastname 
    end;
end

RegisterServerEvent("getwebhookxd")
AddEventHandler("getwebhookxd", function()
    TriggerClientEvent("setwebhookxd", source, ServerConfig.DiscordWebhook)
end)

HSN.CheckIfAdmin = function(source)
    if not source then return print("error while finding player") end
    local Player = HSN.GetPlayer(source)
    if Config.Framework == "new-qb" then
        for k,v in pairs(Config.GetPermissions()) do
            if core.Functions.HasPermission(source, v) then
                return true
            end
        end
    elseif Config.Framework == "old-qb" then
        return CheckPermissions(core.Functions.GetPermission(source))
    elseif Config.Framework == "esx" then
        return CheckPermissions(Player.getGroup() ) 
    end
    return false
end