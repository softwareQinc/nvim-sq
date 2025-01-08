-- CMake templates

local ls = require("luasnip")
local rep = require("luasnip.extras").rep

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- CMakeLists.txt minimal template
ls.add_snippets("cmake", {
   s({
      trig = "cmake_template_minimal",
      name = "CMakeLists.txt minimal template",
      dscr = "CMakeLists.txt minimal template, no unit testing",
   }, {
      t({ "cmake_minimum_required(VERSION " }),
      i(1, "3.20"),
      t({ ")" }),
      t({ "", "project(" }),
      i(2, "ProjectName"),
      t({ ")", "" }),
      t({ "set(CMAKE_CXX_STANDARD " }),
      i(3, "20"),
      t({ ")", "" }),
      t({ "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)", "", "" }),
      t({ "add_executable(" }),
      i(4, "ExecutableName"),
      t({ " " }),
      i(5, "src"),
      t({ "/" }),
      i(6, "main.cpp"),
      t({ ")", "", "# Add additional CMake commands below" }),
   }),
})

-- CMakeLists.txt typical template
ls.add_snippets("cmake", {
   s({
      trig = "cmake_template",
      name = "CMakeLists.txt template",
      dscr = "CMakeLists.txt template, with unit testing",
   }, {
      t({ "cmake_minimum_required(VERSION " }),
      i(1, "3.20"),
      t({ ")" }),
      t({ "", "project(", "  " }),
      i(2, "ProjectName"),
      t({ "", "  VERSION " }),
      i(3, "0.1"),
      t({ "", '  DESCRIPTION "' }),
      i(4, "Project description"),
      t({ '"', "  LANGUAGES CXX)", "" }),
      t({ "set(CMAKE_CXX_STANDARD " }),
      i(5, "20"),
      t({ ")", "" }),
      t({ "set(CMAKE_CXX_STANDARD_REQUIRED ON)", "" }),
      t({ "set(CMAKE_CXX_EXTENSIONS OFF)", "" }),
      t({ "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)", "" }),
      t({ "# set(CMAKE_BUILD_TYPE Debug)", "", "" }),
      t({ "enable_testing()", "", "" }),
      t({ "include_directories(" }),
      i(6, "include"),
      t({ ")", "", "" }),
      t({ 'set(SRC_DIR "${CMAKE_SOURCE_DIR}/' }),
      i(7, "src"),
      t({ '")', 'file(GLOB_RECURSE SOURCES "${SRC_DIR}/*.cpp")', "", "" }),
      t({ 'set(APP_MAIN_FILE "${CMAKE_SOURCE_DIR}/' }),
      i(8, "app/main.cpp"),
      t({ '")', "", "" }),
      t({ "add_executable(" }),
      i(9, "ExecutableName"),
      t({ " ${SOURCES} ${APP_MAIN_FILE})", "", "" }),
      t({ "# add_subdirectory(${CMAKE_SOURCE_DIR}/" }),
      i(10, "unit_tests/"),
      t({ " EXCLUDE_FROM_ALL SYSTEM)", "", "" }),
      t({ "# Add additional CMake commands below" }),
   }),
})

-- CMakeLists.txt GoogleTest template
ls.add_snippets("cmake", {
   s({
      trig = "cmake_template_gtest",
      name = "CMakeLists.txt GoogleTest template",
      dscr = "CMakeLists.txt GoogleTest template, with multiple test files",
   }, {
      t({ "include(GoogleTest)", "" }),
      t({ 'set(TARGET_NAME "unit_tests")', "" }),
      t({ "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)", "", "" }),
      t({
         "include(FetchContent)",
         'message(STATUS "Fetching GoogleTest...")',
         "",
      }),
      t({ "FetchContent_Declare(", "" }),
      t({ "  googletest", "" }),
      t({ "  GIT_REPOSITORY https://github.com/google/googletest.git", "" }),
      t({ "  GIT_TAG main", "" }),
      t({ "  GIT_SHALLOW TRUE", "" }),
      t({ "  GIT_PROGRESS TRUE)", "" }),
      t({ "FetchContent_MakeAvailable(googletest)", "", "" }),
      t({ 'file(GLOB_RECURSE SOURCES "' }),
      i(1, "../src"),
      t({ '/*.cpp")', "", "" }),
      t({ "aux_source_directory(" }),
      i(2, "src"),
      t({ " TEST_FILES)", "", "" }),
      t({ "add_executable(${TARGET_NAME} EXCLUDE_FROM_ALL " }),
      rep(2),
      t({ "/" }),
      i(3, "main.cpp"),
      t({ " ${SOURCES})", "", "" }),
      t({ "foreach(file ${TEST_FILES})", "" }),
      t({ "  target_sources(${TARGET_NAME} PUBLIC ${file})", "" }),
      t({ "endforeach()", "", "" }),
      t({ "target_link_libraries(${TARGET_NAME} PUBLIC gmock)", "" }),
      t({ "gtest_discover_tests(${TARGET_NAME})" }),
   }),
})
