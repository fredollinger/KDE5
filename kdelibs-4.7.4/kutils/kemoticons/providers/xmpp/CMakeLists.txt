include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/../..)

########### next target ###############
set(xmppemoticons_SRCS xmpp_emoticons.cpp)

kde5_add_plugin(emoticonstheme_xmpp ${xmppemoticons_SRCS})

target_link_libraries(emoticonstheme_xmpp kemoticons ${KDE5_KDEUI_LIBS} ${QT_QTXML_LIBRARY})

########### install files ###############

install(TARGETS emoticonstheme_xmpp DESTINATION ${PLUGIN_INSTALL_DIR})
install(FILES emoticonstheme_xmpp.desktop DESTINATION  ${SERVICES_INSTALL_DIR})
