include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/../..)

########### next target ###############
set(pidginemoticons_SRCS pidgin_emoticons.cpp)

kde5_add_plugin(emoticonstheme_pidgin ${pidginemoticons_SRCS})

target_link_libraries(emoticonstheme_pidgin kemoticons ${KDE5_KDEUI_LIBS})

########### install files ###############

install(TARGETS emoticonstheme_pidgin DESTINATION ${PLUGIN_INSTALL_DIR})
install(FILES emoticonstheme_pidgin.desktop DESTINATION  ${SERVICES_INSTALL_DIR})
