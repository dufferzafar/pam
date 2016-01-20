
# pam - packers and movers

A set of scripts that helped me backup my files and configurations so I could move from Ubuntu GNOME 14.04 to Kubuntu 15.10.

Almost all of the scripts contain hardcoded paths for my system. So, as such this repo is not meant to cloned and run on your machine. That said, the backup code itself is pretty generic so feel free to copy and modify it to suit your needs.

## scripts

### `list-packages.sh`

Has functions to list various kinds of packages installed on the system.

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
