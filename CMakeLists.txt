cmake_minimum_required(VERSION 3.10)

set(CMAKE_DISABLE_SOURCE_CHANGES ON)
set(CMAKE_DISABLE_IN_SOURCE_BUILD ON)

project(tfs CXX)

add_subdirectory(src)
#discord staff
add_subdirectory(libs/DPP) 
add_executable(tfs ${tfs_SRC})

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

set_target_properties(tfs PROPERTIES CXX_STANDARD 17)
set_target_properties(tfs PROPERTIES CXX_STANDARD_REQUIRED ON)

set(CMAKE_CXX_FLAGS_PERFORMANCE "${CMAKE_CXX_FLAGS_RELEASE} -march=native")

#  -Werror // warnings treated as errors
add_compile_options(-Wall -pipe -march=native -fvisibility=hidden)

set(CMAKE_CXX_FLAGS_DEFAULT "-O2 -g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3")

if (CMAKE_COMPILER_IS_GNUCXX)
    add_compile_options(-fno-strict-aliasing)
endif()

include(FindCXX11)
include(FindLTO)

# Find packages.
find_package(GMP REQUIRED)
find_package(PugiXML REQUIRED)
find_package(ZLIB REQUIRED)
find_package(MySQL)
find_package(Threads)

# Selects LuaJIT if user defines or auto-detected
if(DEFINED USE_LUAJIT AND NOT USE_LUAJIT)
    set(FORCE_LUAJIT ${USE_LUAJIT})
else()
    find_package(LuaJIT)
    set(FORCE_LUAJIT ${LuaJIT_FOUND})
endif()
option(USE_LUAJIT "Use LuaJIT" ${FORCE_LUAJIT})

if(FORCE_LUAJIT)
    if(APPLE)
      set(CMAKE_EXE_LINKER_FLAGS "-pagezero_size 10000 -image_base 100000000")
    endif()
else()
    find_package(Lua REQUIRED)
endif()

find_package(Boost 1.66.0 REQUIRED date_time COMPONENTS system filesystem iostreams)



include_directories(
    ${MYSQL_INCLUDE_DIR} 
    ${LUA_INCLUDE_DIR} 
    ${Boost_INCLUDE_DIRS} 
    ${PUGIXML_INCLUDE_DIR} 
    ${GMP_INCLUDE_DIR} 
    ${ZLIB_INCLUDE_DIR}
    libs/DPP/include
    )

target_link_libraries(tfs PRIVATE
        ${MYSQL_CLIENT_LIBS} 
        ${LUA_LIBRARIES} 
        ${Boost_LIBRARIES} 
        ${Boost_FILESYSTEM_LIBRARY} 
        ${PUGIXML_LIBRARIES} 
        ${GMP_LIBRARIES} 
        ${ZLIB_LIBRARY} 
        ${CMAKE_THREAD_LIBS_INIT} 
        dpp
        )



### INTERPROCEDURAL_OPTIMIZATION ###
cmake_policy(SET CMP0069 NEW)
include(CheckIPOSupported)
check_ipo_supported(RESULT result OUTPUT error)
if (result)
    message(STATUS "IPO / LTO enabled")
    set_target_properties(tfs PROPERTIES INTERPROCEDURAL_OPTIMIZATION True)
else ()
    message(STATUS "IPO / LTO not supported: <${error}>")
endif ()
### END INTERPROCEDURAL_OPTIMIZATION ###


include(cotire)
set_target_properties(tfs PROPERTIES COTIRE_CXX_PREFIX_HEADER_INIT "src/otpch.h")
set_target_properties(tfs PROPERTIES COTIRE_ADD_UNITY_BUILD FALSE)
cotire(tfs)
