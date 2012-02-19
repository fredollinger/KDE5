set( EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR} )
include_directories( ${KDE5_KPTY_INCLUDES} )

kde5_add_unit_test(kptyprocesstest kptyprocesstest.cpp)
target_link_libraries(kptyprocesstest ${KDE5_KPTY_LIBS} ${QT_QTTEST_LIBRARY})
