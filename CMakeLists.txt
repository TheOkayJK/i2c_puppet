cmake_minimum_required(VERSION 3.13)

set(PICO_PLATFORM "rp2040")
set(PICO_BOARD_HEADER_DIRS ${CMAKE_CURRENT_LIST_DIR}/boards)

include(3rdparty/pico-sdk/pico_sdk_init.cmake)

project(i2c_puppet)

pico_sdk_init()

add_subdirectory(app)

add_definitions(-DUSE_TINYUSB)
add_definitions(-DUSB_PRODUCT="Pico Keyboard")
add_definitions(-DARDUINO_ARCH_RP2040)
add_definitions(-DCFG_TUSB_CONFIG_FILE="includes/tusb_config.h")

include_directories(includes
    3rdparty/TinyUSB_Mouse_and_Keyboard
    3rdparty/Adafruit_TinyUSB_Arduino/src
)

# remove Adafruit tinyusb library code so that only the pico-sdk tinyusb code is used
# to restore, cd Adafruit_TinyUSB_Arduino/ && git checkout HEAD .
file(REMOVE Adafruit_TinyUSB_Arduino/src/tusb.c)
file(REMOVE Adafruit_TinyUSB_Arduino/src/tusb.h)
file(REMOVE Adafruit_TinyUSB_Arduino/src/tusb_option.h)
file(REMOVE_RECURSE Adafruit_TinyUSB_Arduino/src/osal/)
file(REMOVE_RECURSE Adafruit_TinyUSB_Arduino/src/portable/)
file(REMOVE_RECURSE Adafruit_TinyUSB_Arduino/src/device/)
file(REMOVE_RECURSE Adafruit_TinyUSB_Arduino/src/common/)
file(REMOVE_RECURSE Adafruit_TinyUSB_Arduino/src/class/)

# binary info in flash
pico_set_program_name(i2c_puppet "I2C Puppet")
pico_set_program_version(i2c_puppet "0.1")

# printf targets
#pico_enable_stdio_usb(i2c_puppet 1)
pico_enable_stdio_uart(i2c_puppet 1)
