local ESC_FEEDKEY = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
local ollama = {

  --- @param model string
  --- @param context string
  --- @param prompt string
  --- @param buf_nr number
  --- @param max_width number
  --- @return number
  run = function(model, context, prompt, buf_nr, max_width)
    local cmd = ("ollama run $model $prompt")
      :gsub("$model", model)
      :gsub("$prompt", vim.fn.shellescape(context .. "\n" .. prompt))
    local header = vim.split(prompt, "\n")
    table.insert(header, "----------------------------------------")
    vim.api.nvim_buf_set_lines(buf_nr, 0, -1, false, header)
    local line = vim.tbl_count(header)
    local line_char_count = 0
    local words = {}
    return vim.fn.jobstart(cmd, {
      on_stdout = function(_, data, _)
        for i, token in ipairs(data) do
          if i > 1 or (string.match(token, "^%s") and line_char_count > max_width) then -- if returned data array has more than one element, a line break occured.
            line = line + 1
            words = {}
            line_char_count = 0
          end
          line_char_count = line_char_count + #token
          table.insert(words, token)
          vim.api.nvim_buf_set_lines(buf_nr, line, line + 1, false, { table.concat(words, "") })
        end
      end,
    })
  end,

  --- @return string
  get_visual_lines = function(bufnr)
    vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)
    vim.api.nvim_feedkeys("gv", "x", false)
    vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)

    local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(bufnr, "<"))
    local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(bufnr, ">"))
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_row - 1, end_row, false)

    if start_row == 0 then
      lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      start_row = 1
      start_col = 0
      end_row = #lines
      end_col = #lines[#lines]
    end

    start_col = start_col + 1
    end_col = math.min(end_col, #lines[#lines] - 1) + 1

    lines[#lines] = lines[#lines]:sub(1, end_col)
    lines[1] = lines[1]:sub(start_col)

    return table.concat(lines, "\n")
  end
}
local plen = require("plenary.window.float")
-- define some styles and spawn a scratch buffer
local win_options = {
  winblend = 10,
  border = "rounded",
  bufnr = vim.api.nvim_create_buf(false, true)
}

vim.keymap.set("n", "<leader>cc", function()
  local prompt = vim.fn.input("Prompt: ")
  if prompt == "" then
    return
  end
  plen.clear(win_options.bufnr)
  local float = plen.percentage_range_window(0.8, 0.8, win_options)
  local win_width = vim.api.nvim_win_get_width(float.win_id) - 5
  ollama.run("mistral:instruct", "", prompt, float.bufnr, win_width)
end, { silent = true, desc = "Mistral" })

vim.keymap.set("v", "<leader>cp", function()
  local prompt = ollama.get_visual_lines(0)
  plen.clear(win_options.bufnr)
  local float = plen.percentage_range_window(0.8, 0.8, win_options)
  local win_width = vim.api.nvim_win_get_width(float.win_id) - 5
  ollama.run("mistral:instruct", "", prompt, float.bufnr, win_width)
end, { silent = true, desc = "Mistral" })

------------------------------------------------------------------
-- coding
vim.keymap.set("v", "<leader>cc", function()
  local prompt = ollama.get_visual_lines(0)
  plen.clear(win_options.bufnr)
  local float = plen.percentage_range_window(0.8, 0.8, win_options)
  local win_width = vim.api.nvim_win_get_width(float.win_id) - 5
  ollama.run("codellama:7b", "", prompt, float.bufnr, win_width)
end, { silent = true, desc = "Codellama" })

------------------------------------------------------------------
-- general purpose math & logic questions
vim.keymap.set("n", "<leader>cm", function()
  local prompt = vim.fn.input("Prompt: ")
  if prompt == "" then
    return
  end
  plen.clear(win_options.bufnr)
  local float = plen.percentage_range_window(0.8, 0.8, win_options)
  local win_width = vim.api.nvim_win_get_width(float.win_id) - 5
  ollama.run("wizard-math", "", prompt, float.bufnr, win_width)
end, { silent = true, desc = "Math" })

vim.keymap.set("v", "<leader>cm", function()
  local prompt = ollama.get_visual_lines(0)
  plen.clear(win_options.bufnr)
  local float = plen.percentage_range_window(0.8, 0.8, win_options)
  local win_width = vim.api.nvim_win_get_width(float.win_id) - 5
  ollama.run("wizard-math", "", prompt, float.bufnr, win_width)
end, { silent = true, desc = "Math" })
