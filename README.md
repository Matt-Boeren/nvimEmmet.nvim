# NvimEmmet
!Warning plugin is developed to learn how neovim plugins work!
It can be that not all functions of the original emmet are included nor work the same.

## Usage

### In neovim command line
The plugin can be used in the neovim command line by using the command :Emmet.

This command takes in one argument. This will be what emmet will process to tags.
This can for example be ":Emmet div>3*p{item $}" the plugin will convert it to the follwing:

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

### Inline of the file
The plugin can also be used by typing the commands argument inline of the file and hitting a set keymap (see install guide).
for example if "div>3*p{item $}" is typed in the file and with the cursor on the line the keymap is hit it will convert it to the following:

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

## Install guide
