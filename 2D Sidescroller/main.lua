function love.load()
    wf = require 'libraries/windfield'
    world = wf.newWorld(0,1000, true)
    world:setQueryDebugDrawing(true)
    camera = require 'libraries/camera'
    cam = camera()

    Player = {}
    Player.x = 10
    Player.y = 10
    Player.size = 50
    Player.speed = 5
    world:addCollisionClass('Player')
    Player.collider = world:newRectangleCollider(Player.x,Player.y,Player.size,Player.size)
    Player.collider:setFixedRotation(true)
    Player.collider:setCollisionClass('Player')

    world:addCollisionClass('Land')
    Wall = world:newRectangleCollider(100, 500, 300,40)

    Wall:setType('static')
end

function love.update(dt)
    local PX, PY = Player.collider:getPosition()
   
    local isMoving = false
    world:update(dt)
    Player.x = Player.collider:getX()
    Player.y = Player.collider:getY()

    if love.keyboard.isDown("a") and Player.x > Player.size/2 then
        Player.collider:setX(PX + Player.speed*-1)
        isMoving = true
        
    end
    if love.keyboard.isDown("d") and Player.x < love.graphics.getWidth() - Player.size/2 then
         Player.collider:setX(PX + Player.speed)
        isMoving = true
        
    end

    function love.keypressed(key)
        if key == "space" then
            Player.collider:applyLinearImpulse(0,-2000)
        end
    end
end

function love.draw()
    love.graphics.setColor(1,.6,0)
    love.graphics.rectangle("fill",Player.collider:getX()-Player.size/2,Player.collider:getY()-Player.size/2,Player.size,Player.size)
    world:draw()
end
