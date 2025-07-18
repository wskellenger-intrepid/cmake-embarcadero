# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.


# This module is shared by multiple languages; use include blocker.
if(__COMPILER_EMBTCLANG)
  return()
endif()
set(__COMPILER_EMBTCLANG 1)

if("x${CMAKE_C_SIMULATE_ID}" STREQUAL "xEMBT")
  get_filename_component(EMBT_DRIVER_NAME "${CMAKE_C_COMPILER}" NAME_WE)
elseif("x${CMAKE_CXX_SIMULATE_ID}" STREQUAL "xEMBT")
  get_filename_component(EMBT_DRIVER_NAME "${CMAKE_CXX_COMPILER}" NAME_WE)
endif()

macro(__set_embt_target_win target)
  get_property(_is_embt TARGET ${target} PROPERTY EMBT_TARGET SET)
  get_property(_is_package TARGET ${target} PROPERTY EMBT_PACKAGE)
  get_property(_target_type TARGET ${target} PROPERTY TYPE)
  if(NOT _is_embt)
    set_property(TARGET ${target} PROPERTY EMBT_TARGET)
    set_property(TARGET ${target} PROPERTY PREFIX "")
    set_property(TARGET ${target} PROPERTY IMPORT_PREFIX "")

    if(${_target_type} STREQUAL "EXECUTABLE")
      set_property(TARGET ${target} PROPERTY SUFFIX ".exe")
    elseif(${_target_type} STREQUAL "SHARED_LIBRARY")
      set_property(TARGET ${target} PROPERTY SUFFIX ".dll")
    elseif(${_target_type} STREQUAL "STATIC_LIBRARY")
      set_property(TARGET ${target} PROPERTY SUFFIX ".lib")
    endif()
    set_property(TARGET ${target} PROPERTY IMPORT_SUFFIX ".lib")

    set(__isExecutable $<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>)
    set(__isWin32 $<BOOL:$<TARGET_PROPERTY:WIN32_EXECUTABLE>>)
    set(__isSharedLibrary $<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>)
    set(__isPackage $<BOOL:$<TARGET_PROPERTY:EMBT_PACKAGE>>)
    set(__isDynamicRuntime $<BOOL:$<TARGET_PROPERTY:EMBT_DYNAMICRUNTIME>>)
    set(__isRTL $<BOOL:$<TARGET_PROPERTY:EMBT_RTL>>)
    set(__isVCL $<BOOL:$<TARGET_PROPERTY:EMBT_VCL>>)
    set(__isFMX $<BOOL:$<TARGET_PROPERTY:EMBT_FMX>>)
    set(__isUnicode $<BOOL:$<TARGET_PROPERTY:EMBT_UNICODE>>)

    set(_target_options
      $<$<AND:${__isExecutable},${__isWin32}>:-tW>
      $<$<AND:${__isExecutable},$<NOT:${__isWin32}>>:-tC>
      $<$<AND:${__isSharedLibrary},${__isPackage}>:-tP>
      $<$<AND:${__isSharedLibrary},$<NOT:${__isPackage}>>:-tD>
      $<$<OR:${__isDynamicRuntime},${__isPackage}>:-tR>
      $<${__isRTL}:-tJ>
      $<${__isVCL}:-tV>
      $<${__isFMX}:-tF>
      $<${__isUnicode}:-tU>
    )

    target_compile_options(${target} PRIVATE ${_target_options})
    target_link_options(${target} PRIVATE ${_target_options})
    target_compile_definitions(${target} PRIVATE
      $<$<CONFIG:Debug>:_DEBUG>
      $<$<OR:${__isDynamicRuntime},${__isPackage}>:USEPACKAGES>
    )
  endif()

  if(${_target_type} STREQUAL "SHARED_LIBRARY" AND _is_package)
    set_property(TARGET ${target} PROPERTY SUFFIX ".bpl")
    set_property(TARGET ${target} PROPERTY IMPORT_SUFFIX ".bpi")
  endif()
endmacro()

set(__EMBT_TARGET_INIT 0)

function(set_embt_target target)
  if(NOT __EMBT_TARGET_INIT)
    set(__EMBT_TARGET_INIT 1)
    set(CMAKE_C_OUTPUT_EXTENSION_REPLACE 1 PARENT_SCOPE)
    set(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE 1 PARENT_SCOPE)
  endif()
  foreach(_opt ${ARGN})
    string(TOUPPER "${_opt}" _opt_upper)
    set_property(TARGET ${target} PROPERTY EMBT_${_opt_upper} TRUE)
  endforeach()
  if(WIN32)
    __set_embt_target_win(${target})
  else()
    message(FATAL_ERROR "Platform not supported.")
  endif()
endfunction()
