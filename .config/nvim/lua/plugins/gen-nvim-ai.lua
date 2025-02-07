return {
  "David-Kunz/gen.nvim",
  opts = {
    model = "qwen2.5:7b-instruct-q6_K",
    display_mode = "split",
    show_prompt = true,
    show_model = true,
  },

  config = function(_, opts)
    require("gen").setup(opts)
    vim.keymap.set("n", "<leader>at", ":Gen Chat<CR>", { desc = "Gen: Chat with user prompt only" })
    vim.keymap.set("n", "<leader>ak", ":Gen Ask<CR>", { desc = "Gen: Chat with the buffer" })
    vim.keymap.set("n", "<leader>ar", ":Gen Review_Code<CR>", { desc = "Gen: Review Code" })
    vim.keymap.set("n", "<leader>ah", ":Gen Change_Code<CR>", { desc = "Gen: Change Code" })
    vim.keymap.set("n", "<leader>ae", ":Gen Enhance_Code<CR>", { desc = "Gen: Enhance code" })
    vim.keymap.set(
      "n",
      "<leader>as",
      ":Gen Enhance_Grammar_Spelling<CR>",
      { desc = "Gen: Enhance grammar and spelling" }
    )
    vim.keymap.set("n", "<leader>aw", ":Gen Enhance_Wording<CR>", { desc = "Gen: Enhance wording" })
  end,
}
