// raylib + tcc 构建测试
// 演示：窗口、清屏、形状、文字、输入、纹理渲染
#include "raylib.h"

int main(void)
{
    const int screenWidth = 800;
    const int screenHeight = 450;

    InitWindow(screenWidth, screenHeight, "raylib - tcc build test");
    SetTargetFPS(60);

    // 旋转角度与移动位置
    float rotation = 0.0f;
    Vector2 ballPos = { screenWidth / 2.0f, screenHeight / 2.0f };
    const float ballRadius = 20.0f;
    const float speed = 200.0f;

    int frameCount = 0;

    while (!WindowShouldClose())
    {
        float dt = GetFrameTime();
        frameCount++;

        // 输入：方向键移动小球
        if (IsKeyDown(KEY_RIGHT)) ballPos.x += speed * dt;
        if (IsKeyDown(KEY_LEFT))  ballPos.x -= speed * dt;
        if (IsKeyDown(KEY_DOWN))  ballPos.y += speed * dt;
        if (IsKeyDown(KEY_UP))    ballPos.y -= speed * dt;

        // 边界限制
        if (ballPos.x < ballRadius) ballPos.x = ballRadius;
        if (ballPos.x > screenWidth - ballRadius) ballPos.x = screenWidth - ballRadius;
        if (ballPos.y < ballRadius) ballPos.y = ballRadius;
        if (ballPos.y > screenHeight - ballRadius) ballPos.y = screenHeight - ballRadius;

        rotation += 60.0f * dt;  // 每秒 60 度

        BeginDrawing();
        ClearBackground(RAYWHITE);

        // 标题
        DrawText("raylib built with TCC!", 260, 30, 28, DARKGRAY);
        DrawText("Use arrow keys to move the ball", 270, 70, 16, GRAY);

        // 旋转方块
        Rectangle rect = { screenWidth / 2.0f, 150, 80, 80 };
        DrawRectanglePro(rect, (Vector2){ 40, 40 }, rotation, MAROON);

        // 小球
        DrawCircleV(ballPos, ballRadius, SKYBLUE);
        DrawCircleLinesV(ballPos, ballRadius, BLUE);

        // FPS
        DrawText(TextFormat("FPS: %d", GetFPS()), 10, 10, 18, LIME);
        DrawText(TextFormat("Frame: %d", frameCount), 10, 32, 18, LIME);
        DrawText(TextFormat("Pos: (%.0f, %.0f)", ballPos.x, ballPos.y), 10, 54, 18, LIME);

        EndDrawing();
    }

    CloseWindow();
    return 0;
}
