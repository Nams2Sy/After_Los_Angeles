Station = {
    id = -1,
    coords = "{}",
    type = "",
    recipe_queue = {},
    time_left = -1,
    output = {}
}

function Station:new (o, id, coords, type, recipe_queue, time_left, output)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.id = id
    self.coords = coords
    self.type = type
    self.recipe_queue = recipe_queue
    self.time_left = time_left
    self.output = output
    return o
end

function Station:getRecipe()
    if #self.recipe_queue == 0 then return end
    return Utils.GetRecipe(self.type, self.recipe_queue[1])
end

function Station:getRecipePercentage()
    local recipe = self:getRecipe()
    if not recipe then return end

    local elapsed = recipe.time - self.time_left / 1000
    return Utils.Clamp(0, (elapsed * 100) / recipe.time, 100)
end

function Station:toTable()
    return {
        id = self.id,
        coords = self.coords,
        type = self.type,
        recipe_queue = self.recipe_queue,
        time_left = self.time_left,
        output = self.output
    }
end

if IsDuplicityVersion() then

    function Station:craft(recipe_id)
        table.insert(self.recipe_queue, tonumber(recipe_id))
    end

    function Station:tick ()
        local recipe = self:getRecipe()
        if not recipe then return end

        if self.time_left == -1 then
            self.time_left = recipe.time * 1000
        end

        self.time_left -= Config.Tick
        self.time_left = math.max(self.time_left, 0)

        if self.time_left ~= 0 then return end

        table.remove(self.recipe_queue, 1)
        self.time_left = -1

        for _, item in ipairs(recipe.output) do
            self:addItem(item)
        end
    end

    function Station:addItem (item)
        table.insert(self.output, item)
    end

    function Station:takeItems (source)
        for index, item in ipairs(self.output) do
            if exports.ox_inventory:CanCarryItem(source, item.name, item.quantity) then
                exports.ox_inventory:AddItem(source, item.name, item.quantity)
                table.remove(self.output, index)
            else
                TriggerClientEvent('ox_lib:notify', source, {
                    title = 'Vous n\'avez pas la place',
                    description = 'Le poids de x'..tostring(item.quantity)..' '..item.name..' n\'est pas supportable.',
                    position = 'top',
                    style = {
                        backgroundColor = '#141517',
                        color = '#C1C2C5',
                        ['.description'] = {
                        color = '#909296'
                        }
                    },
                    icon = 'ban',
                    iconColor = '#C53030'
                })
            end
        end
    end

end