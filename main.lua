files_uri = love.filesystem.enumerate("images")

images = {}
for i,v in pairs(files_uri) do
  if string.sub(v,-4,-1) == ".png" then
    images[i] = love.graphics.newImage("images/"..v)
    images[i]:setFilter("nearest","nearest")  
  end
end

current_img = math.random(1,#images)

font_raw = love.graphics.newImage("imagefont.png")
font_raw:setFilter("nearest","nearest")

font = love.graphics.newImageFont(font_raw,
  " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-:;.,/\\+-*!?'\")(][}{#$<>&@%")

love.graphics.setFont(font)

dmg = require('dmg01')

speed = 10

function love.draw()
  dmg.pre_draw()
  for x = 0,1 do
    for y = 0,1 do
      love.graphics.draw(images[current_img],
        math.floor(offset*speed)%(dmg.w)-dmg.w*x,
        math.floor(offset*speed)%(dmg.h)-dmg.h*y)
    end
  end
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill",1,1,dmg.w-2,8*3+1)
  love.graphics.setColor(0,0,0)
  love.graphics.print(
    "PALETTE(L/R):"..string.upper(dmg.palette[dmg.current_palette].name)..
    "\nSCALE(U/D):"..dmg.scale..
    "\nIMG(SPACE):"..current_img,
    2,2)
  love.graphics.setColor(255,255,255)
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
  elseif key == "left" then
    dmg.current_palette = dmg.current_palette - 1
    if dmg.current_palette < 1 then
      dmg.current_palette = #dmg.palette
    end
  elseif key == "right" then
    dmg.current_palette = dmg.current_palette + 1
    if dmg.current_palette > #dmg.palette then
      dmg.current_palette = 1
    end
  elseif key == " " then
    current_img = current_img + 1
    if current_img > #images then
      current_img = 1
    end
  end
end
