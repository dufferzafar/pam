
# pam - packers and movers

A set of scripts that helped me backup my files and configurations so I could move from Ubuntu GNOME 14.04 to Kubuntu 15.10.

Almost all of the scripts contain hardcoded paths for my system, so as such this repo is not meant to cloned and run on your machine. The backup code itself is pretty generic, so feel free to copy and modify the functions to suit your needs.

## scripts

### `files.sh`

Backup various various directories from the system. Most of these are `tar`ed so as to preserve file permissions, but some are just `rsync`ed.

### `lists.sh`

Has functions to list various kinds of packages installed on the system: like `apt-get`, `python`, `npm`, `pipsi` packages and all the `ppas`.

Also has a function to list all the executables found in any of your `$PATH` folders.

### `tars.sh`

Has a function to create a tarball for each sub-directory of a directory. I used it backup each of my git repositories!

### `tree.sh`

Generates trees for directories and uses 7z to archive them.

## todo

* `list_apt_packages`
    * Sort by installation date
    * Improve speed
        * Currently takes `46.27s user 7.65s system 100% cpu 53.446 total`

* `list_ppa`
    * Use Python to get information about a PPA too: http://askubuntu.com/a/680525/415634

* `list_bins_on_path`
    * Better & Sorted output

* `tree.sh`
    * Upload to Github Gist, Dropbox, Google Drive ?

* more backups
    * autojump data file ~/.local/share/autojump/autojump.txt

* a nice restore script
