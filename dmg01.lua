dmg01 = {}

dmg01 = {}
dmg01.scale = 1
dmg01.scale_min = 1
dmg01.scale_max = 8
dmg01.w = 160
dmg01.h = 144

function dmg01.pre_draw()
  love.graphics.setPixelEffect(dmg01.shader)
  love.graphics.push()
  love.graphics.scale(dmg01.scale)
end

function dmg01.post_draw()
  love.graphics.pop()
end

function dmg01.setScale(self,tscale)
  self.scale = tscale
  love.graphics.setMode(self.w*self.scale,self.h*self.scale)
end

dmg01.shader = love.graphics.newPixelEffect [[

extern number value;

// http://www.hardcoregaming101.net/gbdebate/gbcolours.htm

// http://en.wikipedia.org/wiki/List_of_video_game_console_palettes#Original_Game_Boy
uniform vec3 COLOR_MASKS[ 4 ] = { vec3( 0.058823529, 0.21960784, 0.019607843),
                                  vec3( 0.18823529 , 0.38431373, 0.18823529 ),
                                  vec3( 0.54509804 , 0.6745098 , 0.058823529),
                                  vec3( 0.60784314 , 0.7372549 , 0.058823529) };

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords){
			vec4 pixel = Texel(texture, texture_coords);
			float avg = max(0, ((pixel.r + pixel.g + pixel.b)/3)+value/10);
			int index = int(avg*4);

			pixel.r = COLOR_MASKS[index][0];
			pixel.g = COLOR_MASKS[index][1];
			pixel.b = COLOR_MASKS[index][2];

			return  pixel;
		}
]]

return dmg01
