--require("list/single_linked_list.lua")

root_path="/home/jci/Playground/Lua/"
file_name="test_file.txt"

local function main()

    List = require "list.single_linked_list" 
    myList = List:new()
    file_path = root_path .. file_name
    print("main: " .. file_path)
    print("main: " .. type(file_path))
    List.load(myList, file_path)
    
    print("-----------------------------")
    print("List original contents:")
    List.print(myList)
    --test reverse operation
    print("-----------------------------")
    List.reverse(myList)
    
    print("List reversed contents:")
    List.print(myList)
    --test size operation
    print("List size: " ..List.size(myList) )
    
    --test insertion of elements
    print("-----------------------------")
    newElement = {next=nil, value="I'm a lamp post" }
    newFirstElement = {next=nil, value="I'm the first element" }
    newLastElement = {next=nil, value="I'm the last element" }
    List.insert(myList, newElement, 2)
    List.insert(myList, newLastElement, 100)
    List.insert(myList, newFirstElement, 0)
    print("New List - insert:")
    List.print(myList)
    
    --test deletion of elements
    print("-----------------------------")
    List.delete(myList, 3) --delete element in the middle
    List.delete(myList, 0) --delete first elem
    List.delete(myList, 77) --out of bounds param
    List.delete(myList, List.size(myList)-1) --delete last elem
    print("New List - delete:")
    List.print(myList)
    
    --test append a new list
    print("-----------------------------")
    listBoundary = {next=nil, value ="-----" }
    List.insert(myList, listBoundary, 100) --just to know when the list is finished
    newList = {next={next={next=nil, value="elem3"}, value="elem2"}, value="elem1"}
    
    print("New List - append:")
    List.append(nil, nil)
    List.append(myList, nil)
    List.append(nil, newList)
    List.append(myList, newList)
    List.print(myList)
    
    --test search
    print("-----------------------------")
    searchValue = "-----"
    print("Valid search: ")
    print( List.search(myList, searchValue) )
    print("Invalid search: ")
    print( List.search(myList, "aaa") )
    print("Invalid params: ")
    print( List.search(nil, "aaa") )
end

package.path = package.path .. ";" .. "/home/jci/Playground/luamplm/list/single_linked_list.lua"
main()