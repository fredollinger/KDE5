PROJECT( krichtexteditor )
FIND_PACKAGE(KDE5 REQUIRED)
INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_BINARY_DIR} )

SET(krichtexteditorSources
  main.cpp
  krichtexteditor.cpp
  )

KDE5_ADD_EXECUTABLE(krichtexteditor ${krichtexteditorSources} )
TARGET_LINK_LIBRARIES(krichtexteditor ${KDE5_KDEUI_LIBS} ${KDE5_KIO_LIBS} )

install(TARGETS krichtexteditor DESTINATION ${BIN_INSTALL_DIR})
install(FILES
  krichtexteditorui.rc
  DESTINATION  ${DATA_INSTALL_DIR}/krichtexteditor)



