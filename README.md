# OpenGL Triangle on MacOS (INTEL)

This is a modified sample project from [Aleksander Denisiuk's Computer Graphics course](http://users.pja.edu.pl/~denisjuk/gk) ([original source code](http://users.pja.edu.pl/~denisjuk/gk/wyklady/g10-podstawyOpenGL.zip)).

The original project has a Makefile setup for Windows with MinGW and Linux, but not for MacOS.

Developing OpenGL applications on modern MacOS versions is a bit tricky because it's an API deprecated in favor of a newer one called Metal. OpenGL runs as a compatibility layer on top of Metal and it's limited to version 4.1.

# Changes in 2026/2027 For Intel-based Macbooks
Now Intel-based macbooks are obsolete. Homebrew isn't supported and latest version of macOS is 26, however macports is still supported.

## Prerequisites

Install Xcode (from the App Store) and setup the default toolchain:
```sh
xcode-select --install
```
If Xcode and its toolchain were correctly installed, several frameworks for working with OpenGL should now be available.

If there are compilation errors about missing standard libraries (e.g. `cstddef.h`), try reinstalling Xcode and its toolchain.

With [Macports][https://guide.macports.org/#installing.macports], install glfw, glew and pkg-config:
```sh
sudo macports install glfw glew pkg-config
```

Additional dependencies - not needed for this example, but may be required for other examples/assignments:
```sh
sudo macports install jpeg libpng argtable
```

## Build & Run

```sh
make run
```

You'll see `glDebugMessageCallback not available` in the console. It's an API introduced in OpenGL 4.3 and we're using OpenGL 4.1.

You should also see `OpenGL initialized: OpenGL version: 4.1 Metal - xx.x GLSL version: 4.10` in the console.

## Troubleshooting

If for some reason glfw from homebrew doesn't work, try compiling it from source:
```sh
sudo macports uninstall glfw

git clone https://github.com/glfw/glfw.git && \
cd glfw && \
cmake -DCMAKE_OSX_ARCHITECTURES=arm64 . && \
make && \
sudo make install
```

## Resources

- https://carette.xyz/posts/opengl_and_cpp_on_m1_mac/
- https://github.com/k0pernicus/opengl-explorer/tree/0e311828fb34b272809432254307e8561e951335
- https://www.glfw.org/docs/latest/build_guide.html#build_link_pkgconfig
- https://github.com/s27459-pj/grk-triangle
