sprite_index = spr_start
scalex = 800
scaley = 600

view_width = surface_get_width(global.lidarSurf)
view_height = surface_get_height(global.lidarSurf)

master = ShipMaster




//Create Room Objects
//instance_create_depth(0,0,-5,oSonarButton,{master:oSLMaster})
//instance_create_depth(438,184,-5,oLeverAperture,{master:oSLMaster})
instance_create_depth(0,0,-5,oNavRotation,{master:oSLMaster})
instance_create_depth(0,0,-5,oLeverForward,{master:oSLMaster})
//instance_create_depth(0,0,-5,oSLPowerSwitch,{master:oSLMaster})
instance_create_depth(0,0,-5,oMapCP,{master:oSLMaster})
instance_create_depth(0,0,-5,oDistanceApproximator)


#region Sonar variables
lineNoise = sprite_get_texture(funkyNoise,0)
waitSonar = 0
scanning = false
waitSonarLength = 3
scanIter = 0
scanTotal = 100


pointMap = {}
chunkSize = 100

lastHistLength = 0
pointsToRender = array_create(0)

isGui = true
debugg_mode = 0

vBuff = vertex_create_buffer()
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color()
vertex_format_add_texcoord()
vertex_format_add_texcoord()
vertexFormat = vertex_format_end();
#endregion

#region Lidar variables
lastHistTotal = 0
hist = 0
waitLidar = 0
waitLidarLength = 3
#endregion

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_color()
vertex_format_add_texcoord()
format = vertex_format_end();

var _uv_data = sprite_get_uvs(sSonarHud, 0);
//var _umin = _uv_data[0], _vmin = _uv_data[1], _umax = _uv_data[2], _vmax = _uv_data[3];
var scale = 2;
var _umin = 0.25, _vmin = 0.25, _umax = 0.75, _vmax = 0.75;

sonarBuffer = vertex_create_buffer();
lidarBuffer = vertex_create_buffer();


#region Sonar Vertex Points
vertex_begin(sonarBuffer, format);
	
vertex_position_3d(sonarBuffer,   469,395, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, (_umax+_umin)/2, (_vmax+_vmin)/2);
vertex_position_3d(sonarBuffer,   146,201, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umin, _vmin);
vertex_position_3d(sonarBuffer, 495, 151, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, (_umax+_umin)/2, _vmin);
vertex_position_3d(sonarBuffer,   863, 160, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umax, _vmin);
vertex_position_3d(sonarBuffer, 898,376, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umax, (_vmax+_vmin)/2);
vertex_position_3d(sonarBuffer, 920,627, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umax, _vmax);
vertex_position_3d(sonarBuffer,   111,680, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umin, _vmax);
vertex_position_3d(sonarBuffer, 120,422, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umin, (_vmax+_vmin)/2);
vertex_position_3d(sonarBuffer,   146,201, 0); vertex_color(sonarBuffer, c_white, 1); vertex_texcoord(sonarBuffer, _umin, _vmin);

vertex_end(sonarBuffer); 
#endregion

#region Lidar Vertex Points
vertex_begin(lidarBuffer,format);

vertex_position_3d(lidarBuffer,   949,387, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umin, _vmin);
vertex_position_3d(lidarBuffer,   1156,355, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umax, _vmin);
vertex_position_3d(lidarBuffer, 1197, 556, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umax, _vmax);
vertex_position_3d(lidarBuffer,   975, 583, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umin, _vmax);
vertex_position_3d(lidarBuffer,   949,387, 0); vertex_color(lidarBuffer, c_white, 1); vertex_texcoord(lidarBuffer, _umax, _vmax);

vertex_end(lidarBuffer)
#endregion


function lidarTimerSuccess(){
	ShipMaster.shipStatus.sonarLidar.lidarScanning = 0
	ShipMaster.shipStatus.sonarLidar.lidarStatus = "idle"
	if instance_exists(oLeverAperture)
		oLeverAperture.status = "idle"
}

function sonarTimerSuccess(){
	ShipMaster.shipStatus.sonarLidar.sonarScanning = 0
}
	
function startUpScreen(currTime){
	if currTime > 3 {
		if global.sonarSurf != -1 {
			surface_set_target(global.sonarSurf)
			draw_clear_alpha(c_black,0)
			var screen = startup
			draw_sprite_ext(screen,0,sprite_get_width(screen)/2,sprite_get_height(screen)/2 - 50,1.2,1.3,0,c_white,0.5)
			surface_reset_target()
		}
	}
}


function startUpSL(){
	ShipMaster.shipStatus.sonarLidar.sonarLidarSwitchEngaged = 1
}
	
function updateLidar(){
	surface_set_target(global.lidarSurf)
	
	//draw_clear_alpha($010101,0)

	draw_sprite_general(spr_start,0,ShipMaster.posx-oSLMaster.view_width/2,ShipMaster.posy-oSLMaster.view_height/2,oSLMaster.view_width,oSLMaster.view_height,0,0,1,1,0,c_white,c_white,c_white,c_white,1)
	//draw_sprite_part(spr_start,0,sin(current_time/1000)*100,0,view_width*2,view_height*2,0,0)
		
	draw_circle(view_width/2,view_height/2,10,0)
	draw_line_width(view_width/2,view_height/2,view_width/2+lengthdir_x(1000,ShipMaster.angle+90),view_height/2+lengthdir_y(1000,ShipMaster.angle+90),10)
	
	draw_line_width(view_width/2,view_height/2,view_width/2+lengthdir_x(400,ShipMaster.angle+oDistanceApproximator.hand1.a+90),view_height/2+lengthdir_y(1000,ShipMaster.angle+oDistanceApproximator.hand1.a+90),5)
	draw_line_width(view_width/2,view_height/2,view_width/2+lengthdir_x(400,ShipMaster.angle+oDistanceApproximator.hand2.a+90),view_height/2+lengthdir_y(1000,ShipMaster.angle+oDistanceApproximator.hand2.a+90),5)

	surface_reset_target()
}

function updateStatus(statusid,status){
	switch(statusid){
		case "SLPowerSwitch":
		

		if !master.getValue("sonarLidar", "sonarLidarSwitchEngaged") and master.getValue("digestive", "running") {
			audio_play_sound(puterStartup,1,0)
			ShipMaster.startTimer(ShipMaster.shipStatus.sonarLidar.lidarScanTime, 10, startUpSL, startUpScreen)
		}
		if master.getValue("sonarLidar", "sonarLidarSwitchEngaged")
		with(master){
			shipStatus.sonarLidar.sonarLidarSwitchEngaged = 0	
		}
		break;
		
		case "sonarEngaged" :
		
		if !master.getValue("sonarLidar", "sonarScanning") and master.getValue("digestive", "running") and master.getValue("sonarLidar", "sonarLidarSwitchEngaged")
			grabPoints()
		
		if master.getValue("digestive", "running") and master.getValue("sonarLidar", "sonarLidarSwitchEngaged"){
			with (master){
					shipStatus.sonarLidar.sonarScanning = status	
				}	
		}
		if status == 1 {
				ShipMaster.startTimer(ShipMaster.shipStatus.sonarLidar.sonarScanTime, 3, sonarTimerSuccess)
			}
		break;
		
		case "leverForward":
		if master.getValue("digestive", "running")
		with (master){
				shipStatus.sonarLidar.forwardLever = status	
			}	
		break;
		
		case "rotationWheel":
		if master.getValue("digestive", "running")
		with (master){
				shipStatus.sonarLidar.rotationWheel = status	
			}	
		break;
		
		case "lidarEngaged" :
		
		
		if master.getValue("digestive", "running") and master.getValue("sonarLidar", "sonarLidarSwitchEngaged"){
			with (master){
				shipStatus.sonarLidar.lidarScanning = status	
			}
			if status == 1 {
				ShipMaster.startTimer(ShipMaster.shipStatus.sonarLidar.lidarScanTime, 3, lidarTimerSuccess)
				updateLidar()
			}
		} else {
				oLeverAperture.status = "idle"
		}
		break;
		
	}
}

function grabPoints(){
	var testTotal = 0
	for (var v = 0; v < 1;v++){
	while(scanIter < scanTotal){
		var _scandeg = (scanIter/scanTotal) * 360


		var fidelity = random_range(-9,10)
		var _x = lengthdir_x(10+fidelity/10,_scandeg+fidelity)
		var _y = lengthdir_y(10+fidelity/10,_scandeg+fidelity)

		
		var px = ShipMaster.posx
		var py = ShipMaster.posy
		for(var i=0; i<400;i++){
				px -= _x
				py -= _y
				
				
	
				var rayPoint = getPixelFromBuffer(global.currMapBuffer,px,py)

				//print(getPixelFromBuffer(buffer,px,py).a, getPixelFromBuffer(buffer,px,py).a == 255)
				//print(surface_getpixel(surf, px, py))
				//print(colour_get_red(surface_getpixel(surf, px, py)))
				//if (__a) print("Buffer Transfer Successful!  ", __a);
		
				//print("Trialing dummy point at: ",px, ", ", py)
		
				//White
		
				if(rayPoint.r){
					//print("Successful buffer query at: ",px, ", ", py)
					var tempX = px
					var tempY = py

					
					px = tempX
					py = tempY

					var wallPoint = {
						x : px,
						y : py,
						noiseX : random(255),
						noiseY : random(255),
						material: rayPoint
					}
					
					var storePoint = string(
					int64(wallPoint.x - (wallPoint.x%chunkSize))) 
					+ "." + 
					string(
					int64(wallPoint.y - (wallPoint.y%chunkSize)))
					
					var hash = variable_get_hash(storePoint)
					
					if !variable_struct_exists(pointMap,storePoint){
						
						struct_set_from_hash(pointMap,hash,array_create(0))

					}
					
					var cell = struct_get_from_hash(pointMap,hash)
					
					if  (array_length(cell) > 20){
						array_pop(cell)
						
					} 
					array_insert(cell,0,wallPoint)
					testTotal ++
					
					
					
					break;
				}

		
		}
		scanIter ++
	}
	scanIter = 0
	
	print(testTotal)		
}

}





