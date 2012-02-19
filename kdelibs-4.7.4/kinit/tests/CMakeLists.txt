set( EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR} )

include_directories( ${KDE5_KIO_INCLUDES} )

set(klaunchertest_SRCS klaunchertest.cpp )


kde5_add_executable(klaunchertest TEST ${klaunchertest_SRCS})

target_link_libraries(klaunchertest  ${KDE5_KDECORE_LIBS} kio )

########### install files ###############





