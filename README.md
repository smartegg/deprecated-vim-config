
These are my VIM settings, based on [ttsiodras](https://github.com/ttsiodras/dotvim)


Installation
-------------

In any new machine/account I need to work on, I clone from the repository:

    cd 
    git clone git://github.com/smartegg/dotvim.git .vim
    cd .vim
    git submodule init
    git submodule update
    cd ..
    ln -s .vim/.vimrc

I therefore use the same VIM environment in all my machines.

For C/C++ development
---------------------

I create /usr/include/tags:

    (become root via su/sudo)
    cd /usr/include
    ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .

My .vimrc is set to use these, as well as any local "tags" I build
in my project-specific Makefiles:

    set tags+=/usr/include/tags

I use [clang complete](http://www.vim.org/scripts/script.php?script_id=3302)
  to get Intellisense-like autocompletion (see the video above).

The 'A' plugin allows me to quickly switch between .h/c{c,pp} with ':A'

Pressing 'K' shows manpages on the symbol under the cursor in an "inner window" 
(which allows me to copy/paste). I quickly close the manpage "window" with Ctrl-F12.

For Python development
----------------------

I've mapped F7 to invoke flake8 (install it with: "easy_install flake8") to get 
static analysis error reports from "pyflakes" and style issues from "pep8", navigating
from error to error in the usual way (":cn", ":cp")

Generic stuff
-------------

I've mapped:

-    NERDTreeToggle to F10, for direct access to "file manager" interface
-    Ctrl-cursors to navigate windows (under both XTerms and GVim)
-    Ctrl-L to clear search results (hate seeing yellow stuff after search)
-    Ctrl-F12 to quickly close "window" (buffer)
-    F8 to show taglists (macros/types/variables/functions/classes)
- I also have easy motion in, so I can navigate to any place in the screen
  with a simple \\\\w followed by a character. Amazing plugin.

Am I insane to use VIM?
-----------------------
[No, I am not](http://www.viemu.com/a-why-vi-vim.html)

Problems 
------------------------
under ubuntu11.10, the clang plugin doesn't work because lack of libclang.so.
Please just download llvm-3.0 from
[llvm](http://llvm.org/releases/3.0/clang+llvm-3.0-i386-linux-Ubuntu-11_10.tar.gz)
