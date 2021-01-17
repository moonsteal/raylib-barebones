#!/usr/bin/lua
require "luash"  --https://github.com/zserge/luash

function string.firstWord(s) 
	local frst 
	for word in s:gmatch("%S+") do 
		frst = word
		break
	end
	return frst
end

print("Checking if necessary programs are installed:")
local lacks_something 
for _, v in ipairs({"meson", "git", "ninja", "cc"}) do 
	local rt = tostring(whereis(v))
	if #rt == (#v + 1) then  -- Sorry for this terrible hack :(
		print(("> %s:%snot found!"):format(v, (" "):rep(9-#v)))
		lacks_something = true
	else
		print(("> %s:%sfound in '%s'!"):format(v, (" "):rep(9-#v), rt:sub(#v+3):firstWord()))
	end
end
print("Check complete.\n")
assert(not lacks_something, "Some programs needed to generate the files were not found.\nThe program has to be stopped :(\n")

print("Removing all the original files.")
for _, v in ipairs({"meson.build", "*.h", "*.c", "external/", "build/"}) do
    rm("-rf "..v)
end
print("Done\n")

print("Cloning Raylib repository from github.com/raysan5/raylib:")
print(git("clone https://github.com/raysan5/raylib"))
print("Done.\n")

print("Copying necessary files:")
for v in io.popen('find raylib/src/ -maxdepth 1 -type f -name "*.h"'):lines() do
	print(("> Copying '%s'"):format(v))
	cp(v .. " .")
end

for v in io.popen('find raylib/src/ -maxdepth 1 -type f -name "*.c"'):lines() do
	print(("> Copying '%s'"):format(v))
	cp(v .. " .")
end
cp("-r raylib/src/external/ .")
print("> Externals copied into place")
print("Done.\n")

print("Removing Raylib repository.")
rm("-rf raylib/")
print("Done.\n")

print("Generating meson.build:")
local source = ""
for v in io.popen('find . -maxdepth 5 -type f -name "*.h"'):lines() do
	if v:find("glfw") == nil then
		source = source .. ("\t'%s',\n"):format(v:sub(3))
	end
end
for v in io.popen('find . -maxdepth 5 -type f -name "*.c"'):lines() do
	if v:find("glfw") == nil then
		source = source .. ("\t'%s',\n"):format(v:sub(3))
	end
end
source = source:sub(1, #source-2)


local meson = io.open("meson.build", "w+")
meson:write(([[
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
%s
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
]]):format(source))
meson:close()
