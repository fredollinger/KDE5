include_directories(
    ${CMAKE_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/kjsembed 
    ${KDE5_KJS_INCLUDES}
    ${KDE5_KDECORE_INCLUDES}
)

add_subdirectory( kjsembed )
add_subdirectory( kjscmd )

#add_subdirectory( examples/console )
