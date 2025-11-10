# RaylibWrapper [![Build Status](https://github.com/imohag9/RaylibWrapper.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/imohag9/RaylibWrapper.jl/actions/workflows/CI.yml?query=branch%3Amain) [![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)


`RaylibWrapper.jl` provides comprehensive, low-level Julia bindings for the popular [Raylib](https://www.raylib.com/) library, **version 5.5**. Raylib is a simple and easy-to-use library designed to make video game programming enjoyable and accessible. This wrapper allows you to leverage the full power and simplicity of Raylib directly within the Julia programming language.

## Features

*   **Comprehensive API Coverage:** Wraps a vast portion of the Raylib C API, giving you access to core functions, 2D/3D graphics, audio processing, text rendering, input handling, and much more.
*   **Zero-Overhead Bindings:** Provides a highly efficient wrapper that calls directly into the C library with minimal overhead, ensuring great performance.
*   **Cross-Platform:** Works seamlessly on 64-bit Windows, macOS, and Linux.
*   **Hassle-Free Installation:** Uses Julia's built-in `LazyArtifacts` system to automatically download and manage the correct Raylib binaries for your platform. No manual installation of Raylib is required!


## Installation

You can install `RaylibWrapper.jl` directly from the Julia General registry. Open the Julia REPL, press `]` to enter Pkg mode, and run:

```julia
pkg> add RaylibWrapper
```

## Quick Start: Create Your First Window

Here is a simple example to get you started. This code initializes a window, draws text on the screen, and runs a main loop until the user closes the window.

```julia
using RaylibWrapper

# Define window dimensions
const SCREEN_WIDTH = 800
const SCREEN_HEIGHT = 450

function main()
    # Initialize the window and set the target framerate
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Hello Raylib from Julia!")
    SetTargetFPS(60)

    # --- Main Game Loop ---
    # The loop continues until the user presses the ESC key or closes the window
    while !WindowShouldClose()
        # --- Drawing Phase ---
        BeginDrawing()

        # Clear the background to a specific color (Raylib's RAYWHITE)
        ClearBackground(RAYWHITE)

        # Draw the text in the center of the screen
        DrawText("Congrats! You created your first window in Julia!", 140, 200, 20, MAROON)

        # End the drawing phase
        EndDrawing()
    end

    # --- De-Initialization ---
    # Close the window and release all resources
    CloseWindow()
end

# Run the main function to start the application
main()
```

This simple example demonstrates the basic structure of a Raylib application in Julia. For more advanced examples, please check the official Raylib examples,or the examples implemented in this package as the function names and logic translate directly using this wrapper.

## Documentation

The official documentation provides a complete list of all wrapped functions and types.
*   **[Raylib Cheatsheet](https://www.raylib.com/cheatsheet/cheatsheet.html)** — Documentation for the latest released version.

*   **[Raylib Examples](https://github.com/imohag9/RaylibExamples.jl)** — Port for some of the examples from the original project in pure Julia.



## Contributing

Contributions are welcome and greatly appreciated! If you find a bug, have a feature request, or would like to contribute to the code, please feel free to open an issue or pull request on the GitHub repository.

## Acknowledgements

This package would not be possible without the amazing work of **Ramon Santamaria** [@raysan5](https://github.com/raysan5) and all the contributors to the [Raylib](https://github.com/raysan5/raylib) project.

## License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.