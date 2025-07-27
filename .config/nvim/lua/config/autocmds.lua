-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Patch avante.nvim to show hidden files
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyLoad",
  callback = function(event)
    if event.data == "avante.nvim" then
      local Utils = require("avante.utils")
      local original_scan = Utils.scan_directory
      
      Utils.scan_directory = function(options)
        -- Get the original command building logic
        local cmd_supports_max_depth = true
        local cmd = (function()
          if vim.fn.executable("rg") == 1 then
            local cmd = { "rg", "--files", "--color", "never", "--no-require-git", "--no-ignore-parent", "--hidden" }
            if options.max_depth ~= nil then vim.list_extend(cmd, { "--max-depth", options.max_depth }) end
            table.insert(cmd, options.directory)
            return cmd
          end
          if vim.fn.executable("fd") == 1 then
            local cmd = { "fd", "--type", "f", "--color", "never", "--no-require-git", "--hidden" }
            if options.max_depth ~= nil then vim.list_extend(cmd, { "--max-depth", options.max_depth }) end
            vim.list_extend(cmd, { "--base-directory", options.directory })
            return cmd
          end
          if vim.fn.executable("fdfind") == 1 then
            local cmd = { "fdfind", "--type", "f", "--color", "never", "--no-require-git", "--hidden" }
            if options.max_depth ~= nil then vim.list_extend(cmd, { "--max-depth", options.max_depth }) end
            vim.list_extend(cmd, { "--base-directory", options.directory })
            return cmd
          end
          -- Fall back to original implementation for git/find commands
          return nil
        end)()
        
        if cmd then
          -- Execute our modified command
          local result = vim.fn.systemlist(cmd)
          local files = {}
          
          for _, file in ipairs(result) do
            if file ~= "" then
              -- Convert to absolute path if needed
              local abs_file = file
              if not file:match("^/") then
                abs_file = options.directory .. "/" .. file
              end
              table.insert(files, abs_file)
            end
          end
          
          -- Apply max_depth filtering if needed and not supported by command
          if options.max_depth and not cmd_supports_max_depth then
            files = vim.tbl_filter(function(file)
              local rel_path = file:gsub("^" .. vim.pesc(options.directory) .. "/", "")
              local pieces = vim.split(rel_path, "/")
              return #pieces <= options.max_depth
            end, files)
          end
          
          -- Add directories if requested
          if options.add_dirs then
            local dirs = {}
            local dirs_seen = {}
            for _, file in ipairs(files) do
              local dir = vim.fn.fnamemodify(file, ":h")
              if not dirs_seen[dir] then
                table.insert(dirs, dir)
                dirs_seen[dir] = true
              end
            end
            files = vim.list_extend(dirs, files)
          end
          
          return files
        else
          -- Fall back to original implementation
          return original_scan(options)
        end
      end
    end
  end,
})
