# Returns true if $2 is not present in $1
not_in_list() {
    local word
    for word in $1; do
        [[ $word = $2 ]] && return 1
    done
    return 0
}

# Zip each sub-folder of $1 to $2
# Skip directories present in $3
tar_back() {
    # Make sure that the destination folder exists
    mkdir -p "$2"

    # Iterate over each sub-folder
    for dir in "$1"/*/; do
        name=$(basename "$dir")

        # Skip some of them
        if not_in_list "$3" "$name"; then
            file="$2/${name%/}.tar"
            if ! [[ -f "$file" ]]; then
                echo -e "$dir" "==>" $file

                # Tar preserves file permissions!
                tar -cpf "$file" -C "$1" "$name"

                # Zip doesn't ?
                # zip -rq -0 "$file" "$dir"

                # Zip to a temporary location first ?
                # zip -rq -0 "/tmp/${name%/}.zip" "$dir"
                # mv "/tmp/${name%/}.zip" "$file"
            fi
        fi
    done
    echo -e ""
}

#################################################################

# Make sure the backup directory exists
dest="/mnt/OS/#Storage/Backup/ubuntu/tars"
mkdir -p $dest

# My current dev folder - contains git repos that i'm working on now
tar_back ~/dev                    "$dest/dev"                "__pycache__ alpha clones Python-Scripts duffers-log"
tar_back ~/dev/alpha              "$dest/dev/alpha"          "__pycache__"
tar_back ~/dev/clones             "$dest/dev/clones"         "__pycache__"

# My Windows dev folder - contains git repos i used to work on
tar_back /mnt/Work/Github         "$dest/Github"         "__pycache__ _Clones"
tar_back /mnt/Work/Github/_Clones "$dest/Github/Clones"  "__pycache__ komanda"
