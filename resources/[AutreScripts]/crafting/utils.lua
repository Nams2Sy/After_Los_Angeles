Utils = {}

Utils.Translate = function (type)
    if type == "FURNACE" then
        return "four"
    end
    return type
end

Utils.Split = function (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end