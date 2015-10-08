#ifndef EJOY_2D_ARRAY_H
#define EJOY_2D_ARRAY_H

//跨平台的函数定义  为什么在linux平台下可以直接定义，而在vs平台下要用堆内存？
//估计是vs函数内定义数组的最大值比较小

#if defined(_MSC_VER)
#	include <malloc.h>
#	define ARRAY(type, name, size) type* name = (type*)_alloca((size) * sizeof(type))
#else
#	define ARRAY(type, name, size) type name[size]
#endif

#endif
