
/// @description d3d - set orthographic
/// @param xx       x of tl corner
/// @param yy       y of tl corner
/// @param ww       w of view
/// @param hh       h of view
/// @param angle   rotation angle of the projection
function d3d_set_projection_ortho(xx,yy,ww,hh,angle){




var mV = matrix_build_lookat( xx+ww/2, yy+hh/2, -16000,
                             xx+ww/2, yy+hh/2, 0,
                            dsin(-angle), dcos(-angle), 0 );
var mP = matrix_build_projection_ortho( ww, hh, 1, 32000 );

//camera_set_view_mat( global.__d3dCamera, mV );
//camera_set_proj_mat( global.__d3dCamera, mP );
//camera_apply( global.__d3dCamera );
camera_set_view_mat( camera_get_active(), mV );
camera_set_proj_mat( camera_get_active(), mP );
camera_apply( camera_get_active() );
}