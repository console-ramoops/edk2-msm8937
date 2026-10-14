[Defines]
  PLATFORM_NAME                  = MSM8909Pkg
  PLATFORM_GUID                  = 28f1a3bf-193a-47e3-a7b9-5a435eaab2ee
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010019
  OUTPUT_DIRECTORY               = Build/$(PLATFORM_NAME)
  SUPPORTED_ARCHITECTURES        = AARCH64
  BUILD_TARGETS                  = DEBUG|RELEASE
  SKUID_IDENTIFIER               = DEFAULT
  FLASH_DEFINITION               = MSM8909Pkg/MSM8909Pkg.fdf

!include MSM8909Pkg/MSM8909Pkg.dsc

[PcdsFixedAtBuild.common]
  # System Memory (2GB: 0x80000000 - 0xFFFFFFFF)
  gArmTokenSpaceGuid.PcdSystemMemoryBase|0x80000000
  gArmTokenSpaceGuid.PcdSystemMemorySize|0x80000000

  # Framebuffer (720x1280x32bpp)
  # Source: arch/arm64/boot/dts/qcom/msm8940-xiaomi-santoni.dts lines 54-60 & 83-86
  gMSM8909PkgTokenSpaceGuid.PcdMipiFrameBufferAddress|0x90001000
  gMSM8909PkgTokenSpaceGuid.PcdMipiFrameBufferWidth|720
  gMSM8909PkgTokenSpaceGuid.PcdMipiFrameBufferHeight|1280
  gMSM8909PkgTokenSpaceGuid.PcdMipiFrameBufferVisibleWidth|720
  gMSM8909PkgTokenSpaceGuid.PcdMipiFrameBufferVisibleHeight|1280
  gMSM8909PkgTokenSpaceGuid.PcdMipiFrameBufferPixelBpp|32

  # Timer interrupts & frequency for MSM8937 / MSM8940
  # Source: arch/arm64/boot/dts/qcom/msm8917.dtsi lines 2213-2219 (PPI 3 = INTID 19, PPI 4 = INTID 20)
  # Source: arch/arm64/boot/dts/qcom/msm8940-xiaomi-santoni.dts line 584 (xo_board: 19.2MHz)
  gArmTokenSpaceGuid.PcdArmArchTimerIntrNum|19
  gArmTokenSpaceGuid.PcdArmArchTimerVirtIntrNum|20
  gArmTokenSpaceGuid.PcdArmArchTimerFreqInHz|19200000
