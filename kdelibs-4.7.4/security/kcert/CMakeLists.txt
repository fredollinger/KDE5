project(kcert)

include_directories( ${OPENSSL_INCLUDE_DIR} )
include_directories( ${KDE5_KPARTS_INCLUDES} )
include_directories( ${CMAKE_BINARY_DIR}/kio/kssl )
include_directories( ${CMAKE_SOURCE_DIR}/kio/kssl )
include_directories( ${KDE5_KIO_INCLUDES} )

set(kcertpart_PART_SRCS kcertpart.cc )

kde5_add_plugin(kcertpart ${kcertpart_PART_SRCS})

target_link_libraries(kcertpart ${KDE5_KPARTS_LIBS})

install(TARGETS kcertpart  DESTINATION ${PLUGIN_INSTALL_DIR} )
install( FILES kcertpart.desktop  DESTINATION  ${SERVICES_INSTALL_DIR} )
install( FILES kcertpart.rc  DESTINATION  ${DATA_INSTALL_DIR}/kcertpart )
