RESOURCES_LIBRARY()

LICENSE(
    BSD
)



IF (CLANG10 AND HOST_OS_LINUX)
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE(
        CLANG # Clang 10
        sbr:1621407101 FOR LINUX
    )
ELSE()
    DECLARE_EXTERNAL_HOST_RESOURCES_BUNDLE(
        CLANG # Clang 7
        sbr:707372498 FOR LINUX # In 942524429 and 958916803 llvm-link does not run.
        sbr:942053644 FOR DARWIN
        sbr:1006151596 FOR WIN32 # Generated by ./clang-windows.sh 7.1.0
    )
ENDIF()

END()
