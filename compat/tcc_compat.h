#ifndef TCC_COMPAT_H
#define TCC_COMPAT_H

// tcc winapi 补充定义：tcc 自带 winapi 精简，部分类型/常量/宏缺失
// 本文件由 Makefile 用 -include 强制包含到每个编译单元前

// ── 解决 tcc parser 不支持 __stdcall 函数指针 typedef 语法 ──
// tcc 0.9.28 parser 无法解析 typedef void (__stdcall *FPTR)(...)
// 在 x86_64 上 __stdcall 是无意义的（只有一个调用约定），可安全置空
// 在 Linux/Mac 上 __stdcall 本就不使用，置空无副作用
#if defined(__x86_64__) || defined(__amd64__) || defined(_M_X64) || defined(__LP64__) || !defined(_WIN32)
#undef __stdcall
#define __stdcall
#endif

// ── MinGW _mingw.h 中的类型别名（tcc 无 _mingw.h） ──
#ifndef __LONG32
#define __LONG32 long
#endif

// ── winuser.h 缺失的 MAPVK_* 常量 ──
#ifndef MAPVK_VK_TO_VSC
#define MAPVK_VK_TO_VSC 0
#endif
#ifndef MAPVK_VSC_TO_VK
#define MAPVK_VSC_TO_VK 1
#endif
#ifndef MAPVK_VK_TO_CHAR
#define MAPVK_VK_TO_CHAR 2
#endif
#ifndef MAPVK_VSC_TO_VK_EX
#define MAPVK_VSC_TO_VK_EX 3
#endif

// ── winuser.h 缺失的 DPI 相关 Windows 消息常量 ──
#ifndef WM_DPICHANGED
#define WM_DPICHANGED 0x02E3
#endif
#ifndef WM_GETDPISCALEDSIZE
#define WM_GETDPISCALEDSIZE 0x02E4
#endif

// HDROP 由 MinGW shellapi.h 提供，无需在此定义

// ── 跳过 MinGW intrin-impl.h 中的 GCC inline assembly ──
// MinGW 默认 #define __has_builtin(x) 0，导致 inline asm 被启用
// tcc 不支持这些 GCC inline asm，故定义为 1 跳过所有 inline 实现
#ifndef __has_builtin
#define __has_builtin(x) 1
#endif

// ── 禁用 miniaudio SSE2/AVX intrinsics ──
// tcc 不支持 SSE/AVX intrinsics，需禁用以避免编译错误
#define MA_NO_SSE2
#define MA_NO_AVX
#define MA_NO_AVX2

#endif // TCC_COMPAT_H
