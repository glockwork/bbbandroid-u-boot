# Copyright (c) 2011 The Chromium OS Authors.
# SPDX-License-Identifier:	GPL-2.0+

PLATFORM_CPPFLAGS += -DCONFIG_SANDBOX -D__SANDBOX__ -U_FORTIFY_SOURCE
PLATFORM_CPPFLAGS += -DCONFIG_ARCH_MAP_SYSMEM -DCONFIG_SYS_GENERIC_BOARD
PLATFORM_LIBS += -lrt

ifdef CONFIG_SANDBOX_SDL
PLATFORM_LIBS += $(shell sdl-config --libs)
PLATFORM_CPPFLAGS += $(shell sdl-config --cflags)
endif

# Support generic board on sandbox
__HAVE_ARCH_GENERIC_BOARD := y

cmd_u-boot__ = $(CC) -o $@ -T u-boot.lds \
	-Wl,--start-group $(u-boot-main) -Wl,--end-group \
	$(PLATFORM_LIBS) -Wl,-Map -Wl,u-boot.map

CONFIG_ARCH_DEVICE_TREE := sandbox

# Define this to avoid linking with SDL, which requires SDL libraries
# This can solve 'sdl-config: Command not found' errors
ifneq ($(NO_SDL),)
PLATFORM_CPPFLAGS += -DSANDBOX_NO_SDL
endif
