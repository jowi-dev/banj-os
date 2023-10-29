/*******************************************************************************************
*
*   raylib [core] example - Basic window (adapted for HTML5 platform)
*
*   This example is prepared to compile for PLATFORM_WEB and PLATFORM_DESKTOP
*   As you will notice, code structure is slightly different to the other examples...
*   To compile it for PLATFORM_WEB just uncomment #define PLATFORM_WEB at beginning
*
*   This example has been created using raylib 1.3 (www.raylib.com)
*   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
*
*   Copyright (c) 2015 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

#include "raylib.h"

#if defined(PLATFORM_WEB)
    #include <emscripten/emscripten.h>
#endif

//----------------------------------------------------------------------------------
// Global Variables Definition
//----------------------------------------------------------------------------------
int screenWidth = 800;
int screenHeight = 450;

//----------------------------------------------------------------------------------
// Module Functions Declaration
//----------------------------------------------------------------------------------
void UpdateDrawFrame(Rectangle*);     // Update and Draw one frame

//----------------------------------------------------------------------------------
// Main Entry Point
//----------------------------------------------------------------------------------
int main()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
    Rectangle square = {screenWidth/2, screenHeight/2, 50, 50}; // Square in the middle of the screen

#if defined(PLATFORM_WEB)
    emscripten_set_main_loop(UpdateDrawFrame, 0, 1);
#else
    SetTargetFPS(60);   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!WindowShouldClose())    // Detect window close button or ESC key
    {
        UpdateDrawFrame(&square);
    }
#endif

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}

//----------------------------------------------------------------------------------
// Module Functions Definition
//----------------------------------------------------------------------------------
void UpdateDrawFrame(Rectangle *square)
{
    // Update
    //----------------------------------------------------------------------------------
    // TODO: Update your variables here
    //----------------------------------------------------------------------------------
    if (IsKeyDown(KEY_W)) square->y -= 2.0f;
    if (IsKeyDown(KEY_S)) square->y += 2.0f;
    if (IsKeyDown(KEY_A)) square->x -= 2.0f;
    if (IsKeyDown(KEY_D)) square->x += 2.0f;

    // Draw
    //----------------------------------------------------------------------------------

    // Draw
    BeginDrawing();

    ClearBackground(RAYWHITE);
    DrawRectangleRec(*square, RED); // Draw the square

    EndDrawing();
    //----------------------------------------------------------------------------------
}
