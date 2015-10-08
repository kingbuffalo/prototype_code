#ifndef dynamic_font_h
#define dynamic_font_h
#include <stdlib.h>

/************************************************************************/
// 好像，只是管理一个个字符在一个bitmap  里的像管理数据库一样的管理方式
/************************************************************************/

struct dfont;

struct dfont_rect {
	int x;
	int y;
	int w;
	int h;
};

struct dfont * dfont_create(int width, int height);
void dfont_release(struct dfont *);
const struct dfont_rect * dfont_lookup(struct dfont *, int c, int font, int edge);
const struct dfont_rect * dfont_insert(struct dfont *, int c, int font, int width, int height, int edge);
void dfont_remove(struct dfont *, int c, int font, int edge);
void dfont_flush(struct dfont *);
void dfont_dump(struct dfont *); // for debug

size_t dfont_data_size(int width, int height);
void dfont_init(void* d, int width, int height);

#endif
