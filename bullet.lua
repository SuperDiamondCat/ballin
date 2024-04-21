Bullet = Object:extend()

function Bullet:new(x,y,xforce,yforce)
   -- Place bullet at given coordinates
   self.body = love.physics.newBody(world, x, y, "dynamic")
   -- Make a triangle
   self.shape = love.physics.newRectangleShape(20,20)
   -- Attach fixture to body and give it a density of 1.
   self.fixture = love.physics.newFixture(self.body, self.shape, 5)
   -- Apply force on start
   self.body:applyForce(math.random(xforce), math.random(yforce))
end

function Bullet:update(dt)

end

function Bullet:draw()
   love.graphics.setColor(1, 1, 1) -- White color
   love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
