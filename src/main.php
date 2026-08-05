<?php

use raylib\Core;

class Main
{
    public function main(): void
    {
        Core::initWindow(800, 600, "TinyPHP raylib");
        Core::setTargetFPS(60);
        while (!Core::windowShouldClose()) {
            Core::beginDrawing();
            Core::clearBackground(C->RAYWHITE);
            Core::drawText("raylib built with TPHP!", 260, 30, 28, C->DARKGRAY);
            Core::endDrawing();
        }
        Core::closeWindow();
    }
}
