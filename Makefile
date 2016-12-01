# makefile for pack library for Lua

# change these to reflect your Lua installation
LUA=/home/ryuuzaki/Downloads/LuaJIT-2.0.4
#LUA= /tmp/LuaJIT-2.0.4
LUAINC=$(LUA)/src

# probably no need to change anything below here
CFLAGS= $(INCS) $(WARN) -O2 $G
WARN=-ansi -pedantic -Wall -fpic
INCS=-I$(LUAINC)

MYNAME=ltspack
MYLIB=$(MYNAME)
T=$(MYLIB).so
OBJS=$(MYLIB).o

all: $T

o: $(MYLIB).o

so: $T

$T: $(OBJS)
	$(CC) -o $@ -shared $(OBJS)

clean:
	rm -f $(OBJS) $T core core.* a.out

doc:
	@echo "$(MYNAME) library:"
	@fgrep '/**' $(MYLIB).c | cut -f2 -d/ | tr -d '*' | sort | column

# distribution

FTP=$(HOME)/public/ftp/lua/5.1
D=lua-$(MYNAME)
A=$(D).tar.gz
TOTAR=Makefile,README,$(MYLIB).c,test.lua

tar: clean
	tar cvzf $A -C .. $D/{$(TOTAR)}

distr: tar
	touch -r $A .stamp
	mv $A $(FTP)

diff: clean
	tar zxf $(FTP)/$A
	diff $D .

# eof
