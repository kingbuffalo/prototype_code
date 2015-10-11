#ifndef ejoy3d_log_h
#define ejoy3d_log_h

#include <stdio.h>

/*
log 用来一个f 又没见在函数中使用过
还有一个，如果有感叹号就不显示感叹号，这是为什么
*/

struct log {
	FILE *f;
};

void log_init(struct log *log, FILE *f);
void log_printf(struct log *log, const char * format, ...);

#endif
