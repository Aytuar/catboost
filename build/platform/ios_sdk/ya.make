RESOURCES_LIBRARY()



SET(NEED_PLATFORM_PEERDIRS no)

IF (ARCH_ARM7 OR ARCH_ARM64)
    # iOS SDK 11.1
    DECLARE_EXTERNAL_RESOURCE(IOS_SDK_ROOT sbr:421384278)
ELSEIF (ARCH_I386 OR ARCH_X86_64)
    # iOS Simulator SDK 11.1
    DECLARE_EXTERNAL_RESOURCE(IOS_SDK_ROOT sbr:421386221)
ELSE()
    MESSAGE(FATAL_ERROR "There is no iOS SDK for the selected target platform")
ENDIF()

# Apple C++ standard library headers are not in OS SDK but in Xcode toolchain
IF (USE_STL_SYSTEM)
    DECLARE_EXTERNAL_RESOURCE(XCODE_TOOLCHAIN_ROOT sbr:498971125)
    IF (OS_IOS)
        CFLAGS(
            GLOBAL -isystem GLOBAL $XCODE_TOOLCHAIN_ROOT_RESOURCE_GLOBAL/usr/include/c++/v1
            GLOBAL -isystem GLOBAL $XCODE_TOOLCHAIN_ROOT_RESOURCE_GLOBAL/usr/include
        )
    ENDIF()
ENDIF()

END()
