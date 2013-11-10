math.randomseed(os.time())

files_uri = love.filesystem.enumerate("images")

images = {}
for i,v in pairs(files_uri) do
  if string.sub(v,-4,-1) == ".png" then
    images[i] = {}
    images[i].name = string.sub(v,1,-5)
    images[i].img = love.graphics.newImage("images/"..v)
    images[i].img:setFilter("nearest","nearest")  
  end
end

current_img = math.random(1,#images)

bg = love.graphics.newImage("bg.png")

font_raw = love.graphics.newImage("imagefont.png")
font_raw:setFilter("nearest","nearest")

font = love.graphics.newImageFont(font_raw,
  " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-:;.,/\\+-*!?'\")(][}{#$<>&@%")

love.graphics.setFont(font)

dmg = require('dmg01')

dmg.current_palette = math.random(1,#dmg.palette)

speed = 25

function love.draw()
  dmg.pre_draw()
  for x = 0,1 do
    for y = 0,1 do
      love.graphics.draw(images[current_img].img,
        math.floor(offset*speed)%(dmg.w)-dmg.w*x,
        math.floor(offset*speed)%(dmg.h)-dmg.h*y)
    end
  end
  love.graphics.draw(bg,1,1,0,dmg.w-2,8+1)
  love.graphics.print(
    dmg.scale.."X "..
    string.upper(dmg.palette[dmg.current_palette].name).."["..
    string.upper(images[current_img].name).."]",
    2,2)
  if help then
    love.graphics.draw(bg,1,8+3,0,dmg.w-2,8*4+1)
    love.graphics.print(
      "LEFT/RIGHT: PALETTE\n"..
      "UP/DOWN: SCALE\n"..
      "SPACE: NEXT SAMPLE\n"..
      "RETURN: MOVE",1,8+4)
  end
  dmg.post_draw()
end

offset = 0
function love.update(dt)
  if move then
    offset = offset + dt
  end
end

function love.keypressed(key)
  if key == "h" then
    help = not help
  elseif key == "up" then
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
  elseif key == "return" then
    move = not move
  elseif key == " " then
    current_img = current_img + 1
    if current_img > #images then
      current_img = 1
    end
  end
end
