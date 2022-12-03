#指定编译器
CC = g++

#找出当前目录下，所有的源文件（以.cpp结尾）
SRCS := $(shell find ./* -type f | grep '\.cc' | grep -v 'main\.cc')
$(warning SRCS is ${SRCS})

#确定cpp源文件对应的目标文件
OBJS := $(patsubst %.cc, %.o, $(filter %.cc, $(SRCS)))
$(warning OBJS is ${OBJS})

#编译选项
CFLAGS = -g -O2 -Wall -Werror -Wno-unused -ldl -fPIC -std=c++11
$(warning CFLAGS is ${CFLAGS})

#找出当前目录下所有的头文件

INCLUDE = -I ./src
$(warning INCLUDE is ${INCLUDE})

SRC_MAIN = main.cc
OBJ_MAIN = ${SRC_MAIN:%.cpp=%.o}
EXE_MAIN = main

target: ${EXE_MAIN}

$(EXE_MAIN): $(OBJ_MAIN) $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS) $(INCLUDE)

clean:
	rm -f ${OBJS} ${OBJ_MAIN} ${EXE_MAIN}

%.o: %.cpp
	${CC} ${CFLAGS} ${INCLUDE} -c $< -o $@
