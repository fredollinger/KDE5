kde5_add_unit_test(test_kconf_update
    test_kconf_update.cpp
    )

target_link_libraries(test_kconf_update
    ${KDE5_KDECORE_LIBS}
    ${QT_QTCORE_LIBRARY}
    ${QT_QTTEST_LIBRARY}
    )

kde5_add_unit_test(test_kconfigutils
    test_kconfigutils.cpp
    ../kconfigutils.cpp
    )

target_link_libraries(test_kconfigutils
    ${KDE5_KDECORE_LIBS}
    ${QT_QTCORE_LIBRARY}
    ${QT_QTTEST_LIBRARY}
    )
