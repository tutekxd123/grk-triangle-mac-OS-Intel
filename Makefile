NAME=triangle
CXX=g++
SOURCES = $(wildcard *.cpp)
OBJECTS = $(SOURCES:.cpp=.o)
CFLAGS=-c -Wall -DDEBUG -g3 -fpermissive -std=c++11 -MMD
MACPORTS_INCLUDE = ""
MACPORTS_LIBS = ""


ifeq ($(OS),Windows_NT)
# -l:pelna forma biblioteki bez autodopasowywania lib*.a W zwiazku z czym trzeba to ustawic jawnie
#LIBS =-lglfw3 -l:glew32.dll -lopengl32 -lm -lglu32 -lgdi32
# W razie problemów z biblioteką glew wypróbować wiersz wyżej
LIBS =-lglfw3 -lglew32 -lopengl32 -lm -lglu32 -lgdi32
EXECUTABLE = $(NAME).exe
LDFLAGS=-Wl,--subsystem,windows
else ifeq ($(shell uname),Darwin)
CFLAGS += -DGL_SILENCE_DEPRECATION
#Lokalizacja MACPORTS
MACPORTS_INCLUDE = -I/opt/local/include 
MACPORTS_LIBS = -L/opt/local/lib
LIBS = $(shell pkg-config --cflags glfw3 glew)
EXECUTABLE = $(NAME)
LDFLAGS = $(shell pkg-config --libs --static glfw3 glew) -framework OpenGL -lm
else
LIBS = -lX11 -lglfw -lGL -lGLU -lGLEW -lm
EXECUTABLE = $(NAME)
endif

all: $(SOURCES) $(EXECUTABLE)

clean:
	rm -f $(EXECUTABLE) $(OBJECTS)
	rm -f $(SOURCES:%.cpp=%.d)

# compilation
.cpp.o:
	$(CXX) $(CFLAGS) $(MACPORTS_INCLUDE) $(MACPORTS_LIBS) $< -o $@ $(LIBS)

# linking
$(EXECUTABLE): $(OBJECTS)
	$(CXX) $(OBJECTS) -o $@ $(LDFLAGS) $(LIBS) $(MACPORTS_INCLUDE) $(MACPORTS_LIBS)

run: $(EXECUTABLE)
	./$(EXECUTABLE)
-include $(SOURCES:%.cpp=%.d)

zip: clean
	zip -r $(NAME) *.h *.cpp Makefile
ok: run
	find . -type f -not -name '*.zip' -not -name 'ok' -print0 | xargs -0 rm --
	ok2
