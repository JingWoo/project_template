option(BUILD_TESTS       "Build test executable"      OFF)
option(BUILD_EXAMPLES    "Build examples"             OFF)
option(GEN_DOCS          "Generate documentation"     OFF)
option(ENABLE_COVERAGE   "Enable code coverage"       OFF)
option(ENABLE_DEBUG      "Enable debug mode"          ON)
if (ENABLE_DEBUG STREQUAL "ON")
     add_definitions("-g -O2")
endif()

