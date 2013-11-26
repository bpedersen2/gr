     GRDIR = /usr/local/gr
   DEFINES = -DGRDIR=\"$(GRDIR)\" -DXFT
  INCLUDES = -I.. -I/usr/local/include/mupdf
  CXXFLAGS = -g -Wall -fPIC $(DEFINES) $(INCLUDES)
    TARGET = movplugin.so
   SOFLAGS = -shared 
      LIBS = -lavdevice -lavformat -lavfilter -lavcodec -lswscale -lavutil -lmupdf -lmupdf-js-none -lfreetype -lbz2 -ljbig2dec -ljpeg -lopenjp2 -lz -lpthread
 EXTRALIBS =

.cxx.o:
	$(CXX) -c $(CXXFLAGS) $<

default:
	make -f movplugin.mak `uname`
Darwin:
	make -f movplugin.mak $(TARGET) EXTRALIBS="-framework VideoDecodeAcceleration -framework CoreVideo -framework CoreFoundation"

Linux:
	make -f movplugin.mak $(TARGET)

$(TARGET): movplugin.o font.o afm.o util.o vc.o dl.o malloc.o error.o io.o
	$(CXX) -o $@ $(SOFLAGS) $^ $(LIBS) $(EXTRALIBS)

font.o: ../font.c
	$(CXX) -c $(CXXFLAGS) -o $@ $<
afm.o: ../afm.c
	$(CXX) -c $(CXXFLAGS) -o $@ $<
util.o: ../util.c
	$(CXX) -c $(CXXFLAGS) -o $@ $<
vc.o: vc.c
	$(CXX) -c $(CXXFLAGS) -o $@ $<
dl.o: ../dl.c
	$(CXX) -c $(CXXFLAGS) -o $@ $<
malloc.o: ../malloc.c
	$(CXX) -c $(CXXFLAGS) -o $@ $<
error.o: ../error.c
	$(CXX) -c $(CXXFLAGS) -o $@ $<
io.o: ../io.c
	$(CXX) -c $(CXXFLAGS) -o $@ $<

movplugin.o: movplugin.cxx
	$(CXX) -c $(CXXFLAGS) -o $@ $<

clean:
	rm -f so_locations $(TARGET) *.o *.bak *~ *.tmp