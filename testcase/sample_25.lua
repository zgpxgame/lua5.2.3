  local foo
  local function bar()
    local function baz()
      local foo, bar
      foo = bar
      foo = baz
    end
    foo = bar
    foo = baz
  end
  foo = bar
  foo = baz