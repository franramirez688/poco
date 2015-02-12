macro(ENABLE_LIBRARIES )
    string(REGEX MATCH "(.*)[Data/MySQL/include](.*)"  MySQL_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(MySQL_SINGLE_MATCHED)
      SET(ENABLE_DATA_MYSQL ON)
    ENDIF()

    string(REGEX MATCH "(.*)[Data/ODBC/include](.*)"  ODBC_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(ODBC_SINGLE_MATCHED)
      SET(ENABLE_DATA_ODBC  ON)
    ENDIF()

    string(REGEX MATCH "(.*)[Data/SQLite/include](.*)"  SQLite_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(SQLite_SINGLE_MATCHED)
      SET(ENABLE_DATA_SQLITE  ON)
    ENDIF()

    string(REGEX MATCH "(.*)[JSON/include](.*)"  JSON_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(JSON_SINGLE_MATCHED)
      SET(ENABLE_JSON ON)
    ENDIF()

    string(REGEX MATCH "(.*)[MongoDB/include](.*)"  MONGODB_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(MONGODB_SINGLE_MATCHED)
      SET(ENABLE_MONGODB ON)
    ENDIF()

    string(REGEX MATCH "(.*)[Util/include](.*)"  UTIL_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(UTIL_SINGLE_MATCHED)
      SET(ENABLE_UTIL ON)
    ENDIF()

    string(REGEX MATCH "(.*)[Net/include](.*)"  NET_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(NET_SINGLE_MATCHED)
      SET(ENABLE_NET ON)
    ENDIF()

    string(REGEX MATCH "(.*)[Zip/include](.*)"  ZIP_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(ZIP_SINGLE_MATCHED)
      SET(ENABLE_ZIP ON)
    ENDIF()

    string(REGEX MATCH "(.*)[ApacheConnector/include](.*)"  APACHECONNECTOR_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(APACHECONNECTOR_SINGLE_MATCHED)
      SET(ENABLE_APACHECONNECTOR  OFF)
    ENDIF()

    string(REGEX MATCH "(.*)[CppParser/include](.*)"  CPPPARSER_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(CPPPARSER_SINGLE_MATCHED)
      SET(ENABLE_CPPPARSER OFF)
    ENDIF()

    string(REGEX MATCH "(.*)[XML/include](.*)"  XML_SINGLE_MATCHED "${BII_LIB_SRC}")
    IF(XML_SINGLE_MATCHED)
      SET(ENABLE_XML ON)
    ENDIF()

    string(REGEX MATCH "(.*)[Crypto/include](.*)"  CRYPTO_SINGLE_MATCHED "${BII_LIB_SRC}") 
    IF(CRYPTO_SINGLE_MATCHED)
        SET(ENABLE_CRYPTO  ON)
    ENDIF()

    string(REGEX MATCH "(.*)[Data/include](.*)"  DATA_SINGLE_MATCHED "${BII_LIB_SRC}") 
    IF(DATA_SINGLE_MATCHED)
        SET(ENABLE_DATA ON)
    ENDIF()

    string(REGEX MATCH "(.*)[NetSSL_OpenSSL/include](.*)"  NETSSL_OPENSSL_SINGLE_MATCHED "${BII_LIB_SRC}") 
    IF(NETSSL_OPENSSL_SINGLE_MATCHED)
        SET(ENABLE_NETSSL ON)
    ENDIF()

    string(REGEX MATCH "(.*)[NetSSL_Win/include](.*)"  NETSSL_WIN_SINGLE_MATCHED "${BII_LIB_SRC}") 
    IF(NETSSL_WIN_SINGLE_MATCHED)
        SET(ENABLE_NETSSL_WIN ON)
    ENDIF()

    string(REGEX MATCH "(.*)[PDF/include](.*)"  PDF_SINGLE_MATCHED "${BII_LIB_SRC}") 
    IF(PDF_SINGLE_MATCHED)
        SET(ENABLE_PDF ON)
    ENDIF()

    string(REGEX MATCH "(.*)[SevenZip/include](.*)"  SEVENZIP_SINGLE_MATCHED "${BII_LIB_SRC}") 
    IF(SEVENZIP_SINGLE_MATCHED)
        SET(ENABLE_SEVENZIP  ON)
    ENDIF()
    
endmacro()

# Delete all the bad implementations which biicode detects
macro(FILTER_BAD_DEPENDENCIES)
    SET(ALL_MATCHES )
    foreach(RESOURCE_FILE ${BII_LIB_SRC})
        # First filter: selected the pattern "_WIN32" or similars
        set(SINGLE_MATCHED )
        string(REGEX MATCH "(.*)(_WIN32U|_UNIX|_POSIX|_STD|_C99|_DEC|_DUMMY|_SUN|_VMS|_WINCE|_WIN32|_VX|_Android|_HPUX)(.*)" SINGLE_MATCHED "${RESOURCE_FILE}")
        IF(DEFINED SINGLE_MATCHED)
            SET(ALL_MATCHES ${ALL_MATCHES} ${SINGLE_MATCHED})
        ENDIF(DEFINED SINGLE_MATCHED)
    endforeach(RESOURCE_FILE ${BII_LIB_SRC})

    FOREACH(BAD_ITEM ${ALL_MATCHES})
      LIST(REMOVE_ITEM BII_LIB_SRC ${BAD_ITEM})
    ENDFOREACH(BAD_ITEM ${ALL_MATCHES})

    # Second filter: special cases
    SET(SPECIAL_BAD_DEPENDENCIES_WIN Foundation/include/Poco/SyslogChannel.h
                     Foundation/src/SyslogChannel.cpp
                     Foundation/include/Poco/OpcomChannel.h
                     Foundation/src/OpcomChannel.cpp)

    SET(SPECIAL_BAD_DEPENDENCIES_UNIX Foundation/include/Poco/EventLogChannel.h
                      Foundation/src/EventLogChannel.cpp
                      Foundation/include/Poco/WindowsConsoleChannel.h
                      Foundation/src/WindowsConsoleChannel.cpp
                      Foundation/include/Poco/OpcomChannel.h
                      Foundation/src/OpcomChannel.cpp
                      Util/src/WinRegistryKey.cpp
                      Util/src/WinRegistryConfiguration.cpp
                      Util/src/WinService.cpp)
    IF(WIN32)
      FOREACH(SPECIAL_DEP ${SPECIAL_BAD_DEPENDENCIES_WIN})
        list(FIND BII_LIB_SRC ${SPECIAL_DEP} DEP_MATCH)
        if(DEP_MATCH)
          LIST(REMOVE_ITEM BII_LIB_SRC ${SPECIAL_DEP})
        endif()
      ENDFOREACH()
    ELSEIF(UNIX)
      FOREACH(SPECIAL_DEP ${SPECIAL_BAD_DEPENDENCIES_UNIX})
        list(FIND BII_LIB_SRC ${SPECIAL_DEP} DEP_MATCH)
        if(DEP_MATCH)
          LIST(REMOVE_ITEM BII_LIB_SRC ${SPECIAL_DEP})
        endif()
      ENDFOREACH()
    ENDIF()
endmacro(FILTER_BAD_DEPENDENCIES)