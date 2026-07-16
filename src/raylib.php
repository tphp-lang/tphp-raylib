<?php

namespace raylib;

class Core
{
    public static function initWindow(int $width, int $height, string $title): void
    {
        C->InitWindow(c_int($width), c_int($height), c_str($title));
    }

    public static function setTargetFPS(int $fps): void
    {
        C->SetTargetFPS(c_int($fps));
    }

    public static function windowShouldClose(): bool
    {
        return C->WindowShouldClose() != 0;
    }

    public static function beginDrawing(): void
    {
        C->BeginDrawing();
    }

    public static function endDrawing(): void
    {
        C->EndDrawing();
    }

    public static function closeWindow(): void
    {
        C->CloseWindow();
    }

    public static function clearBackground(C.Color $color): void
    {
        C->ClearBackground($color);
    }

    public static function drawText(string $text, int $x, int $y, int $fontSize, C.Color $color): void
    {
        C->DrawText(c_str($text), c_int($x), c_int($y), c_int($fontSize), $color);
    }
}
