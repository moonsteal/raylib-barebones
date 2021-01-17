# raylib-barebones

Stripped-down and auto-generated [Raylib](https://github.com/raysan5/raylib) build for [Meson](https://mesonbuild.com) projects.

## Usage:

1. Create a [meson.build](https://github.com/moonsteal/raylib-example/blob/main/meson.build) file like this:
    ``` python
    project('myproject', 'c',
      version : '1.0.0',
      license: 'MIT'
    )

    raylib_proj = subproject('raylib')
    raylib_dep = raylib_proj.get_variable('raylib_dep')

    executable('myproject', 'myproject.c',
      dependencies: [raylib_dep]
    )
    ```
An example can be found [here](https://github.com/moonsteal/raylib-example)


2. Create the [subprojects .wrap files](examples/core_basic_window/subprojects)
    - [`subprojects/glfw.wrap`](https://github.com/moonsteal/raylib-example/blob/main/subprojects/glfw.wrap)
    - [`subprojects/raylib.wrap`](https://github.com/moonsteal/raylib-example/blob/main/subprojects/raylib.wrap)

3. Build the project
    ``` bash
    meson build
    cd build
    ninja
    ```

## Re-Generation:
To regenerate, you would need:
- Lua5.1+ 
- Latest Meson + Ninja
- GIT
- A posix-compatible OS/Shell

Run the following:
``` bash
chmod +x get.lua
./get.lua
```

## About:
This repo is a fork of [@RobLoach](https://github.com/RobLoach/raylib-meson)'s fantastic [raylib-meson](https://github.com/RobLoach/raylib-meson), I had to upload it as a separate repository because git freaked up and ended making .git/objects/pack over _70MB_ and that defeats the whole purpose of this fork
