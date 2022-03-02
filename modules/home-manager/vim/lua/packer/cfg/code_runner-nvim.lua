require('code_runner').setup {
  term = {
   size = 10,
  },
  filetype = {
    c = 'cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt',
    cpp = 'cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt',
    go = 'go run',
    java = 'cd $dir && javac $fileName && java $fileNameWithoutExt',
    javascript = 'node',
    lua = 'lua',
    python = 'python -U',
    ruby = 'ruby',
    rust = 'cd $dir && rustc $fileName && $dir/$fileNameWithoutExt',
    typescript = 'deno run',
  },
  project = {},
}
