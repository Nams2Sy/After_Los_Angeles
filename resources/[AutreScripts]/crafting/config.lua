Config = {}

Config.Recipes = {}

Config.Recipes.FURNACE = {
    {
        id = 1,
        input = {
            {
                name = "scrapmetal",
                quantity = 1
            }
        },
        output = {
            {
                name = "ingot",
                quantity = 1
            }
        }, -- TODO check if recipe exist on serverside or add an identifier to make it unique
        time = 5
    },
    {
        id = 2,
        input = {
            {
                name = "raw_meat",
                quantity = 1
            }
        },
        output = {
            {
                name = "burger",
                quantity = 1
            }
        },
        time = 10
    }
}