
--[[-----------------------------
		xml2lua.lua
---------------------------------
 Author:    Jose Llausas
 Email:     jose@josellausas.com
 Created:   Jul 4, 2014
 Purpose:   A Lua module that takes XML and converts it to a Lua table, 
 			using the child names as table members. 
 ]]

local xml = require("xml").newParser()

-- Returns true if array is a table with consecutive numeric indices
local function isArray(array)
	for k, _ in pairs(array) do
        if type(k) ~= "number" then
            return false
        end
    end
    return true --Found nothing but numbers !
end

local function buildTree(node_root)
	local node = node_root

	-- Return the value if node is a leaf
	if #node.child < 1 then
		return node.value
	end

	-- The luaDict that we are building
	local nodeObj = {}

	-- Store properties if any
	for key,value in pairs(node.properties) do
		nodeObj[key] = value
	end

	-- Build a tree with children
	for key,value in ipairs(node.child) do
		local childNode = value

		-- Recursive magic happens here
		if (nodeObj[childNode.name] == nil) then
			nodeObj[childNode.name] = buildTree(childNode) 
		elseif (type(nodeObj[childNode.name]) ~= "table") then
			--[[ This happens when it finds there is already a member with that name,
				 We convert to an array and append this new table ]]
			local oldObject = nodeObj[childNode.name]

			-- Create an array
			nodeObj[childNode.name] = {}

			-- Insert the tables
			table.insert(nodeObj[childNode.name], oldObject)
			table.insert(nodeObj[childNode.name], buildTree(childNode))
		elseif (isArray(nodeObj[childNode.name])) then
			-- The array is good to keep storing elements with the same name
			table.insert(nodeObj[childNode.name], buildTree(childNode))
		else
			-- We need an array of dicts
			local oldObject = nodeObj[childNode.name]
			nodeObj[childNode.name] = {}
			table.insert(nodeObj[childNode.name], oldObject)
			table.insert(nodeObj[childNode.name], buildTree(childNode))
		end
	end

	return nodeObj
end

-- The module
local m = {}

function m.loadXML(xml_text)
	local root = buildTree(xml_text)
	return root
end

function m.loadFile(filepath)
	local fileContents = xml:loadFile(filepath)

	return m.loadXML(fileContents)
end

function m.loadURL(url)

end

return m