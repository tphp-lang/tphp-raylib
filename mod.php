<?php

// windows
#flag windows -DPLATFORM_DESKTOP_WIN32 
#flag windows -DGRAPHICS_API_OPENGL_33 
#flag windows -DUNICODE
#flag windows -lopengl32 -lgdi32 -lwinmm -luser32 -ladvapi32 -lole32 -lshlwapi
#flag windows -w
#flag windows __DIR__. "compat/user32_ext.def"
#flag windows -include "compat/tcc_compat.h"
#flag windows -I"compat"

// linux
#flag linux -lm -ldl -lpthread -lX11 -lXext -lXcursor -lXinerama -lXi -lXrandr -lGL
#flag linux -DPLATFORM_DESKTOP -DGRAPHICS_API_OPENGL_33
#flag linux __DIR__ . "raylib/src/rglfw.c"

// macos
#flag macos -lm -framework OpenGL -framework Cocoa -framework IOKit
#flag macos -DPLATFORM_DESKTOP -DGRAPHICS_API_OPENGL_33 -DGRAPHICS_API_OPENGL_21
#flag macos __DIR__ . "raylib/src/rglfw.c"

#flag -I"raylib/src/external"
#flag -I"include"
#flag __DIR__ . "raylib\src\rcore.c"
#flag __DIR__ . "raylib\src\rtextures.c"
#flag __DIR__ . "raylib\src\rtext.c"
#flag __DIR__ . "raylib\src\rmodels.c"
#flag __DIR__ . "raylib\src\raudio.c"
#flag __DIR__ . "raylib\src\rshapes.c"

#include windows "raylib_compat.h"
#include linux "raylib.h"
#include macos "raylib.h"