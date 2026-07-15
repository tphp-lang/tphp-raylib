<?php

// windows
#flag windows -DPLATFORM_DESKTOP_WIN32 
#flag windows -DGRAPHICS_API_OPENGL_33 
#flag windows -DUNICODE
#flag windows -lopengl32 -lgdi32 -lwinmm -luser32 -ladvapi32 -lole32 -lshlwapi
#flag windows -w
#flag windows __DIR__."/compat/user32_ext.def"
#include windows __DIR__."\compat\tcc_compat.h"

#flag -I__DIR__."compat"
#flag -I__DIR__."raylib-6.0\src\external"
#flag -I__DIR__."include"