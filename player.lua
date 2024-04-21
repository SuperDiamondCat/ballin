Player = Object:extend()
require("bullet")

function Player:new()
   -- Place player at center of world
   self.body = love.physics.newBody(world, love.graphics.getWidth()/2, love.graphics.getHeight()/2, "dynamic")
   -- Make a triangle
   self.shape = love.physics.newPolygonShape(30, 0, -20, 20, -20, -20)
   -- Attach fixture to body and give it a density of 1.
   self.fixture = love.physics.newFixture(self.body, self.shape, 5)

   self.force = 15000
   self.bulletForce = 1000000

    -- Table for all bullets
    self.listOfBullets = {}
end

function Player:update(dt)
   theta = self.body:getAngle()

   -- Process input
   if love.keyboard.isDown("up") then
      self.body:applyForce(self.force*math.cos(theta)*dt,self.force*math.sin(theta)*dt)
   end
	
   if love.keyboard.isDown("down") then
      self.body:applyForce(-self.force*math.cos(theta)*dt,-self.force*math.sin(theta)*dt)
   end

   if love.keyboard.isDown("right") then
      self.body:setAngle(theta + 7*dt)
      self.body:setAngularVelocity(0)
      --print(self.body:getAngularVelocity())
   end

   if love.keyboard.isDown("left") then
      self.body:setAngle(theta - 7*dt)
      self.body:setAngularVelocity(0)
      --print(self.body:getAngularVelocity())
   end

   if love.keyboard.isDown("space") then
      table.insert(self.listOfBullets, Bullet(self.body:getX() + math.cos(theta) * 50,self.body:getY()  + math.sin(theta) * 50, self.bulletForce*math.cos(theta), self.bulletForce*math.sin(theta))) -- Cursed line that places bullets near player
   end
   -- print(theta)
end

function Player:draw()
   for i,v in ipairs(self.listOfBullets) do -- Draw all bullets
      v:draw() 
   end
   love.graphics.setColor(0.24, 0.40, 0.86) -- Blueish color
   love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
