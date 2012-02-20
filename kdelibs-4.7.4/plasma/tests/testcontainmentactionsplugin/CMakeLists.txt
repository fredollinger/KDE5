project(plasma-containmentactions-test)

project(plasma_testengine_dataengine)

find_package(KDE5 REQUIRED)

include(KDE5Defaults)

include_directories(${CMAKE_SOURCE_DIR}
                    ${CMAKE_BINARY_DIR}
                    ${KDE5_INCLUDES})

set(test_SRCS
    test.cpp
)
kde5_add_ui_files(test_SRCS config.ui)

kde5_add_plugin(plasma_containmentactions_test ${test_SRCS})
target_link_libraries(plasma_containmentactions_test ${KDE5_PLASMA_LIBS} ${KDE5_KIO_LIBS})

install(TARGETS plasma_containmentactions_test DESTINATION ${PLUGIN_INSTALL_DIR})
install(FILES plasma-containmentactions-test.desktop DESTINATION ${SERVICES_INSTALL_DIR})
