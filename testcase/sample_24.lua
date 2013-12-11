  local foo
  local function bar()
    baz = nil
    foo = bar()
  end
  foo = bar