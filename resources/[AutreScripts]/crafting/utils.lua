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
