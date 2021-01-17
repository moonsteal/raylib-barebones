    project('raylib', 'c',
	license: 'Zlib'
)

add_project_arguments('-DPLATFORM_' + get_option('raylib_platform'),
	language: 'c'
)

glfw_proj = subproject('glfw')
glfw_dep = glfw_proj.get_variable('glfw_dep')
glfw_dependencies = glfw_proj.get_variable('dependencies')

raylib_sources = [
	'physac.h',
	'uwp_events.h',
	'rlgl.h',
	'raymath.h',
	'raudio.h',
	'config.h',
	'camera.h',
	'gestures.h',
	'rnet.h',
	'raylib.h',
	'external/dr_wav.h',
	'external/jar_mod.h',
	'external/dr_flac.h',
	'external/stb_rect_pack.h',
	'external/miniaudio.h',
	'external/sdefl.h',
	'external/dr_mp3.h',
	'external/glad.h',
	'external/stb_perlin.h',
	'external/cgltf.h',
	'external/stb_vorbis.h',
	'external/dirent.h',
	'external/sinfl.h',
	'external/tinyobj_loader_c.h',
	'external/msf_gif.h',
	'external/stb_image_resize.h',
	'external/stb_image_write.h',
	'external/stb_image.h',
	'external/jar_xm.h',
	'external/stb_truetype.h',
	'external/par_shapes.h',
	'utils.h',
	'easings.h',
	'rmem.h',
	'raudio.c',
	'shapes.c',
	'text.c',
	'textures.c',
	'models.c',
	'core.c',
	'utils.c'
]

raylib_dependencies = [glfw_dep, glfw_dependencies]

raylib_inc = include_directories('.')
raylib_lib = static_library('raylib', raylib_sources,
	dependencies: raylib_dependencies,
	include_directories: raylib_inc
)

raylib_dep = declare_dependency(
	include_directories: raylib_inc,
	link_with: raylib_lib
)
