<?php

// windows
#flag windows -DPLATFORM_DESKTOP_WIN32 
#flag windows -DGRAPHICS_API_OPENGL_33 
#flag windows -DUNICODE
#flag windows -lopengl32 -lgdi32 -lwinmm -luser32 -ladvapi32 -lole32 -lshlwapi
#flag windows -w
#flag windows __DIR__. "/compat/user32_ext.def"
#flag windows -include __DIR__. "compat/tcc_compat.h"
#flag windows -I__DIR__. "compat"

#flag -I__DIR__. "raylib/src/external"
#flag -I__DIR__. "include"

#include windows "raylib_compat.h"
#include linux "raylib.h"
#include macos "raylib.h"


// .\mod.php .\src\tphp-raylib.php .\raylib\src\rcore.c .\raylib\src\rshapes.c .\raylib\src\rtextures.c .\raylib\src\rtext.c .\raylib\src\rmodels.c .\raylib\src\raudio.c