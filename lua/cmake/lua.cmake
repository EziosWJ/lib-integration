function(add_lua)
    include(FetchContent)

    FetchContent_Declare(
        lua
        GIT_REPOSITORY https://github.com/lua/lua.git
        GIT_TAG v5.4.0
    )

    FetchContent_GetProperties(lua)
    if(NOT lua_POPULATED)
        FetchContent_Populate(lua)

        file(GLOB LUA_SRC ${lua_SOURCE_DIR}/*.c)
        # Exclude the Lua interpreter and compiler source files
        list(FILTER LUA_SRC EXCLUDE REGEX "lua.c|luac.c")

        add_library(lua STATIC ${LUA_SRC})

        target_include_directories(lua PUBLIC ${lua_SOURCE_DIR})
    endif()
endfunction()