correctCombo = [4,3,4,2,1]

// Will be passed from master: currentCombo [5]
state = "sleeping"

initStates = switchStates

buttonPos =[[862,250],
		  [962,250],
		  [1062,250],
		  [1162,250],
		  [1262,250]]
buttons = array_create(0)

function updateStatus(buttonid, status){
	master.updateStatus("ignitionSwitchStates", {pid:buttonid,state:status})
}


