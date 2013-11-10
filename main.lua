cat = love.graphics.newImage("cat.png")
cat:setFilter("nearest","nearest")

dmg = require('dmg01')

function love.draw()
  dmg.pre_draw()
  for x = 0,1 do
    for y = 0,1 do
      love.graphics.draw(cat,
        math.floor(offset*100)%(dmg.w)-dmg.w*x,
        math.floor(offset*100)%(dmg.h)-dmg.h*y)
    end
  end
  dmg.post_draw()
end

offset = 0
function love.update(dt)
  offset = offset + dt
end

function love.keypressed(key)
  if key == "up" then
    if dmg.scale*2 <= dmg.scale_max then
      dmg:setScale(dmg.scale*2)
    end
  elseif key == "down" then
    if dmg.scale/2 >= dmg.scale_min then
      dmg:setScale(dmg.scale/2)
    end
  end
end
