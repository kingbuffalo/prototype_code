#ifndef EJOY_2D_ARRAY_H
#define EJOY_2D_ARRAY_H

//��ƽ̨�ĺ�������  Ϊʲô��linuxƽ̨�¿���ֱ�Ӷ��壬����vsƽ̨��Ҫ�ö��ڴ棿
//������vs�����ڶ�����������ֵ�Ƚ�С

#if defined(_MSC_VER)
#	include <malloc.h>
#	define ARRAY(type, name, size) type* name = (type*)_alloca((size) * sizeof(type))
#else
#	define ARRAY(type, name, size) type name[size]
#endif

#endif
