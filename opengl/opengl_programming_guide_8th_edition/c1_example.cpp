// Test.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"
#include <GL/glew.h>
#include <gl/glut.h>
#include <string.h>
#include <stdlib.h>

GLuint vao;
GLuint bufId;
const GLuint vPosition = 0;
const GLuint VERT_NUM = 6;

bool compileShader(GLuint * shader, GLenum type, const GLchar* source)
{
	GLint status;
	if (!source) return false;

	const GLchar *sources[] = {source};
	*shader = glCreateShader(type);
	glShaderSource(*shader, 1, sources, nullptr);
	glCompileShader(*shader);

	glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);

	if (! status)
	{
		GLsizei logLen;
		glGetShaderiv(*shader,GL_INFO_LOG_LENGTH,&logLen);
		char *logSzStr = new char[logLen+1];
		GLsizei realLogLen;
		glGetShaderInfoLog(*shader,logLen,&realLogLen,logSzStr);
		printf("compiler Error! source code: \n%s",source);
		printf("--------------------------\nError info: \n%s",logSzStr);
		delete[] logSzStr;
	}
	return (status == GL_TRUE);
}

GLuint initWithByteArrays(const GLchar* vShaderByteArray, const GLchar* fShaderByteArray){
	GLuint _program = glCreateProgram();
	GLuint verShader=0;
	GLuint fragShader = 0;

	if (vShaderByteArray) {
		if (!compileShader(&verShader, GL_VERTEX_SHADER, vShaderByteArray)) {
			return 0;
		}
	}
	if (fShaderByteArray) {
		if (!compileShader(&fragShader, GL_FRAGMENT_SHADER, fShaderByteArray)) {
			return 0;
		}
	}
	if (verShader) {
		glAttachShader(_program, verShader);
	}
	if (fragShader) {
		glAttachShader(_program, fragShader);
	}
	return _program;
}

void init(void){
	//�ⲿ�ִ���,��Ϊ�� �� display��ʱ��, glDrawArrays ��ʹ�õ�������  begin
	glGenVertexArrays(1,&vao);//����
	glBindVertexArray(vao);//����Ϊ��ǰ���õĶ��� ����Ĳ���Ҳ�ͽ���Դ˶���
	GLfloat verArr[][2]={ {0,0},{0.5,0},{0.5,0.5},{ 0.2,0.8} };
	GLuint buf;
	glGenBuffers(1,&buf);//���ݱ�����buf Ҫbuf 
	glBindBuffer(GL_ARRAY_BUFFER,buf);
	glBufferData(GL_ARRAY_BUFFER,sizeof(verArr),verArr,GL_STATIC_DRAW);
	
	//�ⲿ�ִ���,��Ϊ�� �� display��ʱ��, glDrawArrays ��ʹ�õ�������  end

	//�ⲿ�ִ�����Ϊ������shader�Լ�����shader���ݽ�������� begin
	const char *vert="in vec4 vPos;\n\
void main(){\n\
gl_Position = vPos;\n\
}";
	const char *fragment="out vec4 fColor;\n\
void main(){\n\
fColor = vec4(0,0,1,1);\n\
}";
	GLuint program = initWithByteArrays(vert,fragment);
	glLinkProgram(program);
	glUseProgram(program);
	glVertexAttribPointer(0,2,GL_FLOAT,GL_FALSE,0,0);
	glEnableVertexAttribArray(0);
	//�ⲿ�ִ�����Ϊ������shader�Լ�����shader���ݽ�������� end
}

void display(void){
	glClear(GL_COLOR_BUFFER_BIT);
	glBindVertexArray(vao);
	glDrawArrays(GL_TRIANGLES,0,3);
	glDrawArrays(GL_LINE_LOOP,3,2);
	//glBindVertexArray(0);
	glFlush();
}

int _tmain(int argc, _TCHAR* argv[])
{
	glutInit(&argc,(char**)argv);
	glutInitDisplayMode(GLUT_RGB|GLUT_SINGLE);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(1024,700);
	glutCreateWindow("opengl");
	if ( glewInit() ){
		return -1;
	}
	init();
	glutDisplayFunc(&display);
	glutMainLoop();
	return 0;
}

