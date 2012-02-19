
include_directories(${KDE5_PHONON_INCLUDES} ${KDE5_KIO_INCLUDES})


########### next target ###############

set(kfileaudiopreview_PART_SRCS
kfileaudiopreview.cpp
mediacontrols.cpp
)


kde5_add_plugin(kfileaudiopreview ${kfileaudiopreview_PART_SRCS})

target_link_libraries(kfileaudiopreview ${KDE5_KIO_LIBS} ${KDE5_PHONON_LIBS})

install(TARGETS kfileaudiopreview  DESTINATION ${PLUGIN_INSTALL_DIR} )


########### install files ###############


