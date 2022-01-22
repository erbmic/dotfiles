# dotfiles
This is a repository to track and store your configuration `.dotfiles` in version control and install them easily onto a new system.

The technique consists in storing a Git bare repository in a "side" folder (like `$HOME/.dotfiles` or `$HOME/.myconfig`) using a specially crafted alias so that commands are run against that repository and not the usual .git local folder, which would interfere with any other Git repositories around.

## Prerequisites

The only pre-requisite is to install Git.

## Start from scratch

If you haven't been tracking your configurations in a Git repository before, you can start using this technique easily with these lines:

```bash
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

After this, any file within the $HOME folder can be versioned with normal commands, replacing `git` with your newly created `dotfiles` alias, like:

```php
config status
config add .vimrc
config commit -m "Add vimrc"
config add .bashrc
config commit -m "Add bashrc"
config push
```

## Install your dotfiles onto a new system

I created the following bash script to automate the steps to install it on a new system. It does basicly clone the repository and set the set the local git configuration for the folder. In case the `$HOME` folder does already contain some dotfiles configurations, the script does first backup these files by moving them in a seperate `.dotfiles-backup` folder.

```bash
#!/bin/bash
git clone --bare git@github.com:erbmic/dotfiles.git /home/michael/Documents/test/.dotfiles
function dotfiles {
   /usr/bin/git --git-dir=/home/michael/Documents/test/.dotfiles/ --work-tree=/home/michael/Documents/test $@
}
mkdir -p .dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotfiles checkout
dotfiles config status.showUntrackedFiles no
```

The script is stored in a public [GitHub Gist](https://gist.github.com/erbmic/ee438861b2a4aa605bff7a6dd1f151fa) which can be executed by these two commands.

```bash
cd $HOME
curl -Lk https://gist.github.com/erbmic/ee438861b2a4aa605bff7a6dd1f151fa/raw/dotfiles.sh | /bin/bash
```

origin report: https://www.atlassian.com/git/tutorials/dotfiles