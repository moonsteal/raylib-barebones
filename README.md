# raylib-barebones

Stripped-down and auto-generated [Raylib](https://github.com/raysan5/raylib) build for [Meson](https://mesonbuild.com) projects.

## Usage:

1. Create a _meson.build_ file like this:
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
    
2. Create the [subprojects .wrap files](examples/core_basic_window/subprojects)
    - [`subprojects/glfw.wrap`](subprojects/glfw.wrap)
    - [`subprojects/raylib.wrap`](raylib.wrap)

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