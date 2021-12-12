PROJECT  := $(shell basename $(CURDIR))

BIN_DIR  := bin
SRC_DIR  := src
OBJ_DIR  := obj

TARGET   := $(BIN_DIR)/$(PROJECT).nes

CFGFILE  := $(wildcard ./*.cfg)
CFILES   := $(wildcard $(SRC_DIR)/*.c)
SFILES   := $(wildcard $(SRC_DIR)/*.s) $(wildcard $(SRC_DIR)/*.asm)
LIBS     := $(wildcard $(CURDIR)/lib/*.a) $(wildcard $(CURDIR)/lib/*.lib) nes.lib

OBJS     := \
	$(foreach file, $(CFILES), $(OBJ_DIR)/$(basename $(notdir $(file))).o) \
	$(foreach file, $(SFILES), $(OBJ_DIR)/$(basename $(notdir $(file))).o)

DEPENDS  := $(wildcard $(OBJ_DIR)/*.dep)

AS_INCDIR := $(CC65_HOME)/asminc
CC_INCDIR := $(CC65_HOME)/include
LD_LIBDIR := $(CC65_HOME)/lib

ASFLAGS  := -t none -I $(AS_INCDIR) -I $(CURDIR)/include
CFLAGS   := -t none -Or -Os -I $(CC_INCDIR) -I $(CURDIR)/include
LDFLAGS  := --config $(CFGFILE) -L $(LD_LIBDIR) -L $(CURDIR)/lib

CC       := cl65
AS       := cl65
LD       := ld65
RM       := rm -rf
MKDIR    := mkdir

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) --create-dep $@.dep -c -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	$(AS) $(ASFLAGS) --create-dep $@.dep -c -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	$(AS) $(ASFLAGS) --create-dep $@.dep -c -o $@ $<

.PHONY: all
all: init $(TARGET)

.PHONY: clean
clean:
	- $(RM) $(BIN_DIR)
	- $(RM) $(OBJ_DIR)

.PHONY: init
init:
	@$(if $(shell ls | grep $(BIN_DIR)) , , $(MKDIR) $(BIN_DIR))
	@$(if $(shell ls | grep $(OBJ_DIR)) , , $(MKDIR) $(OBJ_DIR))

.PHONY: run
run: all
	$(VM_PATH) $(TARGET)

$(TARGET): $(OBJS)
	@ echo Create $@
	$(LD) $(LDFLAGS) -m $@.map -o $@ --obj $(OBJS) --lib $(LIBS)
	@ echo Done.

-include $(DEPENDS)
