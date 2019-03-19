include ../../env.mk

INC = -I../YOLOv3 -I../../dv-user-driver/include -I../common/include -I/usr/include/agg2 `freetype-config --cflags`
LIB = -L../../dv-user-driver -ldmpdv -L../common/lib -ldv700_util -lagg -lfreetype

CFLAGS = -pthread -std=c++11 $(OPT) -Wall -Werror -c $(INC)
LFLAGS = -pthread $(LIB)

DEPS = LaneDetection_gen.h LaneDetection_param.h ../YOLOv3/YOLOv3_gen.h ../YOLOv3/YOLOv3_param.h
OBJS = LaneDetection.o LaneDetection_gen.o LaneDetection_post.o ../YOLOv3/YOLOv3_gen.o ../YOLOv3/YOLOv3_post.o
TGT  = ../bin/LaneDetection

all: $(TGT)

$(TGT): $(OBJS)
	$(GPP) $^ -o $@ $(LFLAGS)

%.o: %.cpp $(DEPS) $(DEFS2)
	$(GPP) $(CFLAGS) -o $@ $<

clean:
	rm -f *.o $(TGT)