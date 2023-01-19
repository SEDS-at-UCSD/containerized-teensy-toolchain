export ARDUINO_CORE := $(abspath core/teensy4)

# Use these lines for Teensy 4.1
export MCU = IMXRT1062
export MCU_LD := $(abspath $(ARDUINO_CORE)/imxrt1062_t41.ld)
export MCU_DEF = ARDUINO_TEENSY41

# configurable options
export OPTIONS = -DF_CPU=600000000 -DUSB_SERIAL -DLAYOUT_US_ENGLISH -DUSING_MAKEFILE

# USB Type configuration:
#   -DUSB_SERIAL
#   -DUSB_DUAL_SERIAL
#   -DUSB_TRIPLE_SERIAL
#   -DUSB_KEYBOARDONLY
#   -DUSB_TOUCHSCREEN
#   -DUSB_HID_TOUCHSCREEN
#   -DUSB_HID
#   -DUSB_SERIAL_HID
#   -DUSB_MIDI
#   -DUSB_MIDI4
#   -DUSB_MIDI16
#   -DUSB_MIDI_SERIAL
#   -DUSB_MIDI4_SERIAL
#   -DUSB_MIDI16_SERIAL
#   -DUSB_AUDIO
#   -DUSB_MIDI_AUDIO_SERIAL
#   -DUSB_MIDI16_AUDIO_SERIAL
#   -DUSB_MTPDISK
#   -DUSB_RAWHID
#   -DUSB_FLIGHTSIM
#   -DUSB_FLIGHTSIM_JOYSTICK

# options needed by many Arduino libraries to configure for Teensy model
export OPTIONS += -D__$(MCU)__ -DARDUINO=10813 -DTEENSYDUINO=154 -D$(MCU_DEF)

# for Cortex M7 with single & double precision FPU
export CPUOPTIONS = -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-d16 -mthumb

# path location for the arm-none-eabi compiler
export COMPILERPATH = $(abspath tools/arm/bin)

#************************************************************************
# Settings below this point usually do not need to be edited
#************************************************************************

# CPPFLAGS = compiler options for C and C++
export CPPFLAGS = -Wall -g -O2 $(CPUOPTIONS) -MMD $(OPTIONS) -I. -I/root/project/core/teensy4 -ffunction-sections -fdata-sections

# compiler options for C++ only
export CXXFLAGS = -std=gnu++14 -felide-constructors -fno-exceptions -fpermissive -fno-rtti -Wno-error=narrowing

# compiler options for C only
export CFLAGS =

# linker options
#export LDFLAGS = -Os -Wl,--gc-sections,--relax $(SPECS) $(CPUOPTIONS) -T$(MCU_LD)

# additional libraries to link
export LIBS = -larm_cortexM7lfsp_math -lm -lstdc++

# names for the compiler programs
export CC = $(COMPILERPATH)/arm-none-eabi-gcc
export CXX = $(COMPILERPATH)/arm-none-eabi-g++
export OBJCOPY = $(COMPILERPATH)/arm-none-eabi-objcopy
export SIZE = $(COMPILERPATH)/arm-none-eabi-size


# Below is the actual build rules ====================

.PHONY: guard all src $(ARDUINO_CORE)

# preventing from running make manually
guard:
	@printf "[Makefile Warning] Do not run make manually. Use ttc.sh\n"
	@printf "   usage: ./ttc.sh build\n"

# This is the root target
all: src

# All .o files built by GNU make's default implicit rules
# When compiled with implicit rule, Make automatically points to CC and CXXFLAGS
# Refer to: https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html

# This is recursive rules that invokes make in each modules
src $(ARDUINO_CORE):
	$(MAKE) --directory=$@

# This rule defines the dependency between modules
src: $(ARDUINO_CORE)

clean:
	for d in app $(ARDUINO_CORE); do $(MAKE) --directory=$$d clean; done
