# NvimEmmet

> **Warning:** This plugin is developed to learn how Neovim plugins work!  
> Not all functions of the original Emmet are included, nor do they necessarily work the same.

This plugin is used to write tagged languages faster.

Currently, only HTML and JSX (React) are fully supported with their special cases (void elements and mandatory attributes).

For other tagged languages, by default this plugin will tag every input as follows:
`exampleTag` will be converted to:
```
<exampleTag>
	
</exampleTag>
```
## Usage

### In neovim command line

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

### Inline in the file

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


### Special case in React  
In React sometimes tags are used with a “.”, for example `<Card.body></Card.body>`. Because of this, the dot symbol can’t be used to instantiate a className. For this reason, the “.” is replaced with a “?”.  

For example, the trigger `Card.body?Classname` in a JSX or TSX file will convert to:

```tsx
<Card.body className="className">
	
</Card.body>
```

## Install guide using packer

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
