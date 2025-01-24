add_library(engine_lib
  vk_types.h
  vk_initializers.cpp
  vk_initializers.h
  vk_images.h
  vk_images.cpp
  vk_descriptors.h
  vk_descriptors.cpp
  vk_pipelines.h
  vk_pipelines.cpp
  vk_engine.h
  vk_engine.cpp
  vk_loader.h
  vk_loader.cpp
  camera.cpp
  camera.h
)

set_property(TARGET engine_lib PROPERTY CXX_STANDARD 23)

target_compile_definitions(engine_lib PUBLIC GLM_FORCE_DEPTH_ZERO_TO_ONE)

target_include_directories(engine_lib PUBLIC "${CMAKE_CURRENT_SOURCE_DIR}")

target_link_libraries(engine_lib PUBLIC
  glm
  vma
  Vulkan::Vulkan
  stb_image
  vkbootstrap
  imgui
)

target_precompile_headers(engine_lib PUBLIC
  <optional>
  <vector>
  <memory>
  <string>
  <print>
  <unordered_map>
  <glm/mat4x4.hpp>
  <glm/vec4.hpp>
  <vulkan/vulkan.h>
)
