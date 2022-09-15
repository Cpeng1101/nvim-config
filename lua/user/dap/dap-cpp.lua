local dap = require('dap')

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = '/Users/chengpeng/.local/share/nvim/dapinstall/codelldb/extension/adapter/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
}
--[[
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = "executable",
    --command = dbg_path .. "extension/debugAdapters/bin/OpenDebugAD7",
    command = "/Users/chengpeng/Workspace/extension/debugAdapters/bin/OpenDebugAD7",
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb', -- adjust as needed, must be absolute path
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

--local dbg_path = require("dap-install.config.settings").options["installation_path"] .. "ccppr_vsc/"
dap.configurations.cpp = {
    -- launch exe
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function()
            local input = vim.fn.input("Input args: ")
            return require("user.dap.dap-util").str2argtable(input)
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
        setupCommands = {
            {
                description = 'enable pretty printing',
                text = '-enable-pretty-printing',
                ignoreFailures = false
            },
        },
    },
    -- attach process
    {
        name = "Attach process",
        type = "cppdbg",
        request = "attach",
        processId = require('dap.utils').pick_process,
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        setupCommands = {
            {
                description = 'enable pretty printing',
                text = '-enable-pretty-printing',
                ignoreFailures = false
            },
        },
    },
    -- attach server
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb', cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description = 'enable pretty printing',
                ignoreFailures = false
            },
        },
    },
}
]]--

-- setup other language
dap.configurations.c = dap.configurations.cpp
