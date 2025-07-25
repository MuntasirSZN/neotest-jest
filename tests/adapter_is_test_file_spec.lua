local adapter = require("neotest-jest")({ jestCommand = "jest" })
local async = require("nio").tests
local util = require("neotest-jest.util")

describe("adapter.is_test_file", function()
  async.it("matches jest test files", function()
    assert.True(adapter.is_test_file("./spec/basic.test.ts"))
    assert.True(adapter.is_test_file("./spec/__tests__/some.test.ts"))
  end)

  async.it("does not match nil or plain js/ts files", function()
    assert.False(adapter.is_test_file("nil"))
    assert.False(adapter.is_test_file("./index.js"))
    assert.False(adapter.is_test_file("./index.ts"))
  end)

  async.it("matches all supported extensions", function()
    for _, extension in ipairs(util.getDefaultTestExtensions()) do
      local path = "./spec/file." .. extension[1] .. "." .. extension[2]
      local result = adapter.is_test_file(path)

      if not result then
        vim.print(path)
      end

      assert.True(result)
    end
  end)
end)
