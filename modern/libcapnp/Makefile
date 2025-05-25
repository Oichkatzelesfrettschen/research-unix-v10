CXX ?= clang++
CXXFLAGS ?= -Wall -Wextra -Werror -fPIC

LIB = libcapnp.a
OBJS = capnp.o

all: $(LIB)

$(LIB): $(OBJS)
	ar rcs $@ $(OBJS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(LIB) $(OBJS)
