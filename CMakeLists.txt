#
# Copyright (C) 2014 Virgil Security Inc.
#
# Lead Maintainer: Virgil Security Inc. <support@virgilsecurity.com>
#
# All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#

#
# Configurable variables:
#     - INSTALL_LIB_DIR_NAME - name of the directory where libraries will be installed.
#     - INSTALL_BIN_DIR_NAME - name of the directory where binaries will be installed.
#     - INSTALL_API_DIR_NAME - name of the directory where API source files will be installed.
#     - INSTALL_X86_DIR_NAME - name of the directory where 32-bit libraries and binaries will be installed.
#     - INSTALL_X64_DIR_NAME - name of the directory where 64-bit libraries and binaries will be installed.
#
#     - ENABLE_WRAPPER_CSHARP - enable / disable build wrapper for CSharp.
#     - ENABLE_WRAPPER_JS     - enable / disable build wrapper for Java Script.
#     - ENABLE_WRAPPER_PHP    - enable / disable build wrapper for PHP.
#     - ENABLE_WRAPPER_AS3    - enable / disable build wrapper for AS3.
#                               Note, if this option is enabled, all other wrappers builds will be disabled.
# Define variables:
#     - COMPILER_ARCH_32 - boolean value that defines whether compiler build in 32-bit mode or not.
#     - COMPILER_ARCH_64 - boolean value that defines whether compiler build in 64-bit mode or not.
#
#     - VIRGILCRYPTO_VERSION - library full version.
#     - VIRGILCRYPTO_VERSION_MAJOR - library major version number.
#     - VIRGILCRYPTO_VERSION_MINOR - library minor version number.
#     - VIRGILCRYPTO_VERSION_PATCH - library patch number.
#
#     - WRAPPERS_ENABLED - defines that at least one wrapper is enabled.
#

cmake_minimum_required (VERSION 2.8 FATAL_ERROR)

# Set project name
project (VirgilSecurity)

# Configure path to custom modules
set (CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

# Define enviroment parameters
include (check_pointer_size)
check_pointer_size (POINTER_SIZE)
message (STATUS "Compiler pointer size: " ${POINTER_SIZE} " bytes")

if (POINTER_SIZE)
    if (POINTER_SIZE EQUAL 4)
        set (COMPILER_ARCH_32 TRUE)
        set (COMPILER_ARCH_64 FALSE)
    elseif (POINTER_SIZE EQUAL 8)
        set (COMPILER_ARCH_32 FALSE)
        set (COMPILER_ARCH_64 TRUE)
    endif ()
endif (POINTER_SIZE)

# Configure testing
enable_testing ()

# Set version
set (VIRGILCRYPTO_VERSION_MAJOR 0)
set (VIRGILCRYPTO_VERSION_MINOR 1)
set (VIRGILCRYPTO_VERSION_PATCH 0)
set (VIRGILCRYPTO_VERSION ${VIRGILCRYPTO_VERSION_MAJOR}.${VIRGILCRYPTO_VERSION_MINOR}.${VIRGILCRYPTO_VERSION_PATCH})

# Set configurable path variables
set (INSTALL_LIB_DIR_NAME lib CACHE STRING "Installation directory name for libraries")
set (INSTALL_BIN_DIR_NAME bin CACHE STRING "Installation directory name for executables")
set (INSTALL_API_DIR_NAME api CACHE STRING "Installation directory name for interface files")
set (INSTALL_X86_DIR_NAME x86 CACHE STRING "Installation directory name for 32-bit libraries and binaries")
set (INSTALL_X64_DIR_NAME x64 CACHE STRING "Installation directory name for 64-bit libraries and binaries")

# Set interbnal path variables
set (EXTERNAL_LIBS_DIR "${CMAKE_CURRENT_BINARY_DIR}/libs" CACHE INTERNAL
        "Path to the folder where all libs MUST be located after build")

# Set build options
option (ENABLE_WRAPPER_CSHARP "Enable / disable build of 'csharp' module" OFF)
option (ENABLE_WRAPPER_PHP "Enable / disable build of 'php' module" OFF)
option (ENABLE_WRAPPER_JS "Enable / disable build of 'javascript' module" OFF)
option (ENABLE_WRAPPER_AS3 "Enable / disable build of 'actionscript' module" OFF)

# If ActionScript wrapper build enabled, disable other wrappers.
if (ENABLE_WRAPPER_AS3)
    option (ENABLE_WRAPPER_CSHARP OFF FORCE)
    option (ENABLE_WRAPPER_PHP OFF FORCE)
    option (ENABLE_WRAPPER_JS OFF FORCE)
endif (ENABLE_WRAPPER_AS3)

# Define WRAPPERS_DISABLED
if (ENABLE_WRAPPER_CSHARP OR ENABLE_WRAPPER_PHP OR ENABLE_WRAPPER_JS OR ENABLE_WRAPPER_AS3)
    set (WRAPPERS_ENABLED TRUE)
else ()
    set (WRAPPERS_ENABLED FALSE)
endif ()


# Build submodules
add_subdirectory (lib)
add_subdirectory (wrappers)