project(kded)

add_subdirectory( tests )

include_directories( ${KDE5_KIO_INCLUDES} )

if(KDE_PLATFORM_FEATURE_BINARY_COMPATIBLE_FEATURE_REDUCTION)
    set(KBUILDSYCOCA_NO_KCRASH TRUE)
endif(KDE_PLATFORM_FEATURE_BINARY_COMPATIBLE_FEATURE_REDUCTION)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config-kded.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-kded.h)


########### next target ###############

set(kded_KDEINIT_SRCS kded.cpp kdedadaptor.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/org.kde.kded.xml # just so that it gets generated
)


kde5_add_kdeinit_executable(kded4  ${kded_KDEINIT_SRCS})

if (Q_WS_MAC)
    set_target_properties(kded4 PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist.template)
    set_target_properties(kded4 PROPERTIES MACOSX_BUNDLE_GUI_IDENTIFIER "org.kded.kded5")
    set_target_properties(kded4 PROPERTIES MACOSX_BUNDLE_BUNDLE_NAME "KDE Daemon")
endif (Q_WS_MAC)

target_link_libraries(kdeinit_kded4  ${KDE5_KIO_LIBS} ${X11_LIBRARIES})

install(TARGETS kdeinit_kded4 ${INSTALL_TARGETS_DEFAULT_ARGS})

target_link_libraries( kded4 kdeinit_kded4 )
install(TARGETS kded4 ${INSTALL_TARGETS_DEFAULT_ARGS} )


qt5_generate_dbus_interface( kdedadaptor.h org.kde.kded.xml )
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/org.kde.kded.xml DESTINATION ${DBUS_INTERFACES_INSTALL_DIR})



########### next target ###############

set(kbuildsycoca_KDEINIT_SRCS
   kbuildsycoca.cpp
   kbuildmimetypefactory.cpp
   kmimeassociations.cpp
   kbuildservicetypefactory.cpp
   kbuildservicefactory.cpp
   kbuildservicegroupfactory.cpp
   kbuildprotocolinfofactory.cpp
   kctimefactory.cpp
   vfolder_menu.cpp
   )

if(KBUILDSYCOCA_NO_KCRASH)
    set(KBUILDSYCOCA_MAIN_LIBS ${KDE5_KDECORE_LIBS})
else(KBUILDSYCOCA_NO_KCRASH)
    set(KBUILDSYCOCA_MAIN_LIBS ${KDE5_KDEUI_LIBS})
endif(KBUILDSYCOCA_NO_KCRASH)


kde5_add_kdeinit_executable( kbuildsycoca4 NOGUI ${kbuildsycoca_KDEINIT_SRCS})

target_link_libraries(kdeinit_kbuildsycoca4 ${KBUILDSYCOCA_MAIN_LIBS} ${QT_QTXML_LIBRARY})

install(TARGETS kdeinit_kbuildsycoca4 ${INSTALL_TARGETS_DEFAULT_ARGS})

target_link_libraries( kbuildsycoca4 kdeinit_kbuildsycoca4 )
install(TARGETS kbuildsycoca4 ${INSTALL_TARGETS_DEFAULT_ARGS} )

########### install files ###############
if (WIN32)
install( FILES applications.menu  DESTINATION  ${SHARE_INSTALL_PREFIX}/xdg/menus )
else (WIN32)
install( FILES applications.menu  DESTINATION  ${SYSCONF_INSTALL_DIR}/xdg/menus )
endif (WIN32)
install( FILES kdedmodule.desktop DESTINATION  ${SERVICETYPES_INSTALL_DIR} )
install( FILES kded.upd           DESTINATION  ${DATA_INSTALL_DIR}/kconf_update )


