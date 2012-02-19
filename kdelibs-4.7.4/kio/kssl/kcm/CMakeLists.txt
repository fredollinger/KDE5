########### next target ###############

set(kcmssl_SRCS kcmssl.cpp cacertificatespage.cpp displaycertdialog.cpp)

kde5_add_ui_files(kcmssl_SRCS cacertificates.ui displaycert.ui)

kde5_add_plugin(kcm_ssl ${kcmssl_SRCS})
target_link_libraries(kcm_ssl ${KDE5_KIO_LIBS})
install(TARGETS kcm_ssl DESTINATION ${PLUGIN_INSTALL_DIR})

########### install files ###############
install(FILES kcm_ssl.desktop DESTINATION ${SERVICES_INSTALL_DIR})
