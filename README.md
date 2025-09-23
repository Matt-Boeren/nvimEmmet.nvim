# NvimEmmet

> **Warning:** This plugin is developed to learn how Neovim plugins work!  
> Not all functions of the original Emmet are included, nor do they necessarily work the same.

## Usage

### In Neovim Command Line

The plugin can be used in the Neovim command line by using the command `:Emmet`.

This command takes in one argument, which is what Emmet will process into tags.  
For example, `:Emmet div>3*p{item $}` will convert to the following:
```html
<div>
	<p>
		item 1
	</p>
	<p>
		item 2
	</p>
	<p>
		item 3
	</p>
</div>
```

### Inline in the File

The plugin can also be used by typing the argument inline in the file and hitting a set keymap (see install guide).  
For example, if `div>3*p{item $}` is typed in the file, and with the cursor on the line, the keymap is hit, it will convert to:
```html
<div>
	<p>
		item 1
	</p>
	<p>
		item 2
	</p>
	<p>
		item 3
	</p>
</div>
```

## Install Guide Using Packer

In your packer startup, add the following line:
```lua
use('Matt-Boeren/nvimEmmet.nvim')
```

Create a new file in `after/plugin` and add the following content.  
Keymaps can be set as you prefer.
```lua
local Emmet = require('nvimEmmet')
Emmet.setup()
vim.keymap.set("n", '<leader>d', Emmet.callFromLine, {desc = "call from line"})
vim.keymap.set("i", '<C-d>', Emmet.callFromLine, {desc = "call from line"})
```
