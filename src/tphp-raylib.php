<?php

class Main
{
    public function main(): void
    {
        $c_width = c_int(800);
        $c_height = c_int(650);
        $c_title = c_str("TinyPHP raylib");
        C->InitWindow($c_width, $c_height, $c_title);
        C->SetTargetFPS(c_int(60));

        $window_should_close = php_float(C->WindowShouldClose());
        while (!$window_should_close) {
            C->BeginDrawing();
            C->ClearBackground(C->RAYWHITE);
            
            C->DrawText(c_str("raylib built with TPHP!"), c_int(260), c_int(30), c_int(28), C->DARKGRAY);

            C->EndDrawing();
        }
        C->CloseWindow();
    }
}
