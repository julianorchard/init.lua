return {
  -- I assume this is important to be loaded first?
  {
    "gpanders/nvim-moonwalk",
    init = function()
      require("moonwalk").add_loader("fnl", function(src)
        return require("fennel").compileString(src)
      end)
    end,
  },
}
