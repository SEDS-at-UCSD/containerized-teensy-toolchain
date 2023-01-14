# automatically create lists of the sources and objects
C_FILES := $(wildcard *.c)
CPP_FILES := $(wildcard *.cpp)
OBJS := $(C_FILES:.c=.o) $(CPP_FILES:.cpp=.o)

# the actual makefile rules (all .o files built by GNU make's default implicit rules)
arduino: $(OBJS)
	@printf "Compiling Arduino Library\n"

clean:
	rm -f *.o *.d
