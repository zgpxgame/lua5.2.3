cmake_minimum_required(VERSION 2.8)
project(Lua5.2.3)

set(PROJECT_LUA_SHARED_LIB Lua5.2.3)
set(PROJECT_LUA_STATIC_LIB Lua5.2.3Static)
set(PROJECT_LUA_INTERPRETER Lua)
set(PROJECT_LUA_COMPILER Luac)
set(BUILD_DIR ../build)
set(LUA_CORE
  lapi.h
  lapi.c
  lcode.h
  lcode.c
  lctype.h
  lctype.c
  ldebug.h
  ldebug.c
  ldo.h
  ldo.c
  ldump.c
  lfunc.h
  lfunc.c
  lgc.h
  lgc.c
  llex.h
  llex.c
  llimits.h
  lmem.h
  lmem.c
  lobject.h
  lobject.c
  lopcodes.h
  lopcodes.c
  lparser.h
  lparser.c
  lstate.h
  lstate.c
  lstring.h
  lstring.c
  ltable.h
  ltable.c
  ltm.h
  ltm.c
  lundump.h
  lundump.c
  lvm.h
  lvm.c
  lzio.h
  lzio.c
)

set(LUA_LIB
  lauxlib.c
  lbaselib.c
  lbitlib.c
  lcorolib.c
  ldblib.c
  liolib.c
  lmathlib.c
  loslib.c
  lstrlib.c
  ltablib.c
  loadlib.c
  linit.c
)

add_definitions(-D_CRT_SECURE_NO_WARNINGS)

#####################################################
# lua 动态库
#####################################################
add_library(${PROJECT_LUA_SHARED_LIB} SHARED
  ${LUA_CORE}
  ${LUA_LIB}
)

add_library(${PROJECT_LUA_STATIC_LIB}
  ${LUA_CORE}
  ${LUA_LIB}
)

if (WIN32)
  set_target_properties(${PROJECT_LUA_SHARED_LIB} PROPERTIES COMPILE_DEFINITIONS "LUA_BUILD_AS_DLL")
endif()

if (APPLE)
  set_target_properties(${PROJECT_LUA_SHARED_LIB} PROPERTIES COMPILE_DEFINITIONS "LUA_USE_MACOSX")
endif()

# 设置输出路径
set_target_properties(${PROJECT_LUA_SHARED_LIB} PROPERTIES
  ARCHIVE_OUTPUT_DIRECTORY ${BUILD_DIR}/lib
  LIBRARY_OUTPUT_DIRECTORY ${BUILD_DIR}/lib
  RUNTIME_OUTPUT_DIRECTORY ${BUILD_DIR}/bin
)

set_target_properties(${PROJECT_LUA_STATIC_LIB} PROPERTIES
  ARCHIVE_OUTPUT_DIRECTORY ${BUILD_DIR}/lib
  LIBRARY_OUTPUT_DIRECTORY ${BUILD_DIR}/lib
  RUNTIME_OUTPUT_DIRECTORY ${BUILD_DIR}/bin
)


#####################################################
# lua解释器
#####################################################
add_executable(${PROJECT_LUA_INTERPRETER}
  lua.h
  luaconf.h
  lauxlib.h
  lualib.h
  lua.c
)

#add_dependencies(${PROJECT_LUA_INTERPRETER} ${PROJECT_LUA_SHARED_LIB})
#target_link_libraries(${PROJECT_LUA_INTERPRETER} ${PROJECT_LUA_SHARED_LIB})

add_dependencies(${PROJECT_LUA_INTERPRETER} ${PROJECT_LUA_STATIC_LIB})
target_link_libraries(${PROJECT_LUA_INTERPRETER} ${PROJECT_LUA_STATIC_LIB})

# 设置输出路径
set_target_properties(${PROJECT_LUA_INTERPRETER} PROPERTIES
  ARCHIVE_OUTPUT_DIRECTORY ${BUILD_DIR}/lib
  LIBRARY_OUTPUT_DIRECTORY ${BUILD_DIR}/lib
  RUNTIME_OUTPUT_DIRECTORY ${BUILD_DIR}/bin
)


#####################################################
# lua编译器
#####################################################
add_executable(${PROJECT_LUA_COMPILER}
  ${LUA_CORE}
  ${LUA_LIB}
  luac.c
)

# 设置输出路径
set_target_properties(${PROJECT_LUA_COMPILER} PROPERTIES
  ARCHIVE_OUTPUT_DIRECTORY ${BUILD_DIR}/lib
  LIBRARY_OUTPUT_DIRECTORY ${BUILD_DIR}/lib
  RUNTIME_OUTPUT_DIRECTORY ${BUILD_DIR}/bin
)