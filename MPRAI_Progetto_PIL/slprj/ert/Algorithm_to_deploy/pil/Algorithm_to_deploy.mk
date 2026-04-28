###########################################################################
## Makefile generated for component 'Algorithm_to_deploy'. 
## 
## Makefile     : Algorithm_to_deploy.mk
## Generated on : Thu Apr 23 12:27:23 2026
## Final product: ./Algorithm_to_deploy.elf
## Product type : executable
## 
###########################################################################

###########################################################################
## MACROS
###########################################################################

# Macro Descriptions:
# PRODUCT_NAME            Name of the system to build
# MAKEFILE                Name of this makefile
# MODELREF_LINK_RSPFILE   Linker command listing model reference link objects
# COMPILER_COMMAND_FILE   Compiler command listing model reference header paths
# CMD_FILE                Command file

PRODUCT_NAME              = Algorithm_to_deploy
MAKEFILE                  = Algorithm_to_deploy.mk
MATLAB_ROOT               = C:/PROGRA~1/MATLAB/R2025b
MATLAB_BIN                = C:/PROGRA~1/MATLAB/R2025b/bin
MATLAB_ARCH_BIN           = $(MATLAB_BIN)/win64
START_DIR                 = C:/Users/robyd/Desktop/UNIVPM/MANUTE~1/Progetto/MPRAI_~1
SOLVER                    = 
SOLVER_OBJ                = 
CLASSIC_INTERFACE         = 0
TGT_FCN_LIB               = ISO_C
MODEL_HAS_DYNAMICALLY_LOADED_SFCNS = 0
RELATIVE_PATH_TO_ANCHOR   = ../../../..
MODELREF_LINK_RSPFILE     = Algorithm_to_deploy_ref.rsp
COMPILER_COMMAND_FILE     = Algorithm_to_deploy_comp.rsp
CMD_FILE                  = Algorithm_to_deploy.rsp
C_STANDARD_OPTS           = 
CPP_STANDARD_OPTS         = 

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          GNU Tools for ARM Embedded Processors
# Supported Version(s):    
# ToolchainInfo Version:   2025b
# Specification Revision:  1.0
# 
#-------------------------------------------
# Macros assumed to be defined elsewhere
#-------------------------------------------

# TARGET_LOAD_CMD_ARGS
# TARGET_LOAD_CMD
# MW_GNU_ARM_TOOLS_PATH
# FDATASECTIONS_FLG

#-----------
# MACROS
#-----------

LIBGCC                    = ${shell $(MW_GNU_ARM_TOOLS_PATH)/arm-none-eabi-gcc ${CFLAGS} -print-libgcc-file-name}
LIBC                      = ${shell $(MW_GNU_ARM_TOOLS_PATH)/arm-none-eabi-gcc ${CFLAGS} -print-file-name=libc.a}
LIBM                      = ${shell $(MW_GNU_ARM_TOOLS_PATH)/arm-none-eabi-gcc ${CFLAGS} -print-file-name=libm.a}
PRODUCT_NAME_WITHOUT_EXTN = $(basename $(PRODUCT))
PRODUCT_BIN               = $(PRODUCT_NAME_WITHOUT_EXTN).bin
PRODUCT_HEX               = $(PRODUCT_NAME_WITHOUT_EXTN).hex
CPFLAGS                   = -O binary
SHELL                     = %SystemRoot%/system32/cmd.exe

TOOLCHAIN_SRCS = 
TOOLCHAIN_INCS = 
TOOLCHAIN_LIBS = -lm

#------------------------
# BUILD TOOL COMMANDS
#------------------------

# Assembler: GNU ARM Assembler
AS_PATH = $(MW_GNU_ARM_TOOLS_PATH)
AS = "$(AS_PATH)/arm-none-eabi-gcc"

# C Compiler: GNU ARM C Compiler
CC_PATH = $(MW_GNU_ARM_TOOLS_PATH)
CC = "$(CC_PATH)/arm-none-eabi-gcc"

# Linker: GNU ARM Linker
LD_PATH = $(MW_GNU_ARM_TOOLS_PATH)
LD = "$(LD_PATH)/arm-none-eabi-g++"

# C++ Compiler: GNU ARM C++ Compiler
CPP_PATH = $(MW_GNU_ARM_TOOLS_PATH)
CPP = "$(CPP_PATH)/arm-none-eabi-g++"

# C++ Linker: GNU ARM C++ Linker
CPP_LD_PATH = $(MW_GNU_ARM_TOOLS_PATH)
CPP_LD = "$(CPP_LD_PATH)/arm-none-eabi-g++"

# Archiver: GNU ARM Archiver
AR_PATH = $(MW_GNU_ARM_TOOLS_PATH)
AR = "$(AR_PATH)/arm-none-eabi-ar"

# MEX Tool: MEX Tool
MEX_PATH = $(MATLAB_ARCH_BIN)
MEX = "$(MEX_PATH)/mex"

# Binary Converter: Binary Converter
OBJCOPYPATH = $(MW_GNU_ARM_TOOLS_PATH)
OBJCOPY = "$(OBJCOPYPATH)/arm-none-eabi-objcopy"

# Hex Converter: Hex Converter
OBJCOPYPATH = $(MW_GNU_ARM_TOOLS_PATH)
OBJCOPY = "$(OBJCOPYPATH)/arm-none-eabi-objcopy"

# Executable Size: Executable Size
EXESIZEPATH = $(MW_GNU_ARM_TOOLS_PATH)
EXESIZE = "$(EXESIZEPATH)/arm-none-eabi-size"

# Download: Download
DOWNLOAD =

# Execute: Execute
EXECUTE = $(PRODUCT)

# Builder: GMAKE Utility
MAKE_PATH = %MATLAB%\bin\win64
MAKE = "$(MAKE_PATH)/gmake"


#-------------------------
# Directives/Utilities
#-------------------------

ASDEBUG             = -g
AS_OUTPUT_FLAG      = -o
CDEBUG              = -g
C_OUTPUT_FLAG       = -o
LDDEBUG             = -g
OUTPUT_FLAG         = -o
CPPDEBUG            = -g
CPP_OUTPUT_FLAG     = -o
CPPLDDEBUG          = -g
OUTPUT_FLAG         = -o
ARDEBUG             =
STATICLIB_OUTPUT_FLAG =
MEX_DEBUG           = -g
RM                  = @del /f/q
ECHO                = @echo
MV                  = @move
RUN                 =

#----------------------------------------
# "Faster Builds" Build Configuration
#----------------------------------------

ARFLAGS              = ruvs
ASFLAGS              = -MMD -MP -MF"$(@:%.s.o=%.s.dep)" -MT"$@"  \
                       -Wall \
                       -x assembler-with-cpp \
                       $(ASFLAGS_ADDITIONAL) \
                       $(DEFINES) \
                       $(INCLUDES) \
                       -c
OBJCOPYFLAGS_BIN     = -O binary $(PRODUCT) $(PRODUCT_BIN)
CFLAGS               = $(FDATASECTIONS_FLG) \
                       -Wall \
                       -c \
                       -MMD -MP -MF"$(@:%.c.o=%.c.dep)" -MT"$@"  \
                       -O0
CPPFLAGS             = -std=gnu++14 \
                       -fno-rtti \
                       -fno-exceptions \
                       $(FDATASECTIONS_FLG) \
                       -Wall \
                       -c \
                       -MMD -MP -MF"$(@:%.cpp.o=%.cpp.dep)" -MT"$@"  \
                       -O0
CPP_LDFLAGS          = -Wl,--gc-sections \
                       -Wl,-Map="$(PRODUCT_NAME).map"
CPP_SHAREDLIB_LDFLAGS  =
DOWNLOAD_FLAGS       =
EXESIZE_FLAGS        = $(PRODUCT)
EXECUTE_FLAGS        =
OBJCOPYFLAGS_HEX     = -O ihex $(PRODUCT) $(PRODUCT_HEX)
LDFLAGS              = -Wl,--gc-sections \
                       -Wl,-Map="$(PRODUCT_NAME).map"
MEX_CPPFLAGS         =
MEX_CPPLDFLAGS       =
MEX_CFLAGS           =
MEX_LDFLAGS          =
MAKE_FLAGS           = -f $(MAKEFILE)
SHAREDLIB_LDFLAGS    =



###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = ./Algorithm_to_deploy.elf
PRODUCT_TYPE = "executable"
BUILD_TYPE = "Top-Level Standalone Executable"

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = 

INCLUDES = $(INCLUDES_BUILDINFO)

###########################################################################
## DEFINES
###########################################################################

DEFINES_ = -D__MW_TARGET_USE_HARDWARE_RESOURCES_H__ -DUSE_FULL_LL_DRIVER -DUSE_HAL_DRIVER -DSTM32H723xx -DMW_TIMEBASESOURCE=TIM5 -DMW_CONNECTIVITY_UART=USART3_BASE -DMW_CONNECTIVITY_RX_DMA=DMA1 -DMW_USART3_RX_DMA_STREAM=0 -DMW_USART3_RX_DMA_ENABLED=DMA1_Stream0_IRQHandler -DMW_CONNECTIVITY_RX_DMAStream=LL_DMA_STREAM_0 -DMW_CONNECTIVITY_RX_BUFFER=GET_USART3_RECEIVE_BUFFER -DMW_USART3_RECEIVE_BUFFER_SIZE=1024 -DMW_USART3_ENABLED=1 -DMW_GPIO_BIT_SHIFT=0
DEFINES_BUILD_ARGS = -DCLASSIC_INTERFACE=0 -DALLOCATIONFCN=0 -DTERMFCN=1 -DONESTEPFCN=1 -DMAT_FILE=0 -DMULTI_INSTANCE_CODE=0 -DINTEGER_CODE=0 -DMT=0
DEFINES_CUSTOM = 
DEFINES_OPTS = -DTID01EQ=0 -DCODER_ASSUMPTIONS_ENABLED=1 -DRTIOSTREAM_RX_BUFFER_BYTE_SIZE=128 -DRTIOSTREAM_TX_BUFFER_BYTE_SIZE=128 -DMEM_UNIT_BYTES=1 -DMemUnit_T=uint8_T
DEFINES_SKIPFORSIL = -DXCP_CUSTOM_PLATFORM -DXCP_MEM_DAQ_RESERVED_POOL_BLOCKS_NUMBER=10 -D__FPU_PRESENT=1U -D__FPU_USED=1U -DSTACK_SIZE=512 -DRT
DEFINES_STANDARD = -DMODEL=Algorithm_to_deploy -DNUMST=1 -DNCSTATES=0 -DHAVESTDIO -DMODEL_HAS_DYNAMICALLY_LOADED_SFCNS=0

DEFINES = $(DEFINES_) $(DEFINES_BUILD_ARGS) $(DEFINES_CUSTOM) $(DEFINES_OPTS) $(DEFINES_SKIPFORSIL) $(DEFINES_STANDARD)

###########################################################################
## SOURCE FILES
###########################################################################

SRCS = $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_interface_lib.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_data_stream.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_services.c $(START_DIR)/slprj/ert/Algorithm_to_deploy/pil/xil_interface.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xilcomms_rtiostream.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_rtiostream.c $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/rtiostream_utils.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/coder_assumptions_app.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/coder_assumptions_data_stream.c $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/coder_assumptions_rtiostream.c $(START_DIR)/slprj/ert/Algorithm_to_deploy/pil/pil_main.c C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/shared/supportpackages/stm32/src/rtiostream_serial.c C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/shared/supportpackages/stm32/src/stm_usart.c C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/shared/supportpackages/stm32/src/stm_lpuart.c C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/shared/supportpackages/stm32/src/platform_timer.c $(START_DIR)/Controller_HIL/Core/Src/main.c $(START_DIR)/Controller_HIL/Core/Src/stm32h7xx_it.c $(START_DIR)/Controller_HIL/Core/Src/stm32h7xx_hal_msp.c $(START_DIR)/Controller_HIL/Core/Src/stm32h7xx_hal_timebase_tim.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_exti.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_gpio.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_rcc.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_utils.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc_ex.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash_ex.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_gpio.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_hsem.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma_ex.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_mdma.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr_ex.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_cortex.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c_ex.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_exti.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_dma.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim_ex.c $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_usart.c $(START_DIR)/Controller_HIL/Core/Src/system_stm32h7xx.c $(START_DIR)/Controller_HIL/STM32CubeIDE/Application/User/Core/syscalls.c $(START_DIR)/Controller_HIL/STM32CubeIDE/Application/User/Core/sysmem.c $(START_DIR)/Controller_HIL/STM32CubeIDE/Application/User/Startup/startup_stm32h723zgtx.s

ALL_SRCS = $(SRCS)

###########################################################################
## OBJECTS
###########################################################################

OBJS = xil_interface_lib.c.o xil_data_stream.c.o xil_services.c.o xil_interface.c.o xilcomms_rtiostream.c.o xil_rtiostream.c.o rtiostream_utils.c.o coder_assumptions_app.c.o coder_assumptions_data_stream.c.o coder_assumptions_rtiostream.c.o pil_main.c.o rtiostream_serial.c.o stm_usart.c.o stm_lpuart.c.o platform_timer.c.o main.c.o stm32h7xx_it.c.o stm32h7xx_hal_msp.c.o stm32h7xx_hal_timebase_tim.c.o stm32h7xx_ll_exti.c.o stm32h7xx_ll_gpio.c.o stm32h7xx_ll_rcc.c.o stm32h7xx_ll_utils.c.o stm32h7xx_hal_rcc.c.o stm32h7xx_hal_rcc_ex.c.o stm32h7xx_hal_flash.c.o stm32h7xx_hal_flash_ex.c.o stm32h7xx_hal_gpio.c.o stm32h7xx_hal_hsem.c.o stm32h7xx_hal_dma.c.o stm32h7xx_hal_dma_ex.c.o stm32h7xx_hal_mdma.c.o stm32h7xx_hal_pwr.c.o stm32h7xx_hal_pwr_ex.c.o stm32h7xx_hal_cortex.c.o stm32h7xx_hal.c.o stm32h7xx_hal_i2c.c.o stm32h7xx_hal_i2c_ex.c.o stm32h7xx_hal_exti.c.o stm32h7xx_ll_dma.c.o stm32h7xx_hal_tim.c.o stm32h7xx_hal_tim_ex.c.o stm32h7xx_ll_usart.c.o system_stm32h7xx.c.o syscalls.c.o sysmem.c.o startup_stm32h723zgtx.s.o

ALL_OBJS = $(OBJS)

###########################################################################
## PREBUILT OBJECT FILES
###########################################################################

PREBUILT_OBJS = 

###########################################################################
## LIBRARIES
###########################################################################

MODELREF_LIBS = ../../../../slprj/ert/Algorithm_to_deploy/Algorithm_to_deploy_rtwlib.lib

LIBS = $(START_DIR)/slprj/ert/_sharedutils/rtwshared.lib $(START_DIR)/slprj/ert/Algorithm_to_deploy/coderassumptions/lib/Algorithm_to_deploy_ca.lib C:/ProgramData/MATLAB/SupportPackages/R2025b/3P.instrset/cmsis_dsp.instrset/Lib/GCC/arm_cortexm7ldfdp_math/libCMSISDSP.a C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/shared/supportpackages/stm32/lib/GCC/libmw_pdmfilter_m7_dpfp.lib

###########################################################################
## SYSTEM LIBRARIES
###########################################################################

SYSTEM_LIBS = 

###########################################################################
## ADDITIONAL TOOLCHAIN FLAGS
###########################################################################

#---------------
# C Compiler
#---------------

CFLAGS_SKIPFORSIL = -mcpu=cortex-m7 -mthumb -mlittle-endian -mthumb-interwork -mfpu=fpv5-d16 -mfloat-abi=hard  -ffp-contract=off
CFLAGS_BASIC = $(DEFINES) $(INCLUDES) @$(COMPILER_COMMAND_FILE)

CFLAGS += $(CFLAGS_SKIPFORSIL) $(CFLAGS_BASIC)

#-----------------
# C++ Compiler
#-----------------

CPPFLAGS_SKIPFORSIL = -mcpu=cortex-m7 -mthumb -mlittle-endian -mthumb-interwork -mfpu=fpv5-d16 -mfloat-abi=hard  -ffp-contract=off
CPPFLAGS_BASIC = $(DEFINES) $(INCLUDES) @$(COMPILER_COMMAND_FILE)

CPPFLAGS += $(CPPFLAGS_SKIPFORSIL) $(CPPFLAGS_BASIC)

#---------------
# C++ Linker
#---------------

CPP_LDFLAGS_SKIPFORSIL = -mcpu=cortex-m7 -mthumb -mlittle-endian -mfloat-abi=hard -mfpu=fpv5-d16 --entry Reset_Handler --specs=nosys.specs  -T "C:\Users\robyd\Desktop\UNIVPM\Manutenzione preventiva per la robotica e l'automazione intelligente\Progetto\MPRAI_Progetto\Controller_HIL\STM32CubeIDE\STM32H723ZGTX_FLASH.ld"

CPP_LDFLAGS += $(CPP_LDFLAGS_SKIPFORSIL)

#------------------------------
# C++ Shared Library Linker
#------------------------------

CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL = -mcpu=cortex-m7 -mthumb -mlittle-endian -mfloat-abi=hard -mfpu=fpv5-d16 --entry Reset_Handler --specs=nosys.specs  -T "C:\Users\robyd\Desktop\UNIVPM\Manutenzione preventiva per la robotica e l'automazione intelligente\Progetto\MPRAI_Progetto\Controller_HIL\STM32CubeIDE\STM32H723ZGTX_FLASH.ld"

CPP_SHAREDLIB_LDFLAGS += $(CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL)

#-----------
# Linker
#-----------

LDFLAGS_SKIPFORSIL = -mcpu=cortex-m7 -mthumb -mlittle-endian -mfloat-abi=hard -mfpu=fpv5-d16 --entry Reset_Handler --specs=nosys.specs  -T "C:\Users\robyd\Desktop\UNIVPM\Manutenzione preventiva per la robotica e l'automazione intelligente\Progetto\MPRAI_Progetto\Controller_HIL\STM32CubeIDE\STM32H723ZGTX_FLASH.ld"

LDFLAGS += $(LDFLAGS_SKIPFORSIL)

#---------------------
# MEX C++ Compiler
#---------------------

MEX_CPP_Compiler_BASIC =  @$(COMPILER_COMMAND_FILE)

MEX_CPPFLAGS += $(MEX_CPP_Compiler_BASIC)

#-----------------
# MEX Compiler
#-----------------

MEX_Compiler_BASIC =  @$(COMPILER_COMMAND_FILE)

MEX_CFLAGS += $(MEX_Compiler_BASIC)

#--------------------------
# Shared Library Linker
#--------------------------

SHAREDLIB_LDFLAGS_SKIPFORSIL = -mcpu=cortex-m7 -mthumb -mlittle-endian -mfloat-abi=hard -mfpu=fpv5-d16 --entry Reset_Handler --specs=nosys.specs  -T "C:\Users\robyd\Desktop\UNIVPM\Manutenzione preventiva per la robotica e l'automazione intelligente\Progetto\MPRAI_Progetto\Controller_HIL\STM32CubeIDE\STM32H723ZGTX_FLASH.ld"

SHAREDLIB_LDFLAGS += $(SHAREDLIB_LDFLAGS_SKIPFORSIL)

###########################################################################
## INLINED COMMANDS
###########################################################################


ALL_DEPS:=$(patsubst %.o,%.dep,$(ALL_OBJS))
all:

ifndef DISABLE_GCC_FUNCTION_DATA_SECTIONS
FDATASECTIONS_FLG := -ffunction-sections -fdata-sections
endif



-include codertarget_assembly_flags.mk
-include ../codertarget_assembly_flags.mk
-include ../../codertarget_assembly_flags.mk
-include mw_gnu_arm_tools_path.mk
-include ../mw_gnu_arm_tools_path.mk
-include ../../mw_gnu_arm_tools_path.mk
-include $(ALL_DEPS)


###########################################################################
## PHONY TARGETS
###########################################################################

.PHONY : all build buildobj clean info prebuild postbuild download execute


all : build postbuild
	@echo "### Successfully generated all binary outputs."


build : prebuild $(PRODUCT)


buildobj : prebuild $(OBJS) $(PREBUILT_OBJS) $(LIBS)
	@echo "### Successfully generated all binary outputs."


prebuild : 


postbuild : $(PRODUCT)
	@echo "### Invoking postbuild tool "Binary Converter" ..."
	$(OBJCOPY) $(OBJCOPYFLAGS_BIN)
	@echo "### Done invoking postbuild tool."
	@echo "### Invoking postbuild tool "Hex Converter" ..."
	$(OBJCOPY) $(OBJCOPYFLAGS_HEX)
	@echo "### Done invoking postbuild tool."
	@echo "### Invoking postbuild tool "Executable Size" ..."
	$(EXESIZE) $(EXESIZE_FLAGS)
	@echo "### Done invoking postbuild tool."


download : postbuild


execute : download
	@echo "### Invoking postbuild tool "Execute" ..."
	$(EXECUTE) $(EXECUTE_FLAGS)
	@echo "### Done invoking postbuild tool."


###########################################################################
## FINAL TARGET
###########################################################################

#-------------------------------------------
# Create a standalone executable            
#-------------------------------------------

$(PRODUCT) : $(OBJS) $(PREBUILT_OBJS) $(MODELREF_LIBS) $(LIBS)
	@echo "### Creating standalone executable "$(PRODUCT)" ..."
	$(LD) $(LDFLAGS) -o $(PRODUCT) @$(CMD_FILE) @$(MODELREF_LINK_RSPFILE) $(LIBS) $(SYSTEM_LIBS) $(TOOLCHAIN_LIBS)
	@echo "### Created: $(PRODUCT)"


###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

%.c.o : %.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : %.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.s.o : %.S
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : %.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : %.cc
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : %.C
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : %.cxx
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(RELATIVE_PATH_TO_ANCHOR)/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(RELATIVE_PATH_TO_ANCHOR)/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.s.o : $(RELATIVE_PATH_TO_ANCHOR)/%.S
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cc
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : $(RELATIVE_PATH_TO_ANCHOR)/%.C
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cxx
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.s.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.S
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.cc
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.C
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/%.cxx
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.c.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.c
	$(CC) $(CFLAGS) -o "$@" "$<"


%.s.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.s.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.S
	$(AS) $(ASFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.cpp
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.cc
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.C
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


%.cpp.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/%.cxx
	$(CPP) $(CPPFLAGS) -o "$@" "$<"


xil_interface_lib.c.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_interface_lib.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xil_data_stream.c.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_data_stream.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xil_services.c.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_services.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xil_interface.c.o : $(START_DIR)/slprj/ert/Algorithm_to_deploy/pil/xil_interface.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xilcomms_rtiostream.c.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xilcomms_rtiostream.c
	$(CC) $(CFLAGS) -o "$@" "$<"


xil_rtiostream.c.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/xil_rtiostream.c
	$(CC) $(CFLAGS) -o "$@" "$<"


rtiostream_utils.c.o : $(MATLAB_ROOT)/toolbox/coder/rtiostream/src/utils/rtiostream_utils.c
	$(CC) $(CFLAGS) -o "$@" "$<"


coder_assumptions_app.c.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/coder_assumptions_app.c
	$(CC) $(CFLAGS) -o "$@" "$<"


coder_assumptions_data_stream.c.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/coder_assumptions_data_stream.c
	$(CC) $(CFLAGS) -o "$@" "$<"


coder_assumptions_rtiostream.c.o : $(MATLAB_ROOT)/toolbox/rtw/targets/pil/c/coder_assumptions_rtiostream.c
	$(CC) $(CFLAGS) -o "$@" "$<"


pil_main.c.o : $(START_DIR)/slprj/ert/Algorithm_to_deploy/pil/pil_main.c
	$(CC) $(CFLAGS) -o "$@" "$<"


rtiostream_serial.c.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/shared/supportpackages/stm32/src/rtiostream_serial.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm_usart.c.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/shared/supportpackages/stm32/src/stm_usart.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm_lpuart.c.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/shared/supportpackages/stm32/src/stm_lpuart.c
	$(CC) $(CFLAGS) -o "$@" "$<"


platform_timer.c.o : C:/ProgramData/MATLAB/SupportPackages/R2025b/toolbox/shared/supportpackages/stm32/src/platform_timer.c
	$(CC) $(CFLAGS) -o "$@" "$<"


main.c.o : $(START_DIR)/Controller_HIL/Core/Src/main.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_it.c.o : $(START_DIR)/Controller_HIL/Core/Src/stm32h7xx_it.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_msp.c.o : $(START_DIR)/Controller_HIL/Core/Src/stm32h7xx_hal_msp.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_timebase_tim.c.o : $(START_DIR)/Controller_HIL/Core/Src/stm32h7xx_hal_timebase_tim.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_ll_exti.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_exti.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_ll_gpio.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_gpio.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_ll_rcc.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_rcc.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_ll_utils.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_utils.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_rcc.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_rcc_ex.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_rcc_ex.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_flash.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_flash_ex.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_flash_ex.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_gpio.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_gpio.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_hsem.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_hsem.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_dma.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_dma_ex.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_dma_ex.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_mdma.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_mdma.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_pwr.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_pwr_ex.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_pwr_ex.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_cortex.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_cortex.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_i2c.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_i2c_ex.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_i2c_ex.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_exti.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_exti.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_ll_dma.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_dma.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_tim.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_hal_tim_ex.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_hal_tim_ex.c
	$(CC) $(CFLAGS) -o "$@" "$<"


stm32h7xx_ll_usart.c.o : $(START_DIR)/Controller_HIL/Drivers/STM32H7xx_HAL_Driver/Src/stm32h7xx_ll_usart.c
	$(CC) $(CFLAGS) -o "$@" "$<"


system_stm32h7xx.c.o : $(START_DIR)/Controller_HIL/Core/Src/system_stm32h7xx.c
	$(CC) $(CFLAGS) -o "$@" "$<"


syscalls.c.o : $(START_DIR)/Controller_HIL/STM32CubeIDE/Application/User/Core/syscalls.c
	$(CC) $(CFLAGS) -o "$@" "$<"


sysmem.c.o : $(START_DIR)/Controller_HIL/STM32CubeIDE/Application/User/Core/sysmem.c
	$(CC) $(CFLAGS) -o "$@" "$<"


startup_stm32h723zgtx.s.o : $(START_DIR)/Controller_HIL/STM32CubeIDE/Application/User/Startup/startup_stm32h723zgtx.s
	$(AS) $(ASFLAGS) -o "$@" "$<"


###########################################################################
## DEPENDENCIES
###########################################################################

$(ALL_OBJS) : rtw_proj.tmw $(COMPILER_COMMAND_FILE) $(MAKEFILE)


###########################################################################
## MISCELLANEOUS TARGETS
###########################################################################

info : 
	@echo "### PRODUCT = $(PRODUCT)"
	@echo "### PRODUCT_TYPE = $(PRODUCT_TYPE)"
	@echo "### BUILD_TYPE = $(BUILD_TYPE)"
	@echo "### INCLUDES = $(INCLUDES)"
	@echo "### DEFINES = $(DEFINES)"
	@echo "### ALL_SRCS = $(ALL_SRCS)"
	@echo "### ALL_OBJS = $(ALL_OBJS)"
	@echo "### LIBS = $(LIBS)"
	@echo "### MODELREF_LIBS = $(MODELREF_LIBS)"
	@echo "### SYSTEM_LIBS = $(SYSTEM_LIBS)"
	@echo "### TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS)"
	@echo "### ASFLAGS = $(ASFLAGS)"
	@echo "### CFLAGS = $(CFLAGS)"
	@echo "### LDFLAGS = $(LDFLAGS)"
	@echo "### SHAREDLIB_LDFLAGS = $(SHAREDLIB_LDFLAGS)"
	@echo "### CPPFLAGS = $(CPPFLAGS)"
	@echo "### CPP_LDFLAGS = $(CPP_LDFLAGS)"
	@echo "### CPP_SHAREDLIB_LDFLAGS = $(CPP_SHAREDLIB_LDFLAGS)"
	@echo "### ARFLAGS = $(ARFLAGS)"
	@echo "### MEX_CFLAGS = $(MEX_CFLAGS)"
	@echo "### MEX_CPPFLAGS = $(MEX_CPPFLAGS)"
	@echo "### MEX_LDFLAGS = $(MEX_LDFLAGS)"
	@echo "### MEX_CPPLDFLAGS = $(MEX_CPPLDFLAGS)"
	@echo "### OBJCOPYFLAGS_BIN = $(OBJCOPYFLAGS_BIN)"
	@echo "### OBJCOPYFLAGS_HEX = $(OBJCOPYFLAGS_HEX)"
	@echo "### EXESIZE_FLAGS = $(EXESIZE_FLAGS)"
	@echo "### DOWNLOAD_FLAGS = $(DOWNLOAD_FLAGS)"
	@echo "### EXECUTE_FLAGS = $(EXECUTE_FLAGS)"
	@echo "### MAKE_FLAGS = $(MAKE_FLAGS)"


clean : 
	$(ECHO) "### Deleting all derived files ..."
	$(RM) $(subst /,\,$(PRODUCT))
	$(RM) $(subst /,\,$(ALL_OBJS))
	$(RM) *.c.dep
	$(RM) *.cpp.dep
	$(RM) *.s.dep
	$(ECHO) "### Deleted all derived files."


