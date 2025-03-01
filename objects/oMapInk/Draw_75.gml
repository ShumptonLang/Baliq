for (var i = 0; i < palleteDims[0]; i++) {
	for (var j = 0; j < palleteDims[1]; j++) {
		draw_rectangle_color(inkBounds.x + ink_dims*j,inkBounds.y+ink_dims*i,inkBounds._x+ink_dims*j,inkBounds._y+ink_dims*i,
		colors[j*4+i],colors[j*4+i],colors[j*4+i],colors[j*4+i],0)
	}
}