displaySurface = -1


function paleShaderConf() {
		shader_set_uniform_f(shader_get_uniform(paleShader, "u_time"), current_time / 1000);
}