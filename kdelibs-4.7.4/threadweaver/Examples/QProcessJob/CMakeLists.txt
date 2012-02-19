include_directories(${QT_INCLUDE_DIR} ${QT_QTCORE_INCLUDE_DIR} ${QT_QTGUI_INCLUDE_DIR} ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_SOURCE_DIR}/Weaver/ ${CMAKE_SOURCE_DIR}/Action/ ${KDE5_INCLUDES})
include_directories( ../../Weaver/ )

set(QProcessJob_SRCS
    QProcessJob.cpp
    MainWindow.cpp
    main.cpp
)

set( QProcessJob_SRCS_UI
    MainWindowUi.ui
)

qt5_wrap_ui(QProcessJob_SRCS ${QProcessJob_SRCS_UI} )


add_executable(QProcessJob ${QProcessJob_SRCS})

target_link_libraries(QProcessJob ${QT_QTGUI_LIBRARY} ${KDE5_KDECORE_LIBS} threadweaver)

install(TARGETS QProcessJob DESTINATION ${BIN_INSTALL_DIR} )
