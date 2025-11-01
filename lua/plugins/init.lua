return {
  -- This is where I typically stage/test plugins!
  {
    "mghaight/replua.nvim",
    config = function()
      require("replua").setup()
    end,
  },
  -- "bertiewhite/not-a-virus.nvim",
}
