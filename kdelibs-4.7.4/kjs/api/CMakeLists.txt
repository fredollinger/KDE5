include_directories(${KDE5_KDECORE_INCLUDES})

set(kjsapi_LIB_SRCS
    kjsinterpreter.cpp
    kjscontext.cpp
    kjsobject.cpp
    kjsprototype.cpp
    kjsarguments.cpp
   )

kde5_add_library(kjsapi ${LIBRARY_TYPE} ${kjsapi_LIB_SRCS})

target_link_libraries(kjsapi ${KJSLIBNAME} ${KDE5_KDECORE_LIBS})

set_target_properties(kjsapi PROPERTIES VERSION ${GENERIC_LIB_VERSION} SOVERSION ${GENERIC_LIB_SOVERSION} )
install(TARGETS kjsapi EXPORT kdelibsLibraryTargets ${INSTALL_TARGETS_DEFAULT_ARGS})

install(FILES
        kjsapi_export.h
        kjsinterpreter.h
        kjscontext.h
        kjsobject.h
        kjsprototype.h
        kjsarguments.h
        DESTINATION  ${INCLUDE_INSTALL_DIR}/kjs)


############# tests ########################

kde5_add_unit_test(kjsapitest NOGUI kjsapitest.cpp)
target_link_libraries(kjsapitest kjsapi ${KDE5_KDECORE_LIBS} ${QT_QTTEST_LIBRARY})
