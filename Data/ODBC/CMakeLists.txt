target_compile_definitions(${BII_BLOCK_TARGET} INTERFACE ${ODBC_CFLAGS})
target_link_libraries( ${BII_BLOCK_TARGET} INTERFACE ${ODBC_LIBRARIES})
