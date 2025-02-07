x = 460
y = 725

xOff = 35
yOff = 65


aMatLights = [[x,y,0],[x+xOff,y,0]]
bMatLights = [[x,y+yOff*1,0],[x+xOff,y+yOff*1,0]]
cMatLights = [[x,y+yOff*2,0],[x+xOff,y+yOff*2,0]]
dMatLights = [[x,y+yOff*3,0],[x+xOff,y+yOff*3,0]]


targetValues = [0.2,0.9,0.4,0.3]
targetFuzz = 0.1

aMatSwitch = instance_create_depth(975,475,-1,oSwitchSampler,{_end:[1200,475]})
bMatSwitch = instance_create_depth(975,475+yOff,-1,oSwitchSampler,{_end:[1200,475+yOff]})
cMatSwitch = instance_create_depth(975,475+yOff*2,-1,oSwitchSampler,{_end:[1200,475+yOff*2]})
dMatSwitch = instance_create_depth(975,475+yOff*3,-1,oSwitchSampler,{_end:[1200,475+yOff*3]})

switches = [aMatSwitch,bMatSwitch,cMatSwitch,dMatSwitch]




