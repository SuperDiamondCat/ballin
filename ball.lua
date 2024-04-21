Ball = Object:extend()

function Ball:new(x,y,xforce,yforce)
    -- place the body in the center of the world and make it dynamic, so it can move around
    self.body = love.physics.newBody(world, x, y, "dynamic")
    -- the ball's shape has a radius of 30
    self.shape = love.physics.newCircleShape(30)
    -- Attach fixture to body and give it a density of 1.
    self.fixture = love.physics.newFixture(self.body, self.shape, 1)
    self.fixture:setRestitution(0.9) -- let the ball bounce
end

function Ball:update(dt) -- No need for update
end

function Ball:draw()
   love.graphics.setColor(0.76, 0.18, 0.05) -- Red color
   love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
end

function Ball:bump(xforce,yforce)
   self.body:applyForce(math.random(xforce), math.random(yforce)) -- Go in random direction
end

function Ball:stop()
   self.body:setLinearVelocity(0, 0) -- STOP
end
