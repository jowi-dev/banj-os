///*******************************************************************************************
//*
//*   raylib [core] example - Basic window (adapted for HTML5 platform)
//*
//*   This example is prepared to compile for PLATFORM_WEB and PLATFORM_DESKTOP
//*   As you will notice, code structure is slightly different to the other examples...
//*   To compile it for PLATFORM_WEB just uncomment #define PLATFORM_WEB at beginning
//*
//*   This example has been created using raylib 1.3 (www.raylib.com)
//*   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
//*
//*   Copyright (c) 2015 Ramon Santamaria (@raysan5)
//*
//********************************************************************************************/
//
//#include "raylib.h"
//
//#if defined(PLATFORM_WEB)
//    #include <emscripten/emscripten.h>
//#endif
//
////----------------------------------------------------------------------------------
//// Global Variables Definition
////----------------------------------------------------------------------------------
//int screenWidth = 800;
//int screenHeight = 450;
//
////----------------------------------------------------------------------------------
//// Module Functions Declaration
////----------------------------------------------------------------------------------
//void UpdateDrawFrame(Rectangle*);     // Update and Draw one frame
//void MoveCubeWithWASD(Camera3D*, Vector3*, float);
//
////----------------------------------------------------------------------------------
//// Main Entry Point
////----------------------------------------------------------------------------------
//int main()
//{
//    // Initialization
//    // Why can't I see the cube when I render 
//    //
//    //--------------------------------------------------------------------------------------
//    InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
//    Rectangle square = {screenWidth/2, screenHeight/2, 50, 50}; // Square in the middle of the screen
//                                                                //
//    Camera3D camera = { 0 };
//    camera.position = (Vector3){ 0.0f, 10.0f, 10.0f };  // Camera position
//    camera.target = (Vector3){ 0.0f, 0.0f, 0.0f };      // Camera looking at point
//    camera.up = (Vector3){ 0.0f, 1.0f, 0.0f };          // Camera up vector (rotation towards target)
//    camera.fovy = 45.0f;                                // Camera field-of-view Y
//    camera.projection = CAMERA_PERSPECTIVE;                   // Camera mode type
//
//    Vector3 cubePosition = { 0.0f, 0.0f, 0.0f };
//
//#if defined(PLATFORM_WEB)
//    emscripten_set_main_loop(UpdateDrawFrame, 0, 1);
//#else
//    SetCameraMode(camera, CAMERA_FREE); // Set a free camera mode
//    SetTargetFPS(60);   // Set our game to run at 60 frames-per-second
//    //--------------------------------------------------------------------------------------
//
//    // Main game loop
//    while (!WindowShouldClose())    // Detect window close button or ESC key
//    {
//        //UpdateDrawFrame(&square);
//
//        MoveCubeWithWASD(&camera, &cubePosition, 0.05);
//        BeginDrawing();
//        //ClearBackground(RAYWHITE);
//        BeginMode3D(camera);
//        DrawCube(cubePosition, 2.0f, 2.0f, 2.0f, RED);
//        EndMode3D();
//        EndDrawing();
//    }
//#endif
//
//    // De-Initialization
//    //--------------------------------------------------------------------------------------
//    CloseWindow();        // Close window and OpenGL context
//    //--------------------------------------------------------------------------------------
//
//    return 0;
//}
//
////----------------------------------------------------------------------------------
//// Module Functions Definition
////----------------------------------------------------------------------------------
//void UpdateDrawFrame(Rectangle *square)
//{
//    // Update
//    //----------------------------------------------------------------------------------
//    // TODO: Update your variables here
//    //----------------------------------------------------------------------------------
//    if (IsKeyDown(KEY_W)) square->y -= 2.0f;
//    if (IsKeyDown(KEY_S)) square->y += 2.0f;
//    if (IsKeyDown(KEY_A)) square->x -= 2.0f;
//    if (IsKeyDown(KEY_D)) square->x += 2.0f;
//
//    // Draw
//    //----------------------------------------------------------------------------------
//
//    // Draw
//    BeginDrawing();
//
//    ClearBackground(RAYWHITE);
//    DrawRectangleRec(*square, RED); // Draw the square
//
//    EndDrawing();
//    //----------------------------------------------------------------------------------
//}
//
//void MoveCubeWithWASD(Camera3D *camera, Vector3 *cubePosition, float speed) {
//    // WASD controls
//    if (IsKeyDown(KEY_W)) cubePosition->z += speed;
//    if (IsKeyDown(KEY_S)) cubePosition->z -= speed;
//    if (IsKeyDown(KEY_A)) cubePosition->x -= speed;
//    if (IsKeyDown(KEY_D)) cubePosition->x += speed;
//
//    // Mouse controls for camera
//    int mouseX = GetMouseX();
//    int mouseY = GetMouseY();
//
//    // Update camera position to follow the cube
//    camera->position.x = cubePosition->x;
//    camera->position.y = cubePosition->y;
//    camera->position.z = cubePosition->z;
//
//    // Update camera target to look at the cube
//    camera->target.x = cubePosition->x;
//    camera->target.y = cubePosition->y;
//    camera->target.z = cubePosition->z;
//
//    // Update camera rotation based on mouse movement
//    camera->up.x += (mouseY - GetScreenHeight() / 2) * 0.01;
//    camera->up.y += (mouseX - GetScreenWidth() / 2) * 0.01;
//        
//
//    // Limit camera rotation
//    if (camera->up.x > 89.0f) camera->up.x = 89.0f;
//    if (camera->up.x < -89.0f) camera->up.x = -89.0f;
//
//
//}
//
//write me a raylib C function that renders a cube in the origin of a 3d space which orbits around a sphere. Have a camera which follows the cube in third person perspective. And make the cube respond to WASD movements
//It seems that you intended to share a block of code from raylib (a simple and easy-to-use library to enjoy videogames programming) that demonstrates how a camera is positioned relative to a cube, but I don't see the actual code snippet in your message.
//
//If you provide the code block, I would be able to explain how the camera is positioned relative to the cube. However, I can give you a general explanation of how a camera would typically be positioned in a 3D scene using raylib.
//
//In raylib, a camera is usually set up with a position, a target, an up vector, and a field of view. Here's a typical setup for a camera in a 3D scene:
//
//```c
//#include "raylib.h"
//
//int main(void)
//{
//    // Initialization
//    //--------------------------------------------------------------------------------------
//    const int screenWidth = 800;
//    const int screenHeight = 450;
//
//    InitWindow(screenWidth, screenHeight, "raylib [core] example - 3d mode");
//
//    // Define the camera to look into our 3d world
//    Camera3D camera = { 0 };
//    camera.position = (Vector3){ 10.0f, 10.0f, 10.0f }; // Camera position
//    camera.target = (Vector3){ 0.0f, 0.0f, 0.0f };      // Camera looking at point
//    camera.up = (Vector3){ 0.0f, 1.0f, 0.0f };          // Camera up vector (rotation towards target)
//    camera.fovy = 45.0f;                                // Camera field-of-view Y
//    camera.type = CAMERA_PERSPECTIVE;                   // Camera mode type
//
//    // A cube positioned at the origin of the scene
//    Vector3 cubePosition = { 0.0f, 0.0f, 0.0f };
//
//    SetCameraMode(camera, CAMERA_FREE); // Set a free camera mode
//
//    SetTargetFPS(60);                   // Set our game to run at 60 frames-per-second
//    //--------------------------------------------------------------------------------------
//
//    // Main game loop
//    while (!WindowShouldClose())        // Detect window close button or ESC key
//    {
//        // Update
//        //----------------------------------------------------------------------------------
//        UpdateCamera(&camera);          // Update camera
//        //----------------------------------------------------------------------------------
//
//        // Draw
//        //----------------------------------------------------------------------------------
//        BeginDrawing();
//
//            ClearBackground(RAYWHITE);
//
//            BeginMode3D(camera);
//
//                DrawCube(cubePosition, 2.0f, 2.0f, 2.0f, RED);
//                DrawCubeWires(cubePosition, 2.0f, 2.0f, 2.0f, MAROON);
//
//                DrawGrid(10, 1.0f);     // Draw a grid
//
//            EndMode3D();
//
//            DrawText("Welcome to the third dimension!", 10, 40, 20, DARKGRAY);
//
//        EndDrawing();
//        //----------------------------------------------------------------------------------
//    }
//
//    // De-Initialization
//    //--------------------------------------------------------------------------------------
//    CloseWindow();        // Close window and OpenGL context
//    //--------------------------------------------------------------------------------------
//
//    return 0;
//}
/*
```

In this code snippet, the camera is set up with a position at `(10.0f, 10.0f, 10.0f)`, which means it is located 10 units away from the origin on the X, Y, and Z axes. The camera's target is the origin `(0.0f, 0.0f, 0.0f)`, which means it is looking directly at the center of the scene where the cube is positioned. The up vector is set to `(0.0f, 1.0f, 0.0f)`, indicating that the 'up' direction in the world is along the positive Y-axis.

The cube is drawn at the origin of the scene, and the camera is positioned in such a way that it can see the cube in the center of its view. The camera's field of view and perspective settings determine how the cube and the rest of the scene are projected onto the screen.
*/
//To achieve this functionality with raylib, you'll need to have a good understanding of 3D transformations, camera manipulation, and user input. Below is a C function that utilizes raylib to render a cube orbiting around a sphere, with a third-person camera following the cube. The cube will also respond to WASD movements for basic control.
//
//Make sure you have raylib properly set up in your development environment before trying to run this code. You can find setup instructions on the raylib website (https://www.raylib.com/).
//
//Here's the code:

//```c
#include "raylib.h"
#include "math.h"
#include "printf.h"
#include <wchar.h>

// Define the initial cube position and size
#define CUBE_SIZE 1.0f
#define ORBIT_RADIUS 5.0f
#define CAMERA_DISTANCE 10.0f

// Function declarations
//void UpdateCamera(Camera *camera, Vector3 *cubePosition);
//void SetCameraMode(Camera camera, int  cameraType);

void moveCube(Vector3 *cubePosition, Vector3 *cubeVelocity, Vector3 *cubeRotation);

int main(void)
{
    // Initialization
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib - Orbiting Cube with Third-Person Camera");

    // Define the camera to look into our 3d world
    Camera camera = { 0 };
    camera.position = (Vector3){ 0.0f, 10.0f, 10.0f };
    camera.target = (Vector3){ 0.0f, 0.0f, 0.0f };
    camera.up = (Vector3){ 0.0f, 1.0f, 0.0f };
    camera.fovy = 45.0f;
    camera.projection = CAMERA_PERSPECTIVE;

    // Cube position and movement
    Vector3 cubePosition = { 0.0f, 0.0f, 0.0f };
    Vector3 cubeVelocity = { 0.0f, 0.0f, 0.0f };
    Vector3 cubeRotation = { 0.0f, 0.0f, 0.0f };
    //float orbitAngle = 0.0f;

    //SetCameraMode(camera, CAMERA_CUSTOM); // Set a custom camera mode

    SetTargetFPS(60); // Set our game to run at 60 frames-per-second

    // Main game loop
    while (!WindowShouldClose()) // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        moveCube(&cubePosition, &cubeVelocity, &cubeRotation);
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        BeginDrawing();

        ClearBackground(RAYWHITE);

        BeginMode3D(camera);

        DrawSphereWires((Vector3){ 0.0f, 0.0f, 0.0f }, ORBIT_RADIUS -1, 10, 10, LIGHTGRAY); // Draw the orbiting sphere
        DrawCube(cubePosition, CUBE_SIZE, CUBE_SIZE, CUBE_SIZE, RED); // Draw the orbiting cube

        EndMode3D();

        DrawText("Use WASD to move the cube", 10, 10, 20, DARKGRAY);

        EndDrawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    CloseWindow(); // Close window and OpenGL context
    //--------------------------------------------------------------------------------------

    return 0;
}

void moveCube(Vector3 *cubePosition, Vector3 *cubeVelocity, Vector3 *cubeRotation)
{
        float currSin =  sinf(cubeVelocity->y);
        float orbit;
        // Handle WASD movement
        if (currSin > 0){
          orbit = fabs(1-sinf(cubeVelocity->y))*ORBIT_RADIUS;
        }
        else if(currSin < 0){
          orbit = fabs(1+sinf(cubeVelocity->y))*ORBIT_RADIUS;
        }
        else {
          orbit = ORBIT_RADIUS;
        }
//        if (IsKeyDown(KEY_W) && currentZ < 0){
//          cubeVelocity->z += 0.1f;
//          cubeVelocity->y += 0.1f;
//        }
        if (IsKeyDown(KEY_W)) cubeVelocity->y += 0.1f;
        if (IsKeyDown(KEY_S)) cubeVelocity->y -= 0.1f;
        if (IsKeyDown(KEY_D)) cubeVelocity->x += 0.1f;
        if (IsKeyDown(KEY_A)) cubeVelocity->x -= 0.1f;

          printf("%f\n", sinf(cubeVelocity->z));
        // Update cube position
        cubePosition->x = sinf(cubeVelocity->x) * orbit;
        cubePosition->y = sinf(cubeVelocity->y) * ORBIT_RADIUS;
        cubePosition->z = cosf(cubeVelocity->x) * orbit;

     //   // Simulate orbit by rotating the cube around the origin
     //   orbitAngle += 0.01f; // Increase the orbit angle
     //   cubePosition->x = sinf(orbitAngle) * ORBIT_RADIUS;
     //   cubePosition->z = cosf(orbitAngle) * ORBIT_RADIUS;

        // Update camera position and target to follow the cube
        //UpdateCamera(&camera, &cubePosition);

        // Dampen the velocity for smooth stopping
//        cubeVelocity->x *= 0.9f;
//        cubeVelocity->z *= 0.9f;

}

//void UpdateCamera(Camera *camera, Vector3 *cubePosition)
//{
//    Vector3 offset = { -CAMERA_DISTANCE, CAMERA_DISTANCE, -CAMERA_DISTANCE };
//    //camera->position = Vector3Add(*cubePosition, offset);
//    camera->target = *cubePosition;
//}
//```

//This code sets up a window using raylib and renders a cube that orbits around a sphere. The camera follows the cube in a third-person perspective. The `UpdateCamera` function adjusts the camera's position based on the cube's current position, keeping a fixed distance from the cube.
//
//The cube's velocity is affected by the WASD keys, and the cube moves in the XZ plane. The orbit is simulated by rotating the cube's position around the origin using sine

//how to rotate a cube in raylib with c 
//how to rotate a cube in raylib with c 

