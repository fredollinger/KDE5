project( KDELIBS_EXPERIMENTAL )

# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ is checked
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH} )

if(CMAKE_SOURCE_DIR STREQUAL "${CMAKE_CURRENT_SOURCE_DIR}")
  set(BUILDING_EXPERIMENTAL_SEPARATELY TRUE)
endif(CMAKE_SOURCE_DIR STREQUAL "${CMAKE_CURRENT_SOURCE_DIR}")

if(BUILDING_EXPERIMENTAL_SEPARATELY)
   find_package(KDE5 4.2.85 REQUIRED)
   include(MacroLibrary)
   include(KDE5Defaults)
else(BUILDING_EXPERIMENTAL_SEPARATELY)
   include_directories(${CMAKE_CURRENT_SOURCE_DIR}
                       ${KDE5_KDEUI_INCLUDES})
endif(BUILDING_EXPERIMENTAL_SEPARATELY)


if(BUILDING_EXPERIMENTAL_SEPARATELY)
   macro_display_feature_log()
endif(BUILDING_EXPERIMENTAL_SEPARATELY)


add_subdirectory(libkdeclarative)
macro_optional_add_subdirectory(libkactivities)
