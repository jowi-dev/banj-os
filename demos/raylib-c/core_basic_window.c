#include "raylib.h"
#include "math.h"
#include "printf.h"
#include <wchar.h>


// Define the initial cube position and size
#define CUBE_SIZE 1.0f
#define ORBIT_RADIUS 5.0f
#define CAMERA_DISTANCE 10.0f

// Function declarations
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
        // Clamp movement to spherical map
        float currSin =  sinf(cubeVelocity->y);
        float orbit;
        if (currSin > 0){
          orbit = fabs(1-sinf(cubeVelocity->y))*ORBIT_RADIUS;
        }
        else if(currSin < 0){
          orbit = fabs(1+sinf(cubeVelocity->y))*ORBIT_RADIUS;
        }
        else {
          orbit = ORBIT_RADIUS;
        }

        // Handle WASD movement
        if (IsKeyDown(KEY_W)) cubeVelocity->y += 0.1f;
        if (IsKeyDown(KEY_S)) cubeVelocity->y -= 0.1f;
        if (IsKeyDown(KEY_D)) cubeVelocity->x += 0.1f;
        if (IsKeyDown(KEY_A)) cubeVelocity->x -= 0.1f;

        // Update cube position
        cubePosition->x = sinf(cubeVelocity->x) * orbit;
        cubePosition->z = cosf(cubeVelocity->x) * orbit;
        // TODO - this movement is more or less busted until it can be clamped better
        cubePosition->y = sinf(cubeVelocity->y) * ORBIT_RADIUS;

}
