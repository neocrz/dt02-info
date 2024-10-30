function printt(t)
  for k, v in pairs(t) do
    print("k:", k, "v:", v)
  end
end

function copyt(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copyt(k, s)] = copyt(v, s) end
  return res
end
