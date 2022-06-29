-- Player
local player = {x = 100, y = 100, speed = 200, size = 50, dash=100}

-- Bullet
local bullets = {}

local key_maps = {['w'] = false, ['a'] = false, ['s'] = false, ['d'] = false}

function love.keypressed(key)
    key_maps[key] = true

    if (key == 'lshift') then
        doDash()
    end
        
end

function love.keyreleased(key)
    key_maps[key] = false
end

function doDash()
    if key_maps['w'] then
        player.y = player.y - player.dash
    end
    if key_maps['s'] then
        player.y = player.y + player.dash
    end
    if key_maps['a'] then
        player.x = player.x - player.dash
    end
    if key_maps['d'] then
        player.x = player.x + player.dash
    end
end

function pewpew(mousex, mousey)
    bullet = {x = player.x, y = player.y, speed = 500}
    bullet.angle = math.atan2(bullet.y-mousey, bullet.x-mousex)
    table.insert(bullets, bullet)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        pewpew(x, y)
    end
end

function love.update(dt)
    if key_maps['w'] then
        player.y = player.y - player.speed * dt
    end
    if key_maps['s'] then
        player.y = player.y + player.speed * dt
    end
    if key_maps['a'] then
        player.x = player.x - player.speed * dt
    end
    if key_maps['d'] then
        player.x = player.x + player.speed * dt
    end


    -- move all existing bullets
    for index, bullet in ipairs(bullets) do
        if (bullet) then
            bullet.x = bullet.x - math.cos(bullet.angle)*bullet.speed*dt
            bullet.y = bullet.y - math.sin(bullet.angle)*bullet.speed*dt
        end
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', player.x, player.y, player.size, player.size)

    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.rectangle('fill', 300, 300, player.size, player.size)

    love.graphics.setColor(1, 1, 1, 1)
    for index, bullet in ipairs(bullets) do
        love.graphics.rectangle('fill', bullet.x, bullet.y, 5, 5)
    end
end
