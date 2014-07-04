##XML-To-LuaTable

A Lua module that converts XML to lua tables with named properties and children. You can access the different nodes using the dot notation and the node name. 


### Usage

```lua
local xml2lua = require("xml2lua")

-- The magic happens here:
rootNode = xml2lua.loadFile("test.xml")

-- We can now access the nodes with dot notation and their names

-- This will print all node values from the xml in order
print(rootNode.prop1)
print(rootNode.prop2)

print(rootNode.first[1].a)
print(rootNode.first[1].b)
print(rootNode.first[1].c)

print(rootNode.first[2].a)
print(rootNode.first[2].b)

print(rootNode.cheese[1])
print(rootNode.cheese[2])
print(rootNode.cheese[3])
print(rootNode.cheese[4])
```
	
### Sample XML

```xml
<?xml version="1.0" encoding="utf-8"?>

<!-- Sample XML for testing -->
<rootNode prop1="Property One" prop2="Property Two">

  <first>
    <a>A VALUE</a>
    <b>B VALUE</b>
    <c>C VALUE</c>
  </first>

  <first>
    <a>A VALUE</a>
    <b>B VALUE</b>
  </first>

  <cheese>QUESO1</cheese>
  <cheese>QUESO2</cheese>
  <cheese>QUESO3</cheese>
  <cheese>QUESO4</cheese>

</rootNode>  
```


