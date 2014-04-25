dmg01 = {}

dmg01 = {}
dmg01.scale = 1
dmg01.scale_min = 1
dmg01.scale_max = 8
dmg01.w = 160
dmg01.h = 144

dmg01.palette = {}

-- Default color palette. Source:
-- http://en.wikipedia.org/wiki/List_of_video_game_console_palettes#Original_Game_Boy
dmg01.palette[1] = {
  name = "default",
  colors = {
    { 15/255, 56/255, 15/255},
    { 48/255, 98/255, 48/255},
    {139/255,172/255, 15/255},
    {155/255,188/255, 15/255}
  }
}

-- Hardcore color profiles. Source:
-- http://www.hardcoregaming101.net/gbdebate/gbcolours.htm

dmg01.palette[2] = {
  name = "dark_yellow",
  colors = {
    {33/255,32/255,16/255},
    {107/255,105/255,49/255},
    {181/255,174/255,74/255},
    {255/255,247/255,123/255}
  }
}

dmg01.palette[3] = {
  name = "light_yellow",
  colors = {
    {102/255,102/255,37/255},
    {148/255,148/255,64/255},
    {208/255,208/255,102/255},
    {255/255,255/255,148/255}
  }
}

dmg01.palette[4] = {
  name = "green",
  colors = {
    {8/255,56/255,8/255},
    {48/255,96/255,48/255},
    {136/255,168/255,8/255},
    {183/255,220/255,17/255}
  }
}

dmg01.palette[5] = {
  name = "greyscale",
  colors = {
    {56/255,56/255,56/255},
    {117/255,117/255,117/255},
    {178/255,178/255,178/255},
    {239/255,239/255,239/255}
  }
}

dmg01.palette[6] = {
  name = "stark_bw",
  colors = {
    {0/255,0/255,0/255},
    {117/255,117/255,117/255},
    {178/255,178/255,178/255},
    {255/255,255/255,255/255}
  }
}

dmg01.palette[7] = {
  name = "pocket",
  colors = {
    {108/255,108/255,78/255},
    {142/255,139/255,87/255},
    {195/255,196/255,165/255},
    {227/255,230/255,201/255}
  }
}

dmg01.current_palette = 1

function dmg01.pre_draw()
  love.graphics.setShader(dmg01.shader)
  dmg01.shader:send('COLOR_MASKS',unpack(dmg01.palette[dmg01.current_palette].colors))
  love.graphics.push()
  love.graphics.scale(dmg01.scale)
end

function dmg01.post_draw()
  love.graphics.pop()
end

function dmg01.setScale(self,tscale)
  self.scale = tscale
  love.window.setMode(self.w*self.scale,self.h*self.scale)
end

dmg01.shader = love.graphics.newShader [[

extern number value;

uniform vec3 COLOR_MASKS[ 4 ];

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords){
			vec4 pixel = Texel(texture, texture_coords);
			float avg = min(0.9999,max(0.0001,(pixel.r + pixel.g + pixel.b)/3));
			int index = int(avg*4);

			pixel.r = COLOR_MASKS[index][0];
			pixel.g = COLOR_MASKS[index][1];
			pixel.b = COLOR_MASKS[index][2];

			return  pixel;
		}
]]

return dmg01
