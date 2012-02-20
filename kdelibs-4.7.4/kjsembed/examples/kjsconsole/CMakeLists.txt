
project(kjsembed-console)

include_directories( ${KDE5_KDEUI_INCLUDES} )
include_directories( ${CMAKE_SOURCE_DIR}/kjsembed ${CMAKE_SOURCE_DIR}/kjsembed/kjsembed )


########### next target ###############

set(console_SRCS
   main.cpp
   console.cpp
   kjs_object_model.cpp
   numberedtextview.cpp
   )


kde5_add_ui_files(console_SRCS jsconsole.ui )

qt5_add_resources(console_SRCS console.qrc )

kde5_add_executable(kjsconsole ${console_SRCS})

target_link_libraries(kjsconsole  ${KDE5_KDECORE_LIBS} kjsembed )

install(TARGETS kjsconsole DESTINATION ${BIN_INSTALL_DIR} )


########### install files ###############





