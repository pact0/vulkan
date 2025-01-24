set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_subdirectory(vk)

add_executable(engine main.cpp)

target_link_libraries(engine PRIVATE engine_lib)

target_precompile_headers(engine REUSE_FROM engine_lib)

IF (WIN32)
  target_link_libraries(engine PUBLIC
    SDL2::SDL2
    fastgltf::fastgltf
  )

  add_custom_command(TARGET engine POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:engine> $<TARGET_FILE_DIR:engine>
    COMMAND_EXPAND_LISTS
    COMMENT "Copying DLLs.."
  )
ELSE()
  target_link_libraries(engine PUBLIC
    SDL2
    fastgltf::fastgltf
  )
ENDIF()
