# Package

version       = "0.1.0"
author        = "Tommy McMichen"
description   = "Diagram as code, with less pain"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["scrawl"]


# Dependencies

requires "nim >= 2.2.12"

task watch, "Watch files and rebuild automatically":
  exec "watchexec -e nim -- nimble build"
