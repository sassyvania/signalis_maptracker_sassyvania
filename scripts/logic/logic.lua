-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end
function has_more_then_n_consumable(n)
    local count = Tracker:ProviderCountForCode('consumable')
    local val = (count > tonumber(n))
    if ENABLE_DEBUG_LOG then
        print(string.format("called has_more_then_n_consumable: count: %s, n: %s, val: %s", count, n, val))
    end
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end

function armed()
    return ((has("pistol") or has("shotgun") or has("smg")))
  
end
  
function b1access()
    return ((has("brokenairlock") and has("tape",1) and has("receptionist")))
  
end
function b2access()
    return ((has("$b1access") and has("classroom")))
  
end
function b3access()
    return ((has("$b2access") and has("idcard")))
  
end
function b4access()
    return ((has("$b3access") and has("pumpkey")))
  
end
function b5access()
    return ((has("$b3access") and has("elementkeys",5) and has ("armed")))
  
end
function b6b7access()
    return ((has("$b5access") and has("maintenance")))
  
end
function b8access()
    return ((has("$b6b7access") and has("fuse")))
  
end

function mineaccess()
    return (has("$b8access") and has("admin"))
  
end
function b1corruptedaccess()
    return (has("$mineaccess") and has("plate",6))
  
end
function rotfrontaccess()
    return (has("$b1corruptedaccess") and has("classroom",2))
  
end
function normalend()
    return (has("$rotfrontaccess") and has("dialring"))
  
end
function artifactend()
    return (has("$rotfrontaccess") and has("dialring") and has("artifactkeys:3"))
  
end

function AEon()
    
    return has ("artifactOn")
  end  