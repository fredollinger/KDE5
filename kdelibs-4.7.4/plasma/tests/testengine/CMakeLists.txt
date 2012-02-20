project(plasma_testengine_dataengine)

find_package(KDE5 REQUIRED)

include(KDE5Defaults)

include_directories(${CMAKE_SOURCE_DIR}
                    ${CMAKE_BINARY_DIR}
                    ${KDE5_INCLUDES})

set(testengine_engine_SRCS
    testengine.cpp)

kde5_add_plugin(plasma_engine_testengine
                ${testengine_engine_SRCS})

target_link_libraries(plasma_engine_testengine
                      ${KDE5_KIO_LIBS}
                      ${KDE5_PLASMA_LIBS})

install(TARGETS plasma_engine_testengine DESTINATION ${PLUGIN_INSTALL_DIR})
install(FILES plasma-dataengine-testengine.desktop DESTINATION ${SERVICES_INSTALL_DIR} )
