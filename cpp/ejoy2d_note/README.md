
我自己阅读此代码的一些笔记
---------------------
整个引擎的结构
所有直接调用opengl 的在 render.h里
其它就是分布在各个 数据管理中
----
step1:
	理解example
	将所有的lua接口 都尝试一次。
	抄一遍引擎
step2:
	嵌入到qt中，开工

========
This repository was moved to https://github.com/ejoy/ejoy2d .
========

EJOY 2D
=======

Make
====

For Windows and msvc

* msvc\make.bat
* ej2d examples/ex01.lua to test

For Windows and mingw32

* Install glew 1.9
* make or make mingw
* ej2d examples/ex01.lua to test

For Linux ,

* Install glew 1.9
* Install freetype 2
* make or make linux
* ./ej2d examples/ex01.lua to test

For Mac OS ,

* Install glfw3
* Install freetype 2
* make or make macosx
* ./ej2d examples/ex01.lua to test

API
====

https://github.com/cloudwu/ejoy2d/blob/master/doc/apicn.md  (work in process , in Chinese)

Question?
=======

Please read http://blog.codingnow.com/2013/12/ejoy2d.html first (In Chinese) 

Chinese API document 

Put your questions in [Issues](https://github.com/cloudwu/ejoy2d/issues) .
