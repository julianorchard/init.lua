return {

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("config.scope").setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
  },

  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = true,
      show_hidden = true,
      keymaps = {
        ["q"] = "actions.close",
      },
    },
    keys = {
      -- Regular oil
      {
        "-",
        "<cmd>Oil<cr>",
      },
      -- Oil as a (kinda janky) sidebar, <leader><CR> temporarily set to enter
      -- the file and :only it
      {
        "<leader>-",
        function()
          vim.cmd("vsplit")
          vim.cmd("vertical resize 30")
          vim.cmd("Oil")
          vim.keymap.set("n", "<leader><CR>", function()
            vim.keymap.del("n", "<leader><CR>")
            -- This is really useful to remember...
            vim.api.nvim_input("<cr>")
            vim.cmd("only")
          end)
        end,
      },
      -- Float
      {
        "<leader>=",
        "<cmd>Oil --float<cr>",
      },
    },
  },

  {
    "cd-project.nvim",
    dev = true,
    branch = "add-json-formatting",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "stevearc/oil.nvim",
    },
    config = function()
      require("cd-project").setup({
        format_json = true,
        project_dir_pattern = { ".git", ".gitignore", "package.json", "go.mod" },
        projects_config_filepath = vim.fs.normalize(
          vim.fn.stdpath("config") .. "/projects.json"
        ),
        projects_picker = "telescope",
        hooks = {
          {
            callback = function(dir)
              vim.notify("switched to dir: " .. dir)
            end,
          },
          {
            callback = function(_)
              vim.cmd("Oil")
            end,
          },
          {
            callback = function(_)
              local t = require("telescope.builtin").find_files
              require("config.scope").scope(t)
            end,
          },
        },
        auto_register_project = true,
      })
    end,
    keys = {
      {
        "<leader>cd",
        "<cmd>CdProject<cr>",
      },
    },
  },
}
