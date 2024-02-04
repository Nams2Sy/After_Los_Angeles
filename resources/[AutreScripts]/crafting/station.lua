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

if IsDuplicityVersion() then

    function Station:tick ()
        print("tick")
    end
    
    function Station:save ()
        
    end

end