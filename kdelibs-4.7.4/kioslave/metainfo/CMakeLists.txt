
project(kioslave-metainfo)

include_directories( ${KDE5_KIO_INCLUDES} )


########### next target ###############

set(kio_metainfo_PART_SRCS metainfo.cpp )


kde5_add_plugin(kio_metainfo ${kio_metainfo_PART_SRCS})


target_link_libraries(kio_metainfo  ${KDE5_KDECORE_LIBS} kio )

install(TARGETS kio_metainfo  DESTINATION ${PLUGIN_INSTALL_DIR} )


########### install files ###############

install( FILES metainfo.protocol  DESTINATION  ${SERVICES_INSTALL_DIR} )




