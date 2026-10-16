import std/options
import std/strformat
import std/macros

# Elements
type    
  Element = ref object of RootObj
    id: Option[string] = none(string)
    class: Option[string] = none(string)

  Rect = ref object of Element
    x, y: Option[int32] = none(int32)
    width, height: Option[int32] = none(int32)
    fill: Option[string] = none(string)
    stroke: Option[string] = none(string)
    strokeWidth: Option[int32] = none(int32)

  Circle = ref object of Element
    cx, cy, r: Option[int32] = none(int32)
    fill: Option[string] = none(string)
    stroke: Option[string] = none(string)
    strokeWidth: Option[int32] = none(int32)

  Line = ref object of Element
    x1, y1, x2, y2: Option[int32] = none(int32)
    stroke: Option[string] = none(string)
    strokeWidth: Option[int32] = none(int32)

  Text = ref object of Element
    content: string
    x, y, dx, dy: Option[int32] = none(int32)
    rotate: Option[int32] = none(int32) # this should be a list
    lengthAdjust: Option[int32] = none(int32)
    textLength: Option[int32] = none(int32)
    fill: Option[string] = none(string)
    

# Attributes
macro genSetters(T: typedesc): untyped =
  result = newStmtList()
  let sym = T.getTypeInst[1]          # the type's symbol, e.g. Rect
  var obj = sym.getImpl[2]            # the type's definition
  if obj.kind == nnkRefTy: obj = obj[0]
  for defs in obj[2]:                 # RecList of IdentDefs
    let ty = defs[^2]
    if ty.kind == nnkBracketExpr and ty[0].eqIdent("Option"):
      let inner = ty[1]
      for i in 0 ..< defs.len - 2:
        var n = defs[i]
        if n.kind == nnkPostfix: n = n[1]   # exported field `x*`
        let fname = ident(n.strVal)
        result.add quote do:
          proc `fname`*[S: `sym`](e: S, v: `inner`): S {.discardable.} =
            e.`fname` = some(v)
            e
            
genSetters(Element)
genSetters(Rect)
genSetters(Circle)
genSetters(Line)
genSetters(Text)
  
proc attrs[T: object](x: T): string =
  for name, val in x.fieldPairs:
    when val is Option:
      if val.isSome:
        result.add " " & name & "=\"" & $val.get & "\""

proc attrs[T: ref object](x: T): string {.inline.} =
  attrs(x[])


# Shape constructors
func rect*(x, y: int32): Rect =
  Rect(x: some(x), y: some(y))

func circle*(cx, cy, r: int32): Circle =
  Circle(cx: some(cx), cy: some(cy), r: some(r))

func line*(x1, y1, x2, y2: int32): Line =
  Line(x1: some(x1), y1: some(y1), x2: some(x2), y2: some(y2))

func text*(content: string): Text =
  Text(content: content)
  
func text*(content: string, x, y: int32): Text =
  Text(content: content, x: some(x), y: some(y))
  
# Emit
func emit*(e: Rect): string =
  fmt"<rect" & attrs(e) & "></rect>"

func emit*(e: Circle): string =
  "<circle" & attrs(e) & "></circle>"

func emit*(e: Line): string =
  "<line" & attrs(e) & "></line>"

func emit*(e: Text): string =
  "<text" & attrs(e) & ">" & e.content & "</text>" 
