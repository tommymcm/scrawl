import unittest

import scrawl/svg
test "SVG rect":
  # default constructor
  check emitElement(rect(10, 20)) == "<rect x=\"10\" y=\"20\"></rect>"
  # sized constructror
  check emitElement(rect(10, 20).width(30).height(40)) == "<rect x=\"10\" y=\"20\" width=\"30\" height=\"40\"></rect>"
  # colored constructor
  check emitElement(rect(10, 20).fill("red").stroke("0x010203")) == "<rect x=\"10\" y=\"20\" fill=\"red\" stroke=\"0x010203\"></rect>"

