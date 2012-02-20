include_directories(
    ${CMAKE_SOURCE_DIR}
    ${KDE5_KDECORE_INCLUDES}
    ${KDE5_KDEUI_INCLUDES}
    ${KDE5_KIO_INCLUDES}
)


set(krossui_LIB_SRCS
   model.cpp
   view.cpp
   plugin.cpp
#   guiclient.cpp
   )

kde5_add_library(krossui ${LIBRARY_TYPE} ${krossui_LIB_SRCS})
target_link_libraries(krossui krosscore ${KDE5_KDEUI_LIBS} ${KDE5_KPARTS_LIBS} ${KDE5_KIO_LIBS})
set_target_properties(krossui PROPERTIES VERSION ${GENERIC_LIB_VERSION} 
                                         SOVERSION ${GENERIC_LIB_SOVERSION}
                     )


install(TARGETS krossui EXPORT kdelibsLibraryTargets ${INSTALL_TARGETS_DEFAULT_ARGS})

########### install files ###############

#install(FILES guiclient.h model.h view.h DESTINATION ${INCLUDE_INSTALL_DIR}/kross/ui)
install(FILES model.h view.h plugin.h DESTINATION ${INCLUDE_INSTALL_DIR}/kross/ui COMPONENT Devel)
