if wireframeDebug
	array_foreach(wireframes,draw_wireframe)
wireframes = []

if positionDebug {
	draw_text(mouse_x_gui-15,mouse_y_gui-30,string(mouse_x_gui) + "\n" + string(mouse_y_gui))	
}