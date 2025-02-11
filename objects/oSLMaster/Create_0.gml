sprite_index = spr_start
scalex = 800
scaley = 600

view_width = camera_get_view_width(view_camera[0])
view_height =camera_get_view_height(view_camera[0])

master = ShipMaster

#region Map Buffer Creation
if global.currMapBuffer  == -1 {
//Convert map into a surface
	var surf = surface_create(4000,4000)//
	surface_set_target(surf)
	draw_sprite(sprite_index,0,0,0)
	surface_reset_target()


	global.currMapBuffer = buffer_create(4000 * 4000*4, buffer_fast, 1);
	buffer_get_surface(global.currMapBuffer, surf, 0);
}

if global.noiseBuffer == -1 {
	var surf = surface_create(256,256)//
	surface_set_target(surf)
	draw_sprite(funkyNoise,0,0,0)
	surface_reset_target()


	global.noiseBuffer = buffer_create(256 * 256*4, buffer_fast, 1);
	buffer_get_surface(global.noiseBuffer, surf, 0);
}
#endregion


//Create Aux Surfaces

if global.lidarSurf == -1
	global.lidarSurf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))
if global.sonarSurf == -1
	global.sonarSurf = surface_create(camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]))

//Create Room Objects
instance_create_depth(0,0,-5,oSonarButton,{master:oSLMaster})
instance_create_depth(438,184,-5,oLeverAperture,{master:oSLMaster})
instance_create_depth(0,0,-5,oNavRotation,{master:oSLMaster})
instance_create_depth(0,0,-5,oLeverForward,{master:oSLMaster})
instance_create_depth(0,0,-5,oSLPowerSwitch,{master:oSLMaster})


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
			draw_sprite_ext(startup,0,360,270,1.2,1.3,0,c_white,0.5)
			surface_reset_target()
		}
	}
}
	
#region Ambience Audio Service
function updateAmbience(event) {
	if fmod_studio_event_instance_get_playback_state(event) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(event)
	if ShipMaster.shipStatus.sonarLidar.sonarLidarSwitchEngaged and fmod_studio_event_instance_get_paused(event) == true
		fmod_studio_event_instance_set_paused(event,0)
	var distanceToWind = point_distance(ShipMaster.posx,ShipMaster.posy,2000,624)/1400
	var distanceToHall = point_distance(ShipMaster.posx,ShipMaster.posy,2400,3500)/2800
	if distanceToWind < distanceToHall{
		fmod_studio_event_instance_set_parameter_by_name(event,"Location", 0)
		fmod_studio_event_instance_set_parameter_by_name(event,"dtOutside", distanceToWind)
	}else {
		fmod_studio_event_instance_set_parameter_by_name(event,"Location", 1)
		fmod_studio_event_instance_set_parameter_by_name(event,"dtOutside", distanceToWind)
}
			
}

function killAmbience(event) {
	
		if !(ShipMaster.shipStatus.digestive.running and ShipMaster.shipStatus.sonarLidar.sonarLidarSwitchEngaged){
			fmod_studio_event_instance_set_paused(event,1)
			return true
		}
}
#endregion
#region Wheel Audio Service
function updateWheelSound(event) {
	if fmod_studio_event_instance_get_playback_state(event) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(event)
	if instance_exists(oNavRotation)
		var rot = oNavRotation.rotv
	else
		var rot = ShipMaster.shipStatus.sonarLidar.rotationWheel
	if abs(rot/10) > 0.3 and fmod_studio_event_instance_get_playback_state(AudioService.eventGroanInst) == FMOD_STUDIO_PLAYBACK_STATE.STOPPED
		fmod_studio_event_instance_start(AudioService.eventGroanInst)

	fmod_studio_system_set_parameter_by_name("rotationVelocity",rot/10)
	
			
}

function killWheel(event) {
	
		return false
}
AudioService.play(AudioService.eventRotWheelInst,updateWheelSound, killWheel)
#endregion

function startUpSL(){
	ShipMaster.shipStatus.sonarLidar.sonarLidarSwitchEngaged = 1
	AudioService.play(AudioService.eventBasilicaAmbience,updateAmbience,killAmbience)
}
	
function updateLidar(){
	surface_set_target(global.lidarSurf)
	
	draw_clear_alpha($010101,0)
	draw_sprite_general(spr_start,0,ShipMaster.posx-oSLMaster.view_width/2,ShipMaster.posy-oSLMaster.view_height/2,oSLMaster.view_width,oSLMaster.view_height,0,0,1,1,0,c_green,c_green,c_green,c_green,1)
		
	

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





