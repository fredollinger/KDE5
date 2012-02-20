set( EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR} )
include_directories(${KDE5_KIO_INCLUDES})

set(krosstest_SRCS 
   testobject.cpp 
   main.cpp )


kde5_add_executable(krosstest TEST ${krosstest_SRCS})

target_link_libraries(krosstest ${KDE5_KDEUI_LIBS} krosscore )

