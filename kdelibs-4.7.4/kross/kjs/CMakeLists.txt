include_directories(
    ${CMAKE_SOURCE_DIR}/kross
    ${KDE5_KJS_INCLUDES}
    ${CMAKE_SOURCE_DIR}/kjsembed
    ${KDE5_KDECORE_INCLUDES}
    ${KDE5_KDEUI_INCLUDES}
    ${KDE5_KIO_INCLUDES}
)

########### next target ###############

set(krosskjs_PART_SRCS
   kjsscript.cpp 
   kjsinterpreter.cpp
)

kde5_add_plugin(krosskjs ${krosskjs_PART_SRCS})
target_link_libraries(krosskjs ${KDE5_KDEUI_LIBS} ${KDE5_KDECORE_LIBS} krosscore kjs kjsembed)
install(TARGETS krosskjs DESTINATION ${PLUGIN_INSTALL_DIR})
