
# Extract all tar files present in $1 to $2
ex_all_tars() {

    # Ensure destination exists
    mkdir -p "$2"

    # Untar each file
    for tar in "$1"/*.tar; do
        echo $tar

        tar -xf $tar -C "$2"

        # exit
    done
}

ex_all_tars "/mnt/OS/#Storage/Backup/ubuntu/home/dev" "/home/dufferzafar/dev"
ex_all_tars "/mnt/OS/#Storage/Backup/ubuntu/home/dev/alpha" "/home/dufferzafar/dev/alpha"
ex_all_tars "/mnt/OS/#Storage/Backup/ubuntu/home/dev/clones" "/home/dufferzafar/dev/clones"
