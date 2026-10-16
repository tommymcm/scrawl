import unittest

import scrawl/svg
test "SVG rect":
  # default constructor
  check emit(rect(10, 20)) == """<rect x="10" y="20"></rect>"""
  # sized constructror
  check emit(rect(10, 20).width(30).height(40)) == """<rect x="10" y="20" width="30" height="40"></rect>"""
  # colored constructor
  check emit(rect(10, 20).fill("red").stroke("0x010203")) == """<rect x="10" y="20" fill="red" stroke="0x010203"></rect>"""

test "SVG circle":
  # default constructor
  check emit(circle(10, 20, 5)) == """<circle cx="10" cy="20" r="5"></circle>"""
  # color constructor
  check emit(circle(10, 20, 5).fill("red").stroke("blue")) == """<circle cx="10" cy="20" r="5" fill="red" stroke="blue"></circle>"""

test "SVG line":
  # default constructor
  check emit(line(1, 2, 3, 4)) == """<line x1="1" y1="2" x2="3" y2="4"></line>"""
  # default constructor
  check emit(line(1, 2, 3, 4).stroke("red")) == """<line x1="1" y1="2" x2="3" y2="4" stroke="red"></line>"""

test "SVG text":
  # default constructor
  check emit(text("foo")) == """<text>foo</text>"""
  # location constructor
  check emit(text("bar", 10, 20)) == """<text x="10" y="20">bar</text>"""
  # with attributes
  check emit(text("baz").fill("red")) == """<text fill="red">baz</text>"""
  
