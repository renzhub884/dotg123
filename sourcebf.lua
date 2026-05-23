-- Obfuscator: Luraph v14.5.2

return ( function ( )
    local byteCodeHelper, subString, charHelper, patternReplace, repeatString, setMetaTable, pCall, typeHelper, toString, assertHelper, loadString, unPack, stringPack, emptyTable = string.byte, string.sub, string.char, string.gsub, string.rep, setmetatable, pcall, type, tostring, assert, loadstring, unpack, string.pack, { }
    for index = 0, 255 do
        emptyTable[index] = charHelper(index)
    end
    local loopCounter = 5
    do
        local initData = { 22414, { 0x1B, 0x4C, 0x75, 0x61, 0x50 }, toString(assertHelper) }
        for index, value in next, initData do
            local result = { pCall(assertHelper, index % 2 == 0 and charHelper(unPack(value)) or value, nil, nil) }
            if result[1] and pCall(result[2]) ~= not result[3] then
                loopCounter = 10.0
            end
        end
    end
    local stringData, stringOffset, stringResult = ( function ( inputString )
        inputString = patternReplace(inputString, "z", "!!!!!")
        return patternReplace(inputString, ".....", setMetaTable( { }, { __index = function ( table, index )
            local first, second, third, fourth, fifth = byteCodeHelper(index, 1, 5)
            local value = ( fifth - 33 ) + ( fourth - 33 ) * 85 + ( third - 33 ) * 7225 + ( second - 33 ) * 614125 + ( first - 33 ) * 52200625
            local result = stringPack(">I4", value)
            table[index] = result
            return result
        end } ))
    end )( subString( [=[...]=], 1 ) ) -- String literal preserved as per instructions
    
    local bitShiftHelper, bitMask = { [ 0 ] = 0 }, 0
    local totalElements = #stringData
    local getNextByte = function ( )
        bitMask = bitMask + 1
        return byteCodeHelper(stringData, bitMask, bitMask)
    end
    local bitState = 0
    for loopIndex = 1, 5 do
        bitState = bitState * 256 + getNextByte( )
    end
    local bitRegister = 0xFFFFFFFF
    local function readBits( count )
        local result = 0
        for i = count, 1, -1.0 do
            bitRegister = bitRegister / 2
            bitRegister = bitRegister - bitRegister % 1
            result = result * 2
            if not ( bitState < bitRegister ) then
                bitState = bitState - bitRegister
                result = result + 1
            end
            if bitRegister <= 0x00FFFFFF then
                bitRegister = bitRegister * 256
                bitState = bitState * 256 + getNextByte( )
            end
        end
        return result
    end
    local function processFlag( table, index )
        local weight, offset, power = table[ index ], bitRegister / 2048
        offset = offset - offset % 1
        local limit = offset * weight
        if bitState < limit then
            bitRegister = limit
            local calc = ( 2048 - weight ) / 32
            calc = calc - calc % 1
            weight = weight + calc
            power = 0
        else
            bitRegister = bitRegister - limit
            bitState = bitState - limit
            local calc = weight / 32
            calc = calc - calc % 1
            weight = weight - calc
            power = 1
        end
        table[ index ] = weight
        if bitRegister <= 0x00FFFFFF then
            bitRegister = bitRegister * 256
            bitState = bitState * 256 + getNextByte( )
        end
        return power
    end
    local function decodeValue( table, count, base )
        local result = 1
        for i = 1, count do
            result = result * 2 + processFlag( table, result )
        end
        return ( result - base )
    end
    local function rangeDecode( table, index, count )
        local total, multiplier = 0, 1
        for i = 0, count - 1 do
            local bit = processFlag( table, index + multiplier )
            multiplier = multiplier * 2 + bit
            total = total + bit * bitShiftHelper[ i ]
        end
        return total
    end
    local function bitwiseDecode( index, value )
        local pos = 1
        for i = 7, 0, -1.0 do
            local bit = ( value / bitShiftHelper[ i ] ) % 2
            bit = bit - bit % 1
            local target = processFlag( index, pos + ( bit * 256 ) + 256 )
            pos = pos * 2 + target
            if bit ~= target then
                while pos < 0x100 do
                    pos = pos * 2 + processFlag( index, pos )
                end
                break
            end
        end
        return ( pos % 256 )
    end
    local function getContext( flagTable, index )
        if processFlag( flagTable, 1 ) == 0 then
            return decodeValue( flagTable[ 3 ][ index ], 3, 8 )
        elseif processFlag( flagTable, 2 ) == 0 then
            return 8 + decodeValue( flagTable[ 4 ][ index ], 3, 8 )
        end
        return decodeValue( flagTable[ 5 ], 8, 256 ) + 16.0
    end
    local instructionPointer, outputBuffer, bufferIndex, pTable = 0, { [ 0 ] = 0 }, 0, { [ 0 ] = 0, 0, 0, 0, 1, 2, 3, 4, 5, 6, 4, 5 }
    local function initializeArray( size )
        local arr = { }
        for i = 0, size - 1 do
            arr[ i ] = 1024.0
        end
        return arr
    end
    local function initializeMatrix( rows, cols )
        local matrix = { }
        for r = 0, rows - 1 do
            local row = { }
            matrix[ r ] = row
            for c = 0, cols - 1 do
                row[ c ] = 1024.0
            end
        end
        return matrix
    end
    local function createDecoderState( )
        return { 1024.0, 1024.0, initializeMatrix( 1, 8 ), initializeMatrix( 1, 8 ), initializeArray( 256 ) }
    end
    local function executeDecompression( )
        local stateMatrixA, stateMatrixB, stateArrayA, stateArrayB, stateArrayC, stateArrayD, stateMatrixC, stateMatrixD, stateArrayE, stateArrayF, decoderA, decoderB, varA, varB, varC, varD = initializeMatrix( 8, 0x300 ), initializeMatrix( 12, 1 ), initializeArray( 12 ), initializeArray( 12 ), initializeArray( 12 ), initializeArray( 12 ), initializeMatrix( 12, 1 ), initializeMatrix( 4, 64 ), initializeArray( 115.0 ), initializeArray( 16 ), createDecoderState( ), createDecoderState( ), 0, 0, 0, 0
        while bitMask <= totalElements do
            local currentPos = ( instructionPointer % 1 )
            if processFlag( stateMatrixB[ bufferIndex ], currentPos ) == 0 then
                local val = outputBuffer[ instructionPointer ]
                local divisor = val / bitShiftHelper[ 5.0 ]
                divisor = divisor - divisor % 1
                local row = stateMatrixA[ divisor ]
                instructionPointer = instructionPointer + 1
                outputBuffer[ instructionPointer ] = bufferIndex < 7 and decodeValue( row, 8, 256 ) or bitwiseDecode( row, outputBuffer[ instructionPointer - varA - 1 ] )
                bufferIndex = pTable[ bufferIndex ]
            else
                local subFlag
                if processFlag( stateArrayA, bufferIndex ) ~= 0 then
                    if processFlag( stateArrayB, bufferIndex ) == 0 then
                        if processFlag( stateMatrixC[ bufferIndex ], currentPos ) == 0 then
                            bufferIndex = bufferIndex < 7 and 9 or 11
                            subFlag = 1
                        end
                    else
                        local tempVar
                        if processFlag( stateArrayC, bufferIndex ) == 0 then
                            tempVar = varB
                        else
                            if processFlag( stateArrayD, bufferIndex ) == 0 then
                                tempVar = varC
                            else
                                tempVar = varD
                                varD = varC
                            end
                            varC = varB
                        end
                        varB = varA
                        varA = tempVar
                    end
                    if not subFlag then
                        bufferIndex = bufferIndex < 7 and 8 or 11
                        subFlag = 2 + getContext( decoderA, currentPos )
                    end
                else
                    varD = varC
                    varC = varB
                    varB = varA
                    subFlag = 2 + getContext( decoderB, currentPos )
                    local offset = subFlag - 2
                    if 4 <= offset then
                        offset = 3.0
                    end
                    varA = decodeValue( stateMatrixD[ offset ], 6, 64 )
                    if varA >= 4 then
                        local tempA = varA
                        local tempB = tempA / 2 - 1
                        tempB = tempB - tempB % 1
                        varA = ( 2 + tempA % 2 ) * bitShiftHelper[ tempB ]
                        if tempA < 14 then
                            varA = varA + rangeDecode( stateArrayE, varA - tempA, tempB )
                        else
                            varA = varA + ( readBits( tempB - 4 ) * 16 ) + rangeDecode( stateArrayF, 0, 4 )
                            if varA == 0xFFFFFFFF then
                                return subFlag == 2
                            end
                        end
                    end
                    bufferIndex = bufferIndex < 7 and 7 or 10
                    if varA >= instructionPointer then
                        return false
                    end
                end
                local target = instructionPointer + subFlag
                for i = instructionPointer + 1, target do
                    outputBuffer[ i ] = outputBuffer[ i - varA - 1 ]
                end
                instructionPointer = target
            end
        end
        return false
    end
    executeDecompression( )
    pCall( assertHelper, setMetaTable( { }, { __tostring = function ( ) outputBuffer = nil end } ), nil, nil )
    local finalString, bufferLength = "", #outputBuffer
    for i = 1, bufferLength, 7997 do
        local segment = i + 7996.0
        if segment > bufferLength then
            segment = bufferLength
        end
        finalString = finalString .. charHelper( unPack( outputBuffer, i, segment ) )
    end
    local resultFunction, errorMsg = pCall( assertHelper, finalString, "Luraph" .. repeatString( " ", 4 ), nil )
    assertHelper( resultFunction and errorMsg and typeHelper( errorMsg ) == 'function', "Luraph decompression error: " .. toString( errorMsg ) .. " (does your environment support load/loadstring?)" )
    return errorMsg
end )( ... )
