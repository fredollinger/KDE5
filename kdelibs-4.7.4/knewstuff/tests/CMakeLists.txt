project(knewstuff2tests)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR} )

include_directories(${KDE5_KIO_INCLUDES} ${CMAKE_CURRENT_BINARY_DIR}/..
${CMAKE_CURRENT_SOURCE_DIR}/.. ${CMAKE_CURRENT_BINARY_DIR}/../knewstuff2/
${CMAKE_CURRENT_SOURCE_DIR}/../knewstuff2/)

add_definitions(-DKNSSRCDIR=\\""${CMAKE_CURRENT_SOURCE_DIR}"\\" -DKNSBUILDDIR=\\""${CMAKE_CURRENT_BINARY_DIR}"\\")
set(CMAKE_SKIP_RPATH TRUE)

##########################

# unit tests


#author test
if(NOT KDE_NO_DEPRECATED)
set(knewstuffauthortest_SRCS
    knewstuffauthortest.cpp
)
kde5_add_unit_test(knewstuffauthortest ${knewstuffauthortest_SRCS})
target_link_libraries(knewstuffauthortest ${KDE5_KDECORE_LIBS} knewstuff2 ${QT_QTTEST_LIBRARY})

#entry test

set (knewstuffentrytest_SRCS
    knewstuffentrytest.cpp
)
kde5_add_unit_test(knewstuffentrytest ${knewstuffentrytest_SRCS})
target_link_libraries(knewstuffentrytest ${KDE5_KDECORE_LIBS} knewstuff2 ${QT_QTTEST_LIBRARY})

#ktranslatable test

set(testTranslatable_SRCS
    testTranslatable.cpp
)
kde5_add_unit_test(testTranslatable ${testTranslatable_SRCS})
target_link_libraries(testTranslatable ${KDE5_KDECORE_LIBS} knewstuff2 ${QT_QTTEST_LIBRARY})
endif(NOT KDE_NO_DEPRECATED)

##########################

if(NOT KDE_NO_DEPRECATED)
set(knewstuff2_test_SRCS
   knewstuff2_test.cpp
)

kde5_add_executable(knewstuff2_test TEST ${knewstuff2_test_SRCS})

target_link_libraries(knewstuff2_test ${KDE5_KDECORE_LIBS} ${KDE5_KDEUI_LIBS} ${QT_QTGUI_LIBRARY} ${QT_QTXML_LIBRARY} knewstuff2)
#install(FILES knewstuff2_test.knsrc DESTINATION ${CONFIG_INSTALL_DIR})
endif(NOT KDE_NO_DEPRECATED)

##########################
 
if(NOT KDE_NO_DEPRECATED)
set(knewstuff2_download_SRCS
   knewstuff2_download.cpp
)

kde5_add_executable(knewstuff2_download TEST ${knewstuff2_download_SRCS})

target_link_libraries(knewstuff2_download ${KDE5_KDECORE_LIBS} ${KDE5_KDEUI_LIBS} ${QT_QTGUI_LIBRARY} knewstuff2)
endif(NOT KDE_NO_DEPRECATED)

##########################
 
if(NOT KDE_NO_DEPRECATED)
set(knewstuff2_standard_SRCS
   knewstuff2_standard.cpp
)

kde5_add_executable(knewstuff2_standard TEST ${knewstuff2_standard_SRCS})

target_link_libraries(knewstuff2_standard ${KDE5_KDECORE_LIBS} ${KDE5_KDEUI_LIBS} ${QT_QTGUI_LIBRARY} knewstuff2)
endif(NOT KDE_NO_DEPRECATED)

##########################
 
if(NOT KDE_NO_DEPRECATED)
set(knewstuff2_cache_SRCS
   knewstuff2_cache.cpp
)

kde5_add_executable(knewstuff2_cache TEST ${knewstuff2_cache_SRCS})

target_link_libraries(knewstuff2_cache ${KDE5_KDECORE_LIBS} ${KDE5_KDEUI_LIBS} ${QT_QTGUI_LIBRARY} knewstuff2)
endif(NOT KDE_NO_DEPRECATED)

##########################

if(NOT KDE_NO_DEPRECATED)
set(kdxspreview_SRCS
   kdxspreview.cpp
   kdxsview.cpp
)

#add_definitions(-DKNSSRCDIR=\\"${CMAKE_CURRENT_SOURCE_DIR}\\")
#set(CMAKE_SKIP_RPATH TRUE)

#kde5_add_executable(kdxspreview TEST ${kdxspreview_SRCS})

#target_link_libraries(kdxspreview ${KDE5_KDECORE_LIBS} knewstuff2)
#install(FILES kdxspreviewrc DESTINATION ${CONFIG_INSTALL_DIR})
endif(NOT KDE_NO_DEPRECATED)

