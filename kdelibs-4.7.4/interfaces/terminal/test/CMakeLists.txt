set( EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR} )



########### next target ###############



   set(test_SRCS main.cc )
   kde5_add_executable(test TEST  ${test_SRCS})
   target_link_libraries(test  ${KDE5_KDECORE_LIBS} kdeui kio )

########### install files ###############





