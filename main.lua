--[[-----------------------------
            main.lua
---------------------------------
 Author:    Jose Llausas
 Email:     jose@josellausas.com
 Created:   Jul 4, 2014
 Purpose:   Entry point for xml2lua examples 

 To access the nodes, you use the dot notation on the rootNode and access the children and properties by name.
 If there is more than one child node with the same name, it will be stored in a numeric-indexed array.
 
 Example: To access 'C VALUE' from the node '<a>' inside of the first '<first>' node:
      value = rootNode.first[1].c  -- This will return 'C VALUE'
      value = rootNode.first[2].c  -- This will return nil
 
 Notes: The test XML looks like this:
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
 ]]

local xml2lua = require("xml2lua")
local rootNode = xml2lua.loadFile('test.xml')

-- Acces node's properties by name
print(rootNode.prop1)
print(rootNode.prop2)

-- Loop each child named 'first'
for i=1, #rootNode.first do
    local childNode = rootNode.first[i]

    -- Loop the child's nodes and print their values
    for k,v in pairs(childNode) do
        print(k,v)
    end
end

-- Acess the first cheese:
print(rootNode.cheese[1])

-- Loop each child named 'cheese'
for i=1, #rootNode.cheese do
    print(rootNode.cheese[i])
end