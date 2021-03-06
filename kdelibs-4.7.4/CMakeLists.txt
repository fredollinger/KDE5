project(kdelibs)

# where to look first for cmake modules, before ${CMAKE_ROOT}/Modules/ is checked
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/modules")

# Make CPack available to easy generate binary packages
include(CPack)

################# set KDE specific information #################

set (KDE_VERSION_MAJOR 5)
set (KDE_VERSION_MINOR 0)
set (KDE_VERSION_RELEASE 0)
set (KDE_VERSION "${KDE_VERSION_MAJOR}.${KDE_VERSION_MINOR}.${KDE_VERSION_RELEASE}" )
set (KDE_VERSION_STRING "${KDE_VERSION} (5.0.0)")

set (KDE_DISTRIBUTION_TEXT "compiled sources" CACHE STRING "Indicate the distribution in bug reports" )

# win32: give kde home in debug mode a different name as the  release home dir because the settings and caches are different
if (WIN32 AND CMAKE_BUILD_TYPE STREQUAL "Debug")
    set (_KDE_DEFAULT_HOME_POSTFIX "-debug" CACHE STRING "default KDE home directory postfix" )
endif (WIN32 AND CMAKE_BUILD_TYPE STREQUAL "Debug")
set (KDE_DEFAULT_HOME ".kde${_KDE_DEFAULT_HOME_POSTFIX}" CACHE STRING "The default KDE home directory" )

# this must be before FindKDE5Internal in order to preset the result of the visibility test, so that it will be skipped
option(KHTML_BUILD_TESTREGRESSION "Build KHTML's testregression. Note: this disables hidden visibility")
# Disable visibility if testregression is built, because the symbols are needed then
if (KHTML_BUILD_TESTREGRESSION)
   set (__KDE_HAVE_GCC_VISIBILITY 0)
endif (KHTML_BUILD_TESTREGRESSION)

option(STATIC_LIBRARY "Build kdelibs as static libraries." FALSE)

################# write platform profile file which will be installed #################
include(CreateKDEPlatformProfile.cmake)

if(KDE_PLATFORM_FEATURE_DISABLE_DEPRECATED)
   set(KDE_NO_DEPRECATED TRUE)
endif(KDE_PLATFORM_FEATURE_DISABLE_DEPRECATED)

############### Load the CTest options ###############
# CTestCustom.cmake has to be in the CTEST_BINARY_DIR.
# in the KDE build system, this is the same as CMAKE_BINARY_DIR.
configure_file(${CMAKE_SOURCE_DIR}/CTestCustom.cmake ${CMAKE_BINARY_DIR}/CTestCustom.cmake COPYONLY)

################# now find all used packages #################

# set (QT_MIN_VERSION "4.7.0")
set (QT_MIN_VERSION "5.0.0")

find_package(KDE5Internal REQUIRED)
include(KDE5Defaults)
include (MacroLibrary)
if (APPLE)
   find_package(Carbon REQUIRED)
endif (APPLE)

if(UNIX AND Q_WS_X11)
  #X11 Session Management (SM) is required
  #X11_SM_FOUND is set in FindX11, which is required by KDE5Internal
  if(NOT X11_SM_FOUND)
    message(FATAL_ERROR "\nThe X11 Session Management (SM) development package could not be found.\nPlease install libSM.\n")
  endif(NOT X11_SM_FOUND)
endif(UNIX AND Q_WS_X11)

#required features:
# Perl is used e.g. in khtml, kjs, kjsembed and others
find_package(Perl)
macro_log_feature(PERL_FOUND "Perl" "Needed for building kdelibs" "http://www.perl.org" TRUE "" "")

find_package(ZLIB)
macro_log_feature(ZLIB_FOUND "ZLib" "Support for gzip compressed files and data streams" "http://www.zlib.net" TRUE "" "Required by the core KDE libraries and some critical kioslaves")

set(STRIGI_MIN_VERSION 0.6.3)
find_package(Strigi)
if (WIN32)
    set (STRIGI_REQUIRED FALSE)
    set (STRIGI_EXTRA_TEXT "")
else (WIN32)
    set (STRIGI_REQUIRED TRUE)
    set (STRIGI_EXTRA_TEXT "Required by some critical kioslaves")
endif (WIN32)
macro_log_feature(STRIGI_FOUND "Strigi" "Desktop indexing and search support" "http://strigi.sourceforge.net" ${STRIGI_REQUIRED} "${STRIGI_MIN_VERSION}" ${STRIGI_EXTRA_TEXT})

set(LIBATTICA_MIN_VERSION "0.1.90")
find_package(LibAttica)
macro_log_feature(LIBATTICA_FOUND "libattica" "Support for Get Hot New Stuff" "git clone git://anongit.kde.org/attica" TRUE "${LIBATTICA_MIN_VERSION}" "")

#optional features
if(X11_FOUND)
  #X11_Xrender discovery is done by FindX11
  macro_log_feature(X11_Xrender_FOUND "X Rendering Extension (libXrender)" "Support for compositing, rendering operations, and alpha-blending" "http://www.x.org" FALSE "" "STRONGLY RECOMMENDED")
  macro_bool_to_01(X11_Xscreensaver_FOUND HAVE_XSCREENSAVER)
  macro_bool_to_01(X11_XSync_FOUND HAVE_XSYNC)
  macro_log_feature(HAVE_XSCREENSAVER "X Screensaver Extension (libXss)" "Support for KIdleTime (fallback mode)" "http://www.x.org/" FALSE "" "")
  macro_log_feature(HAVE_XSYNC "X Sync Extension (libXext)" "Efficient operation of KIdleTime" "http://www.x.org/" FALSE "" "STRONGLY RECOMMENDED")

  if(NOT HAVE_XSYNC AND NOT HAVE_XSCREENSAVER)
    message(FATAL_ERROR "\nNeither the XSync (libXext) nor XScreensaver (libXss) development package was found.\nPlease install one of them (XSync is recommended)\n")
  endif(NOT HAVE_XSYNC AND NOT HAVE_XSCREENSAVER)
endif(X11_FOUND)


macro_optional_find_package(OpenSSL)
macro_log_feature(OPENSSL_FOUND "OpenSSL" "Support for secure network communications (SSL and TLS)" "http://openssl.org" FALSE "" "STRONGLY RECOMMENDED: KDE uses OpenSSL for the bulk of secure communications, including secure web browsing via HTTPS")

macro_optional_find_package(Libintl)
macro_log_feature(LIBINTL_FOUND "Libintl" "Support for multiple languages" "http://www.gnu.org/software/gettext" FALSE "" "STRONGLY RECOMMENDED: Enables KDE to be available in many different languages")

set(SOPRANO_MIN_VERSION "2.5.60")
macro_optional_find_package(Soprano ${SOPRANO_MIN_VERSION} COMPONENTS PLUGIN_RAPTORPARSER PLUGIN_REDLANDBACKEND)
macro_log_feature(SOPRANO_FOUND "Soprano" "Support for the Nepomuk semantic desktop system" "http://soprano.sourceforge.net" FALSE "${SOPRANO_MIN_VERSION}" "")
macro_log_feature(SOPRANO_PLUGIN_RAPTORPARSER_FOUND "Soprano Raptor Parser" "Support for the Nepomuk semantic desktop system" "http://soprano.sourceforge.net" FALSE "" "")
macro_log_feature(SOPRANO_PLUGIN_REDLANDBACKEND_FOUND "Soprano Redland Backend" "Support for the Nepomuk semantic desktop system" "http://soprano.sourceforge.net" FALSE "" "")

set(SHAREDDESKTOPONTOLOGIES_MIN_VERSION 0.6.50)
macro_optional_find_package(SharedDesktopOntologies ${SHAREDDESKTOPONTOLOGIES_MIN_VERSION})
macro_log_feature(SHAREDDESKTOPONTOLOGIES_FOUND "Shared desktop ontologies" "Support for the Nepomuk semantic desktop system" "http://oscaf.sourceforge.net" FALSE "${SHAREDDESKTOPONTOLOGIES_MIN_VERSION}" "")

macro_optional_find_package(QCA2)
macro_log_feature(QCA2_FOUND "QCA2" "Support for remote plasma widgets" "http://delta.affinix.com/qca" FALSE "2.0.0" "")

find_package(DBusMenuQt)
macro_log_feature(DBUSMENUQT_FOUND "DBusMenuQt" "Support for notification area menus via the DBusMenu protocol" "git clone git://gitorious.org/dbusmenu/dbusmenu-qt.git" TRUE "" "")

################# Disallow in-source build #################

macro_ensure_out_of_source_build("kdelibs requires an out of source build. Please create a separate build directory and run 'cmake path_to_kdelibs [options]' there.")

# ... and warn in case of an earlier in-source build
set(generatedFileInSourceDir EXISTS ${kdelibs_SOURCE_DIR}/kdemacros.h OR EXISTS ${kdelibs_SOURCE_DIR}/config.h)
if(${generatedFileInSourceDir})
   message(STATUS "kdemacros.h or config.h exists in your source directory.")
   message(FATAL_ERROR "Please run svn-clean, it would seem that your source directory has generated files in it.")
endif(${generatedFileInSourceDir})
#########################################################################

add_definitions(${QT_DEFINITIONS} ${KDE5_DEFINITIONS})
remove_definitions(-DQT3_SUPPORT_WARNINGS -DQT3_SUPPORT)

add_definitions(-DQT_USE_FAST_CONCATENATION -DQT_USE_FAST_OPERATOR_PLUS)

################# setup the include directories #################

# for including config.h and for includes like <kparts/foo.h>
include_directories( ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR} ${CMAKE_SOURCE_DIR}/interfaces)

if(QCA2_FOUND)
    include_directories(
        ${QCA2_INCLUDE_DIR}
    )
endif(QCA2_FOUND)


# Those variables for  are only valid inside of kdelibs, of course.
# Use the one variable for the lib you depend upon.
# E.g. kdeui uses ${KDE5_KDECORE_INCLUDES}. Something that depends on kparts uses ${KDE5_KPARTS_INCLUDES}.

set(KDE5_KJS_INCLUDES ${CMAKE_SOURCE_DIR}/kjs
                      ${CMAKE_BINARY_DIR}/kjs)

if(NOT WINCE)
    set(KDE5_KDECORE_INCLUDES ${KDE5_KJS_INCLUDES} )
endif(NOT WINCE)

# kdecore depends on Qt (need only headers from kjs)
set(KDE5_KDECORE_INCLUDES ${KDE5_KDECORE_INCLUDES}
                          ${CMAKE_SOURCE_DIR}/kdecore
                          ${CMAKE_BINARY_DIR}/kdecore
                          ${CMAKE_SOURCE_DIR}/kdecore/compression
                          ${CMAKE_SOURCE_DIR}/kdecore/config
                          ${CMAKE_SOURCE_DIR}/kdecore/date
                          ${CMAKE_SOURCE_DIR}/kdecore/io
                          ${CMAKE_SOURCE_DIR}/kdecore/jobs
                          ${CMAKE_SOURCE_DIR}/kdecore/kernel
                          ${CMAKE_SOURCE_DIR}/kdecore/auth
                          ${CMAKE_SOURCE_DIR}/kdecore/network
                          ${CMAKE_SOURCE_DIR}/kdecore/services
                          ${CMAKE_SOURCE_DIR}/kdecore/localization
                          ${CMAKE_SOURCE_DIR}/kdecore/sycoca
                          ${CMAKE_SOURCE_DIR}/kdecore/text
                          ${CMAKE_SOURCE_DIR}/kdecore/util
                          ${CMAKE_SOURCE_DIR}/kdecore/sonnet
                          ${QT_INCLUDES}
                          ${_KDE5_PLATFORM_INCLUDE_DIRS})
# kdeui depends on kdecore
set(KDE5_KDEUI_INCLUDES ${CMAKE_SOURCE_DIR}/kdeui
                        ${CMAKE_SOURCE_DIR}/kdeui/actions
                        ${CMAKE_SOURCE_DIR}/kdeui/colors
                        ${CMAKE_SOURCE_DIR}/kdeui/config
                        ${CMAKE_SOURCE_DIR}/kdeui/dialogs
                        ${CMAKE_SOURCE_DIR}/kdeui/findreplace
                        ${CMAKE_SOURCE_DIR}/kdeui/fonts
                        ${CMAKE_SOURCE_DIR}/kdeui/icons
                        ${CMAKE_SOURCE_DIR}/kdeui/itemviews
                        ${CMAKE_SOURCE_DIR}/kdeui/jobs
                        ${CMAKE_SOURCE_DIR}/kdeui/kernel
                        ${CMAKE_SOURCE_DIR}/kdeui/notifications
                        ${CMAKE_SOURCE_DIR}/kdeui/paged
                        ${CMAKE_SOURCE_DIR}/kdeui/plotting
                        ${CMAKE_SOURCE_DIR}/kdeui/shortcuts
                        ${CMAKE_SOURCE_DIR}/kdeui/sonnet
                        ${CMAKE_SOURCE_DIR}/kdeui/util
                        ${CMAKE_SOURCE_DIR}/kdeui/widgets
                        ${CMAKE_SOURCE_DIR}/kdeui/windowmanagement
                        ${CMAKE_SOURCE_DIR}/kdeui/xmlgui
                        ${KDE5_KDECORE_INCLUDES})

# kio depends on kdeui
set(KDE5_KIO_INCLUDES ${CMAKE_SOURCE_DIR}/kio
                      ${CMAKE_SOURCE_DIR}/kio/bookmarks
                      ${CMAKE_SOURCE_DIR}/kio/kio
                      ${CMAKE_SOURCE_DIR}/kio/kfile
                      ${KDE5_KDEUI_INCLUDES})

# kpty
set(KDE5_KPTY_INCLUDES ${CMAKE_SOURCE_DIR}/kpty ${KDE5_KIO_INCLUDES} )

# kparts depends on kio
set(KDE5_KPARTS_INCLUDES ${CMAKE_SOURCE_DIR}/kparts
                         ${KDE5_KIO_INCLUDES})

# kde3support depends on kparts
set(KDE5_KDE3SUPPORT_INCLUDES ${CMAKE_SOURCE_DIR}/kde3support
                              ${CMAKE_SOURCE_DIR}/kde3support/kdecore
                              ${CMAKE_SOURCE_DIR}/kde3support/kdeui
                              ${CMAKE_SOURCE_DIR}/kde3support/kio
                              ${KDE5_KPARTS_INCLUDES})

if(NOT WINCE)
 set(KDE5_KHTML_INCLUDES ${CMAKE_SOURCE_DIR}/khtml)
endif(NOT WINCE)


################# configure checks and create the configured files #################

if(WINCE)
  set(STATIC_LIBRARY ON)
  add_definitions(-DSTATIC_INSTALL_PATH=L\\\"/programme/kde\\\")
endif(WINCE)

if(STATIC_LIBRARY)
  set(LIBRARY_TYPE STATIC)
  add_definitions(-DKDELIBS_STATIC_LIBS)
  message(STATUS "Building kdelibs as static libraries")
else(STATIC_LIBRARY)
  set(LIBRARY_TYPE SHARED)
endif(STATIC_LIBRARY)

# ACL stuff (used in kio/ and kioslaves/)
macro_optional_find_package(ACL)
macro_bool_to_01(ACL_FOUND HAVE_LIBACL HAVE_POSIX_ACL)
macro_log_feature(ACL_FOUND "LibACL" "Support for manipulating access control lists" "ftp://oss.sgi.com/projects/xfs/cmd_tars" FALSE "" "STRONGLY RECOMMENDED")
configure_file(config-acl.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-acl.h )

include(ConfigureChecks.cmake)

# Actually nepomuk is not optional, without it other KDE modules don't build,
# so this must be fixed. Alex
if(Soprano_FOUND AND SHAREDDESKTOPONTOLOGIES_FOUND)
  set(HAVE_NEPOMUK true)
  include(SopranoAddOntology)
  add_subdirectory(nepomuk)
endif(Soprano_FOUND AND SHAREDDESKTOPONTOLOGIES_FOUND)

# now create config headers
configure_file(config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h )
configure_file(config-prefix.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-prefix.h )
configure_file(config-compiler.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-compiler.h )
configure_file(config-pty.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-pty.h )
configure_file(config-nepomuk.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-nepomuk.h )
configure_file(kdemacros.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/kdemacros.h )

# these two calls here should go somewhere else, Alex
check_library_exists(nsl gethostbyname "" HAVE_NSL_LIBRARY)
check_library_exists(socket connect "" HAVE_SOCKET_LIBRARY)

################# list the subdirectories #################

add_subdirectory( cmake )
add_subdirectory( kdecore )
add_subdirectory( kdeui )
if (UNIX)
   add_subdirectory( kpty )
   add_subdirectory( kdesu )
endif (UNIX)
if(NOT WINCE)
add_subdirectory( kjs )
add_subdirectory( kjsembed )
endif(NOT WINCE)
add_subdirectory( kio )
add_subdirectory( solid )
add_subdirectory( kded       )
if (QT_QT3SUPPORT_FOUND)
   add_subdirectory( kde3support  )
endif (QT_QT3SUPPORT_FOUND)
add_subdirectory( kfile )
add_subdirectory( kconf_update )
if(NOT WINCE)
add_subdirectory( kdoctools  )
endif(NOT WINCE)
add_subdirectory( kioslave   )
add_subdirectory( knewstuff  )
add_subdirectory( kparts     )
add_subdirectory( kutils     )
add_subdirectory( licenses   )
add_subdirectory( mimetypes  )
add_subdirectory( kinit  )
add_subdirectory( threadweaver )
add_subdirectory( sonnet  )
if(NOT WINCE)
add_subdirectory( khtml  )
endif(NOT WINCE)
add_subdirectory( interfaces  )
#if ( NOT CMAKE_CROSSCOMPILING AND QT_QTDESIGNER_FOUND )
add_subdirectory( kdewidgets  )
#endif ( NOT CMAKE_CROSSCOMPILING AND QT_QTDESIGNER_FOUND )
add_subdirectory( knotify )
if(NOT WINCE)
add_subdirectory( kimgio )
endif(NOT WINCE)
add_subdirectory( dnssd )
add_subdirectory( kross )
add_subdirectory( security )
if(NOT WINCE)
add_subdirectory( plasma )
endif(NOT WINCE)
add_subdirectory( kunitconversion )
add_subdirectory( kdewebkit )
add_subdirectory( includes )

add_subdirectory( experimental )
macro_optional_add_subdirectory( doc  )

################# write dependency file which will be installed #################

# Used in configure_file() and install(EXPORT)
set(KDE5_TARGET_PREFIX KDE5__)
include(CreateKDELibsDependenciesFile.cmake)

################# install files #################

install( FILES ${CMAKE_CURRENT_BINARY_DIR}/kdemacros.h  DESTINATION  ${INCLUDE_INSTALL_DIR} )
install( FILES ${CMAKE_CURRENT_BINARY_DIR}/config-nepomuk.h  DESTINATION  ${INCLUDE_INSTALL_DIR} )
install( FILES ${CMAKE_CURRENT_BINARY_DIR}/KDELibsDependencies.cmake DESTINATION ${DATA_INSTALL_DIR}/cmake/modules)
install( FILES ${CMAKE_CURRENT_BINARY_DIR}/KDEPlatformProfile.cmake  DESTINATION ${DATA_INSTALL_DIR}/cmake/modules)


# run a script before installing the exports files which deletes previously installed
# configuration specific export files KDELibs4(Library|Tools)Targets-<config>.cmake
# if the main exports file KDELibs4(Library|Tools)Targets.cmake has changed. This makes sure
# that this main file doesn't include older and different configuration specific exports files,
# which might have a different set of targets or targets with different names.
# The code for installing the exports files will soon go into a macro. Alex
install(CODE "set(EXPORT_FILES KDELibs4LibraryTargets.cmake KDELibs4ToolsTargets.cmake)"
        CODE "set(EXPORT_INSTALL_DIR \"${DATA_INSTALL_DIR}/cmake/modules\")"
        SCRIPT "${CMAKE_SOURCE_DIR}/cmake/modules/check_installed_exports_file.cmake" )
install( EXPORT kdelibsLibraryTargets DESTINATION ${DATA_INSTALL_DIR}/cmake/modules NAMESPACE ${KDE5_TARGET_PREFIX} FILE KDELibs4LibraryTargets.cmake )
install( EXPORT kdelibsToolsTargets   DESTINATION ${DATA_INSTALL_DIR}/cmake/modules NAMESPACE ${KDE5_TARGET_PREFIX} FILE KDELibs4ToolsTargets.cmake )
# the following will be the correct locations once cmake has the improved FIND_PACKAGE()
# install( FILES ${CMAKE_CURRENT_BINARY_DIR}/KDELibsDependencies.cmake DESTINATION ${PLUGIN_INSTALL_DIR}/cmake RENAME KDE5Config.cmake)

macro_display_feature_log()
