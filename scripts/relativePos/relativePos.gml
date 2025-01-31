function relativePos(kingAngle, oldX,oldY, initPos){
var _c = dcos(kingAngle)
var _s = dsin(kingAngle)

var _x = oldX + initPos[0]*_c + _s * initPos[1]
var _y = oldY + initPos[1]*_c - _s * initPos[0]

return [_x,_y]
}