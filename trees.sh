tree_dir="/mnt/OS/#Storage/Backup/tree/"$(date +%F)

mkdir -p $tree_dir

gen_tree() {
    echo "$1" ">" $tree_dir/"$2"
    tree "$1" --dirsfirst --prune --noreport -h -I "env|node_modules|.git" > $tree_dir/"$2"
    7z a -mx=9 $tree_dir/"$2".7z $tree_dir/"$2"
}

#################################################################

# Home Folder
gen_tree /home/dufferzafar home.tree

# Disk Partitions
gen_tree /mnt/Entertainment entertainment.tree
gen_tree /mnt/OS os.tree
gen_tree /mnt/Stuff stuff.tree
gen_tree /mnt/Work work.tree
