include_directories( ${OPENSSL_INCLUDE_DIR} )
include_directories( ${KDE5_KPARTS_INCLUDES} )
include_directories( ${CMAKE_BINARY_DIR}/kio/kssl )
include_directories( ${CMAKE_SOURCE_DIR}/kio/kssl )

set(kcm_crypto_PART_SRCS crypto.cpp certexport.cpp kdatetimedlg.cpp )

kde5_add_plugin(kcm_crypto ${kcm_crypto_PART_SRCS})

target_link_libraries(kcm_crypto ${KDE5_KIO_LIBS} ${KDE5_KDEUI_LIBS} ${OPENSSL_LIBRARIES})

install(TARGETS kcm_crypto  DESTINATION ${PLUGIN_INSTALL_DIR} )
install( FILES crypto.desktop  DESTINATION  ${SERVICES_INSTALL_DIR} )
