# Makefile - create STL files from OpenSCAD source
# Andrew Ho (andrew@zeuscat.com)

ifeq ($(shell uname), Darwin)
  OPENSCAD = /Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
else
  OPENSCAD = openscad
endif

TARGETS = clip5_stand.stl

all: $(TARGETS)

clip5_stand.stl: clip5_stand.scad
	$(OPENSCAD) -o clip5_stand.stl clip5_stand.scad

clean:
	@rm -f $(TARGETS)
