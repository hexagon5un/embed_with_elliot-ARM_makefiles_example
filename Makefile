## Cross-compilation commands 
CC      = arm-none-eabi-gcc
LD      = arm-none-eabi-gcc
AR      = arm-none-eabi-ar
AS      = arm-none-eabi-as
OBJCOPY = arm-none-eabi-objcopy
OBJDUMP = arm-none-eabi-objdump
SIZE    = arm-none-eabi-size

# our code
OBJS  = main.o
# startup files and anything else
OBJS += handlers.o startup.o

## Platform and optimization options
CFLAGS += -c -fno-common -Os -g -mcpu=cortex-m4 -mthumb
CFLAGS += -Wall -ffunction-sections -fdata-sections -fno-builtin
CFLAGS += -Wno-unused-function -ffreestanding
LFLAGS  = -Tstm32f4.ld -nostartfiles -Wl,--gc-sections

## Locate the main libraries
CMSIS     = /usr/local/lib/CMSIS
HAL       = /usr/local/lib/STM32F4xx_HAL_Driver
HAL_SRC   = $(HAL)/Src
CMSIS_SRC = $(CMSIS)/Device/ST/STM32F4xx/Source/Templates

## Drivers/library includes
INC     = -I$(CMSIS)/Include/ -I$(HAL)/Inc
INC    += -I$(CMSIS)/Device/ST/STM32F4xx/Include/ -I./
CFLAGS += $(INC)

# drivers/lib sources -> objects -> local object files 
VPATH                = $(HAL_SRC):$(CMSIS_SRC)

CORE_OBJ_SRC         = $(wildcard $(HAL_SRC)/*.c)
CORE_OBJ_SRC        += $(wildcard $(CMSIS_SRC)/*.c)

CORE_LIB_OBJS        = $(CORE_OBJ_SRC:.c=.o)
CORE_LOCAL_LIB_OBJS  = $(notdir $(CORE_LIB_OBJS))

## Rules
all: size flash

core.a: $(CORE_OBJ_SRC)
	$(MAKE) $(CORE_LOCAL_LIB_OBJS)
	$(AR) rcs core.a $(CORE_LOCAL_LIB_OBJS)
	rm -f $(CORE_LOCAL_LIB_OBJS)

main.elf: $(OBJS) core.a stm32f4.ld
	$(LD) $(LFLAGS) -o main.elf $(OBJS) core.a 

%.bin: %.elf
	$(OBJCOPY) --strip-unneeded -O binary $< $@

## Convenience targets

flash: main.bin
	st-flash --reset write $< 0x8000000 

size: main.elf
	$(SIZE) $< 

clean:
	-rm -f $(OBJS) main.lst main.elf main.hex main.map main.bin main.list

distclean: clean
	-rm -f *.o core.a $(CORE_LIB_OBJS) $(CORE_LOCAL_LIB_OBJS) 

.PHONY: all flash size clean distclean
