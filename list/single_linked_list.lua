
--utilities
local function readFile(file_path)
    local array = {}
    local f = io.open(file_path, "r")
    if f then
        for line in f:lines() do
            table.insert(array, line)
        end
    else
        print("File " .. file_path .. "could not be opened");
    end
    
    return array
end


--public IFs
local List = {
    new,    --creates new list
    load,   --loads list from a file
    reverse,--reverses the elements of the list
    insert, --inserts 1 element in the list
    delete, --deletes 1 element from the list
    append, --appends a list to the current list (assumes same format)
    search, --searches for a value in the list
    get,    --returns element on a specified pos
    size,   --returns size of the list
    print   --prints the contents of the list in the console
}

function List.new()
    local list = {next=nil, value=nil}
    return list
end

function List.load(list, filename)
    local array = readFile(filename)
    
    local firstList = list --remember reference to first element in list
    for i,v in ipairs(array) do
        if array[i+1] then
            local elem = {next=nil, value=array[i+1]}
            list.next = elem
            list.value = v
            list = list.next
        end
    end

end

function List.reverse(list)
 local l = list
 local lookAhead1
 local lookAhead2
 while l do
   if not lookAhead1 then --handle last element
    lookAhead1 = {next=nil, value=nil}
    lookAhead1.value = l.value
   else
    lookAhead2 = {next=nil, value=nil}
    lookAhead2.value = l.value
    lookAhead2.next = lookAhead1
    lookAhead1 = lookAhead2
   end
  l = l.next
 end
 list.next = lookAhead1.next
 list.value = lookAhead1.value
end

--0-based index
function List.insert(list, element, pos)
    if type(element) == "table" and 
        element and 
        element.value and
        pos >= 0 and
        list 
        then
        
        local l = list
        if List.size(l) < pos then
            --insert at the end
            while l do
                if l.next then
                    l = l.next
                else
                    l.next = element
                    break
                end
            end
        else
            --search for pos and insert
            if pos == 0 then
                --temp element to avoid circular reference in list
                local tempElem = {}
                tempElem.next = l.next
                tempElem.value = l.value
            
                list.value = element.value
                list.next = tempElem
            else
                prev = List.get(l, pos-1)
                if prev then
                    after = prev.next
                    prev.next = element
                    element.next = after
                end 
            end
        end
    else
        print("List.insert: element to be inserted is not valid" )
    end
end

function List.delete(list, pos)
    if pos >= 0 and
      List.size(list) > pos then
        local counter = 0
        local l = list
        local prev = nil
        while l do
            if counter == pos then
                if prev then
                    prev.next = l.next
                else
                    list.value = list.next.value
                    list.next = list.next.next --first element deleted -> alter original list
                end
                break;
            else
                prev = l
                l = l.next
                counter = counter + 1
            end
        end
    else
        print("List.delete: invalid parameters")  
    end
end

function List.append(list, list1)
    local l = list
    if not list1 or
        not list then --check if lists are valid
        return
    end
    while l do
        if l.next then
            l = l.next
        else
            l.next = list1
            break
        end
    end
end 

function List.search(list, value)
    local l = list
    while l do
        if l.value and
            l.value == value
            then
           return true 
        end
        l = l.next
    end
    return false
end

--0-based index
function List.get(list, pos)
    local l = list
    local counter = 0
    while l do
        if pos == counter then
            break
        else    
            l = l.next
            counter = counter +1
        end
    end
    return l
end

function List.size(list)
    local l = list
    local iSize = 0
    while l do
        l = l.next
        iSize = iSize + 1
    end
    return iSize
end

function List.print(list)
    local l = list
    local counter = 0
    while l do
        print(counter .. " " .. l.value)
        l = l.next
        counter = counter + 1
    end
end

return List