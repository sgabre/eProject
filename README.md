# Embedded Software Project Template


## Goals

- Provide a ready-to-use embedded software project skeleton
- Support **cross-platform development**: Windows, macOS, Linux
- Support multiple **ARM Cortex targets**: CM0, CM3, CM4
- Enable **CI/CD** with GitHub Actions, including builds, tests, and documentation
- Include **basic example applications** (Blinky, Tracy, Shelly, Faulty, etc.)
- Generate **Doxygen documentation** for each module or globally
- Prepare **CMSIS Software Pack (BSP) generation** per module and per board
- Compatible with **VSCode, STM32CubeIDE, and standard CMake**
- Support **CMake & CMake Presets** for flexible build configurations
- Provide **versioning and revision tracking**, including module-level versions
- Support **software development and test environment installation**
- Implement **ISTQB-level testing**, covering unit, integration, and regression tests
- Ensure **module portability**, with modules buildable as **DLLs or static libraries** for host and **static libraries** for target
- Provide **hardware abstraction layers** and standardized interfaces for modules and drivers
- Maintain **clear separation** between board-specific and application-specific files

### Deployment
- **Field Deployment**
  - Bootloader-based update flow (BOOTABLE / STANDALONE modes)
  - Generate **signed, versioned firmware images**  
  - Support OTA (Over-The-Air) and wired flashing deployment
  - Provide deployment scripts (deploy.sh, update.py) for automation 
  - Version & revision tracking for deployed devices  

- **Production Deployment**
  - Secure artifact repository (e.g. GitHub Releases, Artifactory) as a **single source of truth**
  - **Release tagging & changelog generation** for production-ready builds
  - **Cryptographic signing** and integrity verification of firmware
  - **Production flashing tools** with safety checks (preventing downgrade, wrong-target flash)
  - **OTA pipeline** or wired production line tools for mass flashing
  - **Audit trail**: which firmware version was deployed, when, and to which device batch
  - **Fail-safe update mechanism**: dual-bank or rollback support for critical devices
---

## Directory Structure

```txt
EmbeddedProject/
├── .cmake/
│   ├── Toolchains/
│   │   ├── arm-cm0.cmake
│   │   ├── arm-cm3.cmake
│   │   └── arm-cm4.cmake
│   ├── Modules.cmake
│   └── Presets/
├── docs/
│   └── Doxygen/
├── Firmwware
│   ├── Applications/
│   │   ├── CMakeLists.txt
│   │   ├── Sample/
│   │   │   ├── CMakeLists.txt
│   │   │   └── main.c
│   │   ├── Blinky/
│   │   │   ├── CMakeLists.txt
│   │   │   ├── BOOTABLE-stm32f401xe-FLASH.ld       right place ?
│   │   │   ├── STANDALONE-stm32f401xe-FLASH.ld     right place ?
│   │   │   ├── BOOTABLE-stm32f401xe-RAM.ld         right place ?
│   │   │   ├── STANDALONE-stm32f401xe-RAM.ld       right place ?    
│   │   │   └── main.c
│   │   ├── Booty/
│   │   │   ├── CMakeLists.txt
│   │   │   ├── main.c
│   │   │   └── STANDALONE-stm32f401xe-FLASH.ld     right place ?
│   │   ├── Tracy/
│   │   │   ├── CMakeLists.txt
│   │   │   └── main.c
│   │   ├── Shelly/
│   │   │   ├── CMakeLists.txt
│   │   │   └── main.c
│   │   └── Faulty/
│   │   │   ├── CMakeLists.txt
│   │   │   └── main.c
│   ├── Middlewares/
│   │   ├── CMakeLists.txt
│   │   ├── Module1/
│   │   │   ├── CMakeLists.txt
│   │   │   ├── CMakePresets.json
│   │   │   ├── Module_Config.h/
│   │   │   ├── iModule.h/
│   │   │   ├── Module.h/
│   │   │   ├── cModule.h/
│   │   │   ├── iModule.c/
│   │   │   ├── Module.c/
│   │   │   └── cModule.c/
│   │   └── Module-x/
│   ├── Boards/
│   │   └── BoardName/
│   │       ├── CMakeLists.txt
│   │       ├── CMakePresets.json
│   │       ├── .cmake
│   │       └── CMSIS/
│   │           └── Drivers/
│   │               ├── iBoard/
│   │               │    ├── iBoard.h/
│   │               │    ├── Board.h/
│   │               │    ├── iBoard.c/
│   │               │    └── Board.c/
│   │               ├── iButton/
│   │               │    ├── iButton.h/
│   │               │    ├── Button.h/
│   │               │    ├── iButton.c/
│   │               │    └── Button.c/
│   │               ├── iLed/
│   │               │    ├── iLed.h/
│   │               │    ├── Led.h/
│   │               │    ├── iLed.c/
│   │               │    └── Led.c/
│   │               ├── iBuzzer/
│   │               │    ├── iBuzzer.h/
│   │               │    ├── Buzzer.h/
│   │               │    ├── iBuzzer.c/
│   │               │    └── Buzzer.c/
│   │               └── iMemory/
│   │               │    ├── iMemory.h/
│   │               │    ├── Memory.h/
│   │               │    ├── iMemory.c/
│   │               │    └── Memory.c/
│   │               └── startup/
│   │               │   ├── Bootable-stm32f401xe-Startup.s
│   │               │   └── Standalone-stm32f401xe-Startup.s
│   │               └── linker/
│   │                   ├── BOOTABLE-stm32f401xe-FLASH.ld
│   │                   ├── STANDALONE-stm32f401xe-FLASH.ld
│   │                   ├── BOOTABLE-stm32f401xe-RAM.ld
│   │                   └── STANDALONE-stm32f401xe-RAM.ld 
│   └── Libraries/
│       ├── BoardName/
│       │   ├── CMakeLists.txt
│       │   │   └── Board.h or iBoard.h
│       │   │   ├── iDriver x.h
│       │   ├── lib/
│       │   │   ├── libBoardName.a
│       │   │   └── libBoardName-debug.a
│       │   ├── startup/
│       │   │   ├── Bootable-stm32f401xe-Startup.s       right place ?
│       │   │   └── Standalone-stm32f401xe-Startup.s    right place ?
│       │   └── linker/
│       │       ├── BOOTABLE-stm32f401xe-FLASH.ld       right place ?
│       │       ├── STANDALONE-stm32f401xe-FLASH.ld     right place ?
│       │       ├── BOOTABLE-stm32f401xe-RAM.ld         right place ?
│       │       └── STANDALONE-stm32f401xe-RAM.ld       right place ?   
│       └── Shell/
│           ├── CMakeLists.txt
│           │   └── Shell.h
│           └── lib/
│               ├── libShell.a
│               └── libShell-debug.a
├── tests/
├── Unity/          #Git Sub-Module
├── scripts/
│   ├── build.sh
│   ├── ci_build.sh
│   └── gen_pack.sh
├── .github/
│   └── workflows/
│       └── ci.yml
├── CMakeLists.txt
├── CMakePresets.json
└── README.md
```

---

## Epics

* EPIC-001: Software Development Environment Setup
* EPIC-002: Software Test Environment Setup
* EPIC-003: Sample CMake
* EPIC-004: Documenatations
* EPIC-005: CI/CD
* EPIC-006: ISTQB Test Level
* EPIC-007: Basic eApplications
* EPIC-008: Docker/Kubernetes
* EPIC-009: IDE
* EPIC-010: Test Data
* EPIC-011: CMake Host
* EPIC-012: CMake Target
* EPIC-013: Coverage Host
* EPIC-014: Coverage Target
* EPIC-015: Metrics/Code Quality
* EPIC-016: Dashboards


# Command-In-Line Memento

List all configuration

```bash
cmake --list-presets 
```

Configure

```bash
cmake --preset Debug 
```

Build Configuration

```bash
cmake --build --preset Debug 
```

# EPIC-003: Sample CMake

## File Architectures

```txt
.
├── CMakeLists.txt
├── CMakePresets.json
├── Firmware
│   ├── Applications
│   │   ├── CMakeLists.txt
│   │   └── Sample
│   │       ├── CMakeLists.txt
│   │       └── main.c
│   └── CMakeLists.txt
├── LICENSE
├── README.md
└── scripts
    └── build.sh
```