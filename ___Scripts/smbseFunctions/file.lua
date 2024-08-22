local smbseFunctionsFile = {}

local inspect = require("ext/inspect")

smbseFunctionsFile.resolvePaths = {
    Misc.levelPath(),
    Misc.episodePath(),
    getSMBXPath().."\\scripts\\",
    getSMBXPath().."\\",
    Misc.episodePath().."\\scripts\\",
    Misc.episodePath().."\\_OST\\",
    Misc.episodePath().."\\_OST\\_Sound Effects\\",
}

-- Read and write variables for functions related to those
smbseFunctionsFile.read = {}
smbseFunctionsFile.write = {}

-- Resolves a file like Misc.resolveFile, but also includes additional episode directories. It also checks for if the file exists, otherwise the output will be nil.
function smbseFunctionsFile.resolve(path)
    local finalOutput
    local pathSlashesResolved = string.gsub(path, "/", "\\")
    
    for k,fold in ipairs(smbseFunctionsFile.resolvePaths) do
        local dirToFile = string.gsub(pathSlashesResolved, "/", "\\")
        if io.exists(dirToFile) then
            finalOutput = dirToFile
        end
    end
    
    return finalOutput
end

-- Reads everything from a file using io, and returns the output containing the entire file in text.
function smbseFunctionsFile.read.all(name)
    local nameResolved = Misc.resolveFile(name)

    if nameResolved == nil then
        error("Invalid file! Is the filename correct?/r/rFilename specified: "..name)
        return
    end

    local nameFile = io.open(nameResolved, "r")

    if nameFile == nil then
        return
    end

    SMBSE.Functions.SendToConsole("The file \""..name.."\"'s entire file was just read.")

    local finalOutput = nameFile:read("*all")
    nameFile:close()

    return finalOutput
end

-- Reads one line (Or more from a table) from a file using io, and returns the output containing the singular (Or multi) text from the line(s).
function smbseFunctionsFile.read.line(name, lineNumber)
    local nameResolved = Misc.resolveFile(name)

    if nameResolved == nil then
        error("Invalid file! Is the filename correct?/r/rFilename specified: "..name)
        return
    end

    local nameFile = io.open(nameResolved, "r")

    if nameFile == nil then
        return
    end

    -- Single line value
    if type(lineNumber) == "number" then
        local finalOutput = nameFile:read(lineNumber)
        nameFile:close()
        SMBSE.Functions.SendToConsole("A line from the file \""..name.."\" was recently read. Line number: "..tostring(lineNumber))
        return finalOutput
    -- Multiple line values
    elseif type(lineNumber) == "table" then
        local finalOutput = {}
        local finalOutputCount = 0
        local lineNumberMapped

        -- We'll need to get a table.map of the numbers, so do this
        for i = 1,#lineNumber do
            local lineTableNum = lineNumber[i]
            lineNumberMapped[lineTableNum] = true
        end

        -- Now let's get all the lines from the file, then if any line number matches our mapped table, add it to the final output
        for number, line in ipairs(nameFile:lines()) do
            if lineNumberMapped[number] then
                finalOutputCount = finalOutputCount + 1
                finalOutput[finalOutputCount] = line
            end
        end

        -- Close the file
        nameFile:close()

        -- Add info about the file read to the verbose console
        SMBSE.Functions.SendToConsole("Many lines from the file \""..name.."\" were recently read. Line count: "..tostring(finalOutputCount)..", Line numbers: "..inspect(lineNumber))

        -- Finally, return the final output
        return finalOutput
    end
end

-- Writes whatever is on the text argument to a file using io, replacing the entire file with the text specified. THIS WILL OVERWRITE FILE DATA, SO IF YOU'RE NOT CAREFUL THEN WELL... YOU'RE SCREWED
function smbseFunctionsFile.write.all(name, text)
    local nameResolved = Misc.resolveFile(name)

    if nameResolved == nil then
        error("Invalid file! Is the filename correct?/r/rFilename specified: "..name)
        return
    end

    local nameFile = io.open(nameResolved, "w")

    if nameFile == nil then
        return
    end

    nameFile:write(tostring(text))
    nameFile:close()

    SMBSE.Functions.SendToConsole("The file \""..name.."\" was overwritten with the following text: "..text)
end

-- Writes whatever is on the text argument to a file using io, replacing only one line (Or multiple lines) to a file with the text specified. THIS WILL OVERWRITE SOME FILE DATA, SO IF YOU'RE NOT CAREFUL THEN WELL... YOU'RE SCREWED
function smbseFunctionsFile.write.line(name, lineNumber, text)
    local nameResolved = Misc.resolveFile(name)

    if nameResolved == nil then
        error("Invalid file! Is the filename correct?/r/rFilename specified: "..name)
        return
    end

    local nameFile = io.open(nameResolved, "a")

    if nameFile == nil then
        return
    end

    -- Single line
    if type(lineNumber) == "number" then
        -- Seek to the line we're trying to write to
        nameFile:seek("cur", lineNumber)
        -- Overwrite the line
        nameFile:write(tostring(text))
        -- Close the file
        nameFile:close()
        -- Verbose info
        SMBSE.Functions.SendToConsole("A line in the file \""..name.."\" was overwritten with new text. Line number: "..tostring(lineNumber)..", Text: "..text)
    -- Multiple lines, one text value only
    elseif type(lineNumber) == "table" and not type(text) == "table" then
        local finalOutput = {}
        local finalOutputCount = 0
        local lineNumberMapped

        -- We'll need to get a table.map of the numbers, so do this
        for i = 1,#lineNumber do
            local lineTableNum = lineNumber[i]
            lineNumberMapped[lineTableNum] = true
        end

        -- Now let's get all the lines from the argument, then if any line number matches our mapped table, overwrite the lines specified with the text we're overwriting it to
        for index, number in ipairs(lineNumber) do
            if lineNumberMapped[number] then
                -- Seek to the line we're trying to write to
                nameFile:seek("cur", number)
                -- Overwrite the line
                nameFile:write(tostring(text))
            end
        end

        -- Close the file
        nameFile:close()

        -- Add info about the file read to the verbose console
        SMBSE.Functions.SendToConsole("Many lines from the file \""..name.."\" were recently written to. Line count: "..tostring(finalOutputCount)..", Line numbers: "..inspect(lineNumber)..", Text: "..text)

        -- Finally, return the final output
        return finalOutput
    -- Multiple lines, with multiple text values
    elseif type(lineNumber) == "table" and type(text) == "table" then
        
    end
end

return smbseFunctionsFile