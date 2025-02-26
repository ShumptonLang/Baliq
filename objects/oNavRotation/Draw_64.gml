draw_sprite_ext(Sprite9,0, x,y,1,1,rot,c_white,1)

var aVal = ((proxyAngle+ShipMaster.angle+90)%360)-180
draw_text_transformed(x-20,y-200,string(aVal),2,2,0)