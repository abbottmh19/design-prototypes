-- Player
local player = {x = 100, y = 100, speed = 200, size = 50, dash=100, direction='up'}

-- Bullet
local bullets = {}

local key_maps = {['w'] = false, ['a'] = false, ['s'] = false, ['d'] = false}

function pewpew()
    bullet = {x = player.x, y = player.y, speed = 500}
    bullet.direction = player.direction
    table.insert(bullets, bullet)
end

function love.keypressed(key)
    key_maps[key] = true

    if (key == 'lshift') then
        doDash()
    end

    if (key == 'space') then
        pewpew()
    end
        
end

function love.keyreleased(key)
    key_maps[key] = false
end

function doDash()
    if player.direction == 'up' then
        player.y = player.y - player.dash
    end
    if player.direction == 'down' then
        player.y = player.y + player.dash
    end
    if player.direction == 'left' then
        player.x = player.x - player.dash
    end
    if player.direction == 'right' then
        player.x = player.x + player.dash
    end
    if player.direction == 'upleft' then
        player.y = player.y - player.dash
        player.x = player.x - player.dash
    end
    if player.direction == 'upright' then
        player.y = player.y - player.dash
        player.x = player.x + player.dash
    end
    if player.direction == 'downleft' then
        player.y = player.y + player.dash
        player.x = player.x - player.dash
    end
    if player.direction == 'downright' then
        player.y = player.y + player.dash
        player.x = player.x + player.dash
    end
end


function love.update(dt)
    if key_maps['a'] then
        player.x = player.x - player.speed * dt
        player.direction = 'left'
    end
    if key_maps['d'] then
        player.x = player.x + player.speed * dt
        player.direction = 'right'
    end
    if key_maps['w'] then
        player.y = player.y - player.speed * dt
        player.direction = 'up'
        if key_maps['a'] then
            player.direction = 'upleft'
        end
        if key_maps['d'] then
            player.direction = 'upright'
        end
    end
    if key_maps['s'] then
        player.y = player.y + player.speed * dt
        player.direction = 'down'
        if key_maps['a'] then
            player.direction = 'downleft'
        end
        if key_maps['d'] then
            player.direction = 'downright'
        end
    end

    -- move all existing bullets
    for index, bullet in ipairs(bullets) do
        if (bullet) then
            if (bullet.direction == 'up') then
                bullet.y = bullet.y - bullet.speed * dt
            elseif (bullet.direction == 'down') then
                bullet.y = bullet.y + bullet.speed * dt
            end

            if (bullet.direction == 'left') then
                bullet.x = bullet.x - bullet.speed * dt
            elseif (bullet.direction == 'right') then
                bullet.x = bullet.x + bullet.speed * dt
            end

            if (bullet.direction == 'upleft') then
                bullet.x = bullet.x - bullet.speed * dt
                bullet.y = bullet.y - bullet.speed * dt
            end
            if (bullet.direction == 'upright') then
                bullet.y = bullet.y - bullet.speed * dt
                bullet.x = bullet.x + bullet.speed * dt
            end
            if (bullet.direction == 'downleft') then
                bullet.x = bullet.x - bullet.speed * dt
                bullet.y = bullet.y + bullet.speed * dt
            end
            if (bullet.direction == 'downright') then
                bullet.y = bullet.y + bullet.speed * dt
                bullet.x = bullet.x + bullet.speed * dt
            end

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
