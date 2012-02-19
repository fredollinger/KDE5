include_directories( ${KDE5_KIO_INCLUDES} .. )
set( EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR} )

######### kmimeassociationstest ########

set(kmimeassociationstest_SRCS kmimeassociationstest.cpp ../kmimeassociations.cpp)

kde5_add_unit_test(kmimeassociationstest ${kmimeassociationstest_SRCS})

target_link_libraries(kmimeassociationstest ${KDE5_KDECORE_LIBS} ${QT_QTTEST_LIBRARY})

