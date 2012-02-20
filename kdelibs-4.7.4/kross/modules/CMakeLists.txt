include_directories(
    ${CMAKE_SOURCE_DIR}
    ${KDE5_KDECORE_INCLUDES}
    ${KDE5_KDEUI_INCLUDES}
    ${KDE5_KIO_INCLUDES}
    ${CMAKE_SOURCE_DIR}/kfile
)

if( QT_QTDESIGNER_FOUND )
	############################################
	# the forms module

	set(krossmoduleforms_SRCS form.cpp)
	kde5_add_plugin(krossmoduleforms ${krossmoduleforms_SRCS})

	target_link_libraries(krossmoduleforms ${QT_QTUITOOLS_LIBRARY} ${KDE5_KPARTS_LIBS} ${KDE5_KFILE_LIBS} krosscore krossui)
	install(TARGETS krossmoduleforms DESTINATION ${PLUGIN_INSTALL_DIR})
endif( QT_QTDESIGNER_FOUND )

############################################
# the kdetranslation module

set(krossmodulekdetranslation_SRCS translation.cpp)
kde5_add_plugin(krossmodulekdetranslation ${krossmodulekdetranslation_SRCS})

target_link_libraries(krossmodulekdetranslation ${KDE5_KPARTS_LIBS} ${KDE5_CORE_LIBS} krosscore)
install(TARGETS krossmodulekdetranslation DESTINATION ${PLUGIN_INSTALL_DIR})
