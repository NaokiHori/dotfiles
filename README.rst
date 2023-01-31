########
dotfiles
########

========
Overview
========

.. image:: https://raw.githubusercontent.com/NaokiHori/dotfiles/main/snapshot.png
   :width: 800

This repository contains several configuration files I am using for MacOS.

.. code-block:: console

   .
   ├── .dein.toml
   ├── .tmux.conf
   ├── .vimrc
   ├── .zsh_alias
   ├── .zshrc
   ├── link_dfiles.sh
   └── tmux
      ├── set_status_l.sh
      ├── set_status_m.sh
      └── set_status_r.sh

#. `tmux <https://github.com/tmux/tmux>`_

   ``.tmux.conf`` and its supportive files ``tmux/set_status_[lmr].sh`` (showing Wi-Fi connection, battery, memory usage, and time)

#. `neovim <https://neovim.io>`_

   ``.vimrc`` and a configuration file ``.dein.toml`` for a package manager `dein.vim <https://github.com/Shougo/dein.vim>`_

#. `zsh <https://www.zsh.org>`_

   ``.zshrc`` (minimal, without `oh-my-zsh <https://ohmyz.sh>`_) and personal alias ``.zsh_alias``

=====
Usage
=====

**The following process can overwrite your configurations.**

.. code-block:: console

   $ git clone https://github.com/NaokiHori/dotfiles ~/.dotfiles
   $ cd ~/.dotfiles
   # DANGER! create symbolic links to dotfiles under ${HOME}
   # The following dotfiles will be overwritten if already exist
   #   .dein.toml
   #   .tmux.conf
   #   .vimrc
   #   .zsh_alias
   #   .zshrc
   $ zsh link_dfiles.sh

