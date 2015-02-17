INIT_BIICODE_BLOCK()

INCLUDE(cmake/BiiPocoMacros.cmake)

FILTER_BAD_DEPENDENCIES()

# Actually create targets: EXEcutables and libraries.
ADD_BIICODE_TARGETS()

SET(ALL_INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/CppUnit/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/CppUnit/WinTestRunner/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/Foundation/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/Net/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/Util/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/XML/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/ApacheConnector/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/Crypto/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/Data/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/NetSSLOpenSSL/include
                            ${CMAKE_CURRENT_SOURCE_DIR}/Zip/include)

TARGET_INCLUDE_DIRECTORIES(${BII_BLOCK_TARGET} INTERFACE ${ALL_INCLUDE_DIRECTORIES})


# Append our module directory to CMake
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

#################################################################################
# Setup C/C++ compiler options
#################################################################################

if(NOT MSVC_IDE)
  if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING
      "Choose the type of build, options are: None Debug Release" FORCE)
  endif()
  message(STATUS "Setting Poco build type - ${CMAKE_BUILD_TYPE}")
endif()

if (CMAKE_BUILD_TYPE STREQUAL "")
    set( CMAKE_BUILD_TYPE "RelWithDebInfo" )
endif ()

# http://www.cmake.org/Wiki/CMake_Useful_Variables :
# CMAKE_BUILD_TYPE
#    Choose the type of build. CMake has default flags for these:
#
#    * None (CMAKE_C_FLAGS or CMAKE_CXX_FLAGS used)
#    * Debug (CMAKE_C_FLAGS_DEBUG or CMAKE_CXX_FLAGS_DEBUG)
#    * Release (CMAKE_C_FLAGS_RELEASE or CMAKE_CXX_FLAGS_RELEASE)
#    * RelWithDebInfo (CMAKE_C_FLAGS_RELWITHDEBINFO or CMAKE_CXX_FLAGS_RELWITHDEBINFO
#    * MinSizeRel (CMAKE_C_FLAGS_MINSIZEREL or CMAKE_CXX_FLAGS_MINSIZEREL)

# For Debug build types, append a "d" to the library names.
set(CMAKE_DEBUG_POSTFIX "d" CACHE STRING "Set debug library postfix" FORCE)

option(FORCE_OPENSSL "Force usage of OpenSSL even under windows" OFF)
option(ENABLE_TESTS
  "Set to OFF|ON (default is OFF) to control build of POCO tests & samples" OFF)

option(POCO_STATIC
  "Set to OFF|ON (default is OFF) to control build of POCO as STATIC library" ON)

option(POCO_UNBUNDLED
  "Set to OFF|ON (default is OFF) to control linking dependencies as external" OFF)

# Uncomment from next two lines to force statitc or dynamic library, default is autodetection
if(POCO_STATIC)
    target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -DPOCO_STATIC -DPOCO_NO_AUTOMATIC_LIBS)
    set( LIB_MODE STATIC )
    message(STATUS "Building static libraries")
else(POCO_STATIC)
    set( LIB_MODE SHARED )
    message(STATUS "Building dynamic libraries")
endif(POCO_STATIC)

if (ENABLE_TESTS)
  include(CTest)
  enable_testing()
  message(STATUS "Building with unittests & samples")
else ()
  message(STATUS "Building without tests & samples")
endif ()

if (POCO_UNBUNDLED)
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -DPOCO_UNBUNDLED)
  message(STATUS "Build with using external sqlite, libz, pcre, expat ...")
else ()
  message(STATUS "Build with using internal copy of sqlite, libz, pcre, expat, ...")
endif ()

include(CheckTypeSize)
find_package(Cygwin)

# OS Detection
if(WIN32)
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -DPOCO_OS_FAMILY_WINDOWS -DUNICODE -D_UNICODE)
  #set(SYSLIBS iphlpapi gdi32 odbc32)
endif(WIN32)

if (UNIX AND NOT ANDROID )
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -DPOCO_OS_FAMILY_UNIX )
  # Standard 'must be' defines
  if (APPLE)
    target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -DPOCO_HAVE_IPv6 -DPOCO_NO_STAT64)
    set(SYSLIBS  dl)
  else (APPLE)
    target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -D_XOPEN_SOURCE=500 -D_REENTRANT -D_THREAD_SAFE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64)
    set(SYSLIBS  pthread dl rt)
  endif (APPLE)
endif(UNIX AND NOT ANDROID )

if (CMAKE_SYSTEM MATCHES "SunOS")
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -DPOCO_OS_FAMILY_UNIX )
  # Standard 'must be' defines
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -D_XOPEN_SOURCE=500 -D_REENTRANT -D_THREAD_SAFE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 )
  set(SYSLIBS  pthread socket xnet nsl resolv rt dl)
endif(CMAKE_SYSTEM MATCHES "SunOS")

if (CMAKE_COMPILER_IS_MINGW)
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE -DWC_NO_BEST_FIT_CHARS=0x400  -DPOCO_WIN32_UTF8)
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE -D_WIN32 -DMINGW32 -DWINVER=0x500 -DODBCVER=0x0300 -DPOCO_THREAD_STACK_SIZE)
endif (CMAKE_COMPILER_IS_MINGW)

if (CYGWIN)
#    target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE -DWC_NO_BEST_FIT_CHARS=0x400  -DPOCO_WIN32_UTF8)
endif (CYGWIN)

# SunPro C++
if (${CMAKE_CXX_COMPILER_ID} MATCHES "SunPro")
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -D_BSD_SOURCE -library=stlport4)
endif (${CMAKE_CXX_COMPILER_ID} MATCHES "SunPro")

# iOS
if (IOS)
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -DPOCO_HAVE_IPv6 -DPOCO_NO_FPENVIRONMENT -DPOCO_NO_STAT64 -DPOCO_NO_SHAREDLIBS -DPOCO_NO_NET_IFTYPES )
endif(IOS)

#Android
if (ANDROID)
  target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE  -DPOCO_ANDROID -DPOCO_NO_FPENVIRONMENT -DPOCO_NO_WSTRING -DPOCO_NO_SHAREDMEMORY )
endif(ANDROID)


# Collect the built libraries and include dirs, the will be used to create the PocoConfig.cmake file
ENABLE_LIBRARIES()


add_subdirectory(Foundation)
if(ENABLE_XML)
  add_subdirectory(XML)
endif()

#NetSSL

find_package(OpenSSL)
if(OPENSSL_FOUND)
    target_include_directories(${BII_BLOCK_TARGET} INTERFACE "${OPENSSL_INCLUDE_DIR}")
    if(ENABLE_NETSSL)
      target_link_libraries(${BII_BLOCK_TARGET} INTERFACE  ${OPENSSL_SSL_LIBRARY})
    endif()
    if(ENABLE_CRYPTO)
    add_subdirectory(Crypto)
    endif()
endif(OPENSSL_FOUND)

if(ENABLE_DATA)
  add_subdirectory(Data)
endif()

find_package(APR)
find_package(Apache2)
if(APRUTIL_FOUND AND APACHE_FOUND)
    target_include_directories(${BII_BLOCK_TARGET} INTERFACE  "${APACHE_INCLUDE_DIR}" "${APRUTIL_INCLUDE_DIR}" )
    if(ENABLE_APACHECONNECTOR)
    add_subdirectory(ApacheConnector)
    endif()
endif(APRUTIL_FOUND AND APACHE_FOUND)


