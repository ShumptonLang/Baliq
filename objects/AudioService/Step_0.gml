for (var i = 0; i < array_length(activeServices); i++){
	var service = array_shift(activeServices)
	
	if !playStep(service)
		array_push(activeServices,service)
}