Utils = {}

Utils.Translate = function (type)
    if type == "FURNACE" then
        return "four"
    end
    return type
end

Utils.GetRecipes = function (type)
    local recipes = {}
    for _, recipe in ipairs(Config.Recipes[type]) do
        table.insert(recipes, recipe)
    end
    print(json.encode(recipes))
    return recipes
end

Utils.GetRecipe = function (type, recipe_id)
    for _, recipe in ipairs(Config.Recipes[type]) do
        if (recipe.id == recipe_id) then return recipe end
    end
    return {}
end

Utils.Dump = function (o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

Utils.Clamp = function (low, n, high)
    return math.min(math.max(n, low), high)
end

Utils.StartsWith = function (String,Start)
    return string.sub(String,1,string.len(Start))==Start
end
