function love.load()

    Object = require "classic"
    require("ball")
    require("player")

	
    -- Set physics settings and base table for all objects
    love.physics.setMeter(64)
    -- Set gravity to 0,0
    world = love.physics.newWorld(0, 0, true)
    -- Table for ALL objects
    objects = {}

    -- Set table for borders
    objects.borders = {}

    -- Set borders on edges of screen
    objects.borders.bottom_border = {}
    objects.borders.bottom_border.body = love.physics.newBody(world, love.graphics.getWidth()/2, love.graphics.getHeight()) -- On bottom center
    objects.borders.bottom_border.shape = love.physics.newRectangleShape(love.graphics.getWidth(), 2) -- Width is equal to width of screen
    objects.borders.bottom_border.fixture = love.physics.newFixture(objects.borders.bottom_border.body, objects.borders.bottom_border.shape)

    objects.borders.top_border = {}
    objects.borders.top_border.body = love.physics.newBody(world, love.graphics.getWidth()/2, 0) -- On top center
    objects.borders.top_border.shape = love.physics.newRectangleShape(love.graphics.getWidth(), 2) -- Width is equal to width of screen
    objects.borders.top_border.fixture = love.physics.newFixture(objects.borders.top_border.body, objects.borders.top_border.shape)

    objects.borders.left_border = {}
    objects.borders.left_border.body = love.physics.newBody(world, 0, love.graphics.getHeight()/2) -- On center of left edge
    objects.borders.left_border.shape = love.physics.newRectangleShape(2, love.graphics.getHeight()) -- Height is equal to width of screen
    objects.borders.left_border.fixture = love.physics.newFixture(objects.borders.left_border.body, objects.borders.left_border.shape)

    objects.borders.right_border = {}
    objects.borders.right_border.body = love.physics.newBody(world, love.graphics.getWidth(), love.graphics.getHeight()/2) -- On center of right edge
    objects.borders.right_border.shape = love.physics.newRectangleShape(2, love.graphics.getHeight()) -- Height is equal to width of screen
    objects.borders.right_border.fixture = love.physics.newFixture(objects.borders.right_border.body, objects.borders.right_border.shape)

    -- Table for all balls
    objects.listOfBalls = {}

    -- Spawn a player
    objects.player = Player()

end

function love.keypressed(key)

    if key == "n" then -- 'N' for spawn New ball
        table.insert(objects.listOfBalls, Ball(math.random(love.graphics.getWidth()), math.random(love.graphics.getHeight()))) -- On random position
    end

    if key == "r" then -- 'R' for Random
        for i,v in ipairs(objects.listOfBalls) do -- Call function for all balls
            v:bump(math.random(-40000,40000),math.random(-40000,40000))
        end
    end

    if key == "s" then -- 'S' for Stop
        for i,v in ipairs(objects.listOfBalls) do -- Call function for all balls
            v:stop()
        end
    end
    
end

function love.update(dt)
    world:update(dt) -- Update physics
    objects.player:update(dt) -- Update player and its input
end

function love.draw()
    for i,v in ipairs(objects.listOfBalls) do -- Draw all balls from table
        v:draw()
    end

    objects.player:draw() -- Draw player and bullets
end

function love.resize(w, h) -- Resize border when window is resized
    objects.borders.bottom_border.body:setPosition(w/2,h)
    objects.borders.bottom_border.shape = love.physics.newRectangleShape(love.graphics.getWidth(), 2) -- Width is equal to width of screen
    objects.borders.bottom_border.fixture = love.physics.newFixture(objects.borders.bottom_border.body, objects.borders.bottom_border.shape)
    
    objects.borders.top_border.body:setPosition(w/2,0)
    objects.borders.top_border.shape = love.physics.newRectangleShape(love.graphics.getWidth(), 2) -- Width is equal to width of screen
    objects.borders.top_border.fixture = love.physics.newFixture(objects.borders.top_border.body, objects.borders.top_border.shape)
    
    objects.borders.left_border.body:setPosition(0,h/2)
    objects.borders.left_border.shape = love.physics.newRectangleShape(2, love.graphics.getHeight()) -- Height is equal to width of screen
    objects.borders.left_border.fixture = love.physics.newFixture(objects.borders.left_border.body, objects.borders.left_border.shape)
    
    objects.borders.right_border.body:setPosition(w,h/2)
    objects.borders.right_border.shape = love.physics.newRectangleShape(2, love.graphics.getHeight()) -- Height is equal to width of screen
    objects.borders.right_border.fixture = love.physics.newFixture(objects.borders.right_border.body, objects.borders.right_border.shape)
end
