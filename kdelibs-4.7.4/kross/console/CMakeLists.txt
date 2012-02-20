include_directories(
    ${CMAKE_SOURCE_DIR}/kross
    ${KDE5_KDECORE_INCLUDES}
    ${KDE5_KDEUI_INCLUDES}
    ${KDE5_KIO_INCLUDES}
)

set(kross_SRCS main.cpp )
kde5_add_executable(kross ${kross_SRCS})
target_link_libraries(kross  ${KDE5_KDEUI_LIBS} krosscore )
install(TARGETS kross ${INSTALL_TARGETS_DEFAULT_ARGS})
