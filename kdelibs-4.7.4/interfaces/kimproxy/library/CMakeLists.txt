add_subdirectory( icons )


include_directories( ${KDE5_KIO_INCLUDES} )

########### next target ###############

set(kimproxy_LIB_SRCS
  kimproxy.cpp
)

qt5_add_dbus_adaptor( kimproxy_LIB_SRCS ../interface/org.kde.KIMIface.xml kimproxy.h  KIMProxy)

qt5_add_dbus_interface(kimproxy_LIB_SRCS ../interface/org.kde.KIMIface.xml kimiface )


kde5_add_library(kimproxy ${LIBRARY_TYPE} ${kimproxy_LIB_SRCS})

target_link_libraries(kimproxy  ${KDE5_KIO_LIBS} )
target_link_libraries(kimproxy  LINK_INTERFACE_LIBRARIES ${QT_QTCORE_LIBRARY} )

set_target_properties(kimproxy PROPERTIES
   VERSION ${GENERIC_LIB_VERSION}
   SOVERSION ${GENERIC_LIB_SOVERSION}
)

########### install files ###############

install(TARGETS kimproxy  EXPORT kdelibsLibraryTargets ${INSTALL_TARGETS_DEFAULT_ARGS})
install( FILES kimproxy_export.h kimproxy.h DESTINATION  ${INCLUDE_INSTALL_DIR} COMPONENT Devel)
