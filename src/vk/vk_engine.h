﻿// vulkan_guide.h : Include file for standard system include files,
// or project specific include files.

#pragma once

#include <vk_descriptors.h>
#include <vk_types.h>

struct FrameData
{
  VkCommandPool _commandPool;
  VkCommandBuffer _mainCommandBuffer;

  VkSemaphore _swapchainSemaphore, _renderSemaphore;
  VkFence _renderFence;

  DeletionQueue _deletionQueue;
};

struct ComputePushConstants
{
  glm::vec4 data1;
  glm::vec4 data2;
  glm::vec4 data3;
  glm::vec4 data4;
};

struct ComputeEffect
{
  const char *name;

  VkPipeline pipeline;
  VkPipelineLayout layout;

  ComputePushConstants data;
};

constexpr unsigned int FRAME_OVERLAP = 2;

class VulkanEngine
{
public:
  bool _isInitialized{ false };
  int _frameNumber{ 0 };
  bool stop_rendering{ false };
  VkExtent2D _windowExtent{ 1700, 900 };

  struct SDL_Window *_window{ nullptr };

  static VulkanEngine &Get();

  // initializes everything in the engine
  void init();

  // shuts down the engine
  void cleanup();

  // draw loop
  void draw();

  void draw_background(VkCommandBuffer cmd);

  void draw_imgui(VkCommandBuffer cmd, VkImageView targetImageView);

  // run main loop
  void run();

public:
  VkInstance _instance;// Vulkan library handle
  VkDebugUtilsMessengerEXT _debug_messenger;// Vulkan debug output handle
  VkPhysicalDevice _chosenGPU;// GPU chosen as the default device
  VkDevice _device;// Vulkan device for commands
  VkSurfaceKHR _surface;// Vulkan window surface

  VkSwapchainKHR _swapchain;
  VkFormat _swapchainImageFormat;

  std::vector<VkImage> _swapchainImages;
  std::vector<VkImageView> _swapchainImageViews;
  VkExtent2D _swapchainExtent;

  FrameData _frames[FRAME_OVERLAP];

  FrameData &get_current_frame() { return _frames[_frameNumber % FRAME_OVERLAP]; };

  VkQueue _graphicsQueue;
  uint32_t _graphicsQueueFamily;

  DeletionQueue _mainDeletionQueue;

  VmaAllocator _allocator;

  // draw resources
  AllocatedImage _drawImage;
  VkExtent2D _drawExtent;

  DescriptorAllocator globalDescriptorAllocator;

  VkDescriptorSet _drawImageDescriptors;
  VkDescriptorSetLayout _drawImageDescriptorLayout;

  VkPipeline _gradientPipeline;
  VkPipelineLayout _gradientPipelineLayout;

   // immediate submit structures
  VkFence _immFence;
  VkCommandBuffer _immCommandBuffer;
  VkCommandPool _immCommandPool;

  std::vector<ComputeEffect> backgroundEffects;
  int currentBackgroundEffect{ 0 };

  void immediate_submit(std::function<void(VkCommandBuffer cmd)> &&function);

private:
  void init_vulkan();
  void init_swapchain();
  void init_commands();
  void init_sync_structures();
  void init_descriptors();

  void init_pipelines();
  void init_background_pipelines();

  void init_imgui();

  void create_swapchain(uint32_t width, uint32_t height);
  void destroy_swapchain();
};
