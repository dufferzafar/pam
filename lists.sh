
######################################################################

# Get all PPAs installed on the system
list_ppa() {
    for APT in `find /etc/apt/ -name \*.list`; do
        grep -o "^deb http://ppa.launchpad.net/[a-z0-9\-]\+/[a-z0-9\-]\+" $APT | while read ENTRY ; do

            USER=`echo $ENTRY | cut -d/ -f4`
            PPA=`echo $ENTRY  | cut -d/ -f5`

            echo sudo apt-add-repository --yes ppa:$USER/$PPA
        done
    done
}

######################################################################

# Get all user installed packages on the system
list_apt_packages() {
    # List of all packages currently installed
    current=$(dpkg -l | awk '{print $2}' | sort | uniq)

    # List of all packages that were installed with the system
    pre=$(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort | uniq)

    # List of packages that don't depend on any other package
    manual=$(apt-mark showmanual | sort | uniq)

    # (Current - Pre) ∩ (Manual)
    packages=$(comm -12 <(comm -23 <(echo "$current") <(echo "$pre")) <(echo "$manual") )

    for pack in $packages; do
        packname=$(echo $pack | cut -f 1 -d ":")
        desc=$(apt-cache search "^$packname$" | head -n 1 | sed -E 's/[^ - ]* - (.*)/\1/')
        date=$(date -r /var/lib/dpkg/info/$pack.list)

        echo "# $desc"
        echo "# $date"
        echo "apt-get -y install $pack"
        echo -e ""
    done
}

######################################################################

# Get all node packages installed on the system
list_npm_packages() {
    # List all npm packages
    ls -1 "$(npm root --global)"

    # will print out specific versions too but we don't want them
    # npm list --global --depth=0
}

######################################################################

# Get all python packages installed on the system
# usage: list_py_packages 2.7
list_py_packages() {
    pip$1 freeze
}

######################################################################

# Get all pipsi packages installed on the system
list_pipsi_packages() {
    pipsi list
}

######################################################################

lists_dir="/mnt/OS/#Storage/Backup/ubuntu/lists"

list_ppa              > $lists_dir/ppa.sh
list_apt_packages     > $lists_dir/apt-packages.sh
list_npm_packages     > $lists_dir/npm-packages.txt
list_py_packages 2.7  > $lists_dir/py-27-packages.txt
list_py_packages 3    > $lists_dir/py-34-packages.txt
list_pipsi_packages   > $lists_dir/pipsi-packages.txt
