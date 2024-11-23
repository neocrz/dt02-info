function Tprint(t)
  for k, v in pairs(t) do
    print("k:", k, "v:", v)
  end
end

function Tcopy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[Tcopy(k, s)] = Tcopy(v, s) end
  return res
end

function Tmerge(t1, t2)
    local result = {}

    for k, v in pairs(t1) do
        result[k] = v
    end

    for k, v in pairs(t2) do
        result[k] = v
    end

    return result
end

