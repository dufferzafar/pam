# Make sure the backup directory exists
dir="/mnt/OS/#Storage/Backup/tree/"
mkdir -p $dir

# echo the commands being executed
set -x

############################################################## /

# etc
tar -cf $dir/etc.tar -C / etc

# bin - folders in $PATH
tar -cf $dir/bin.tar -C / bin sbin usr/bin usr/sbin usr/local/sbin usr/local/bin

# Apache2
tar -cf $dir/apache2.tar -C / etc/apache2 var/www

############################################################## /usr

# Python packages
tar -cf $dir/python-27-packages.tar /usr/local/lib/python2.7
tar -cf $dir/python-34-packages.tar /usr/local/lib/python3.4

############################################################# /home

# Desktop Files
hom=home/dufferzafar
tar -cf $dir/desktop-files.tar -C / $hom/.local/share/applications/

# .cache - I am pretty stingy when it comes to downloaded stuff
cache=$hom/.cache
tar -cf $dir/home-cache.tar -C / $cache/bower $cache/pip $hom/.npm

# Languages stuff
tar -cf $dir/home-cache-languages.tar -C / $hom/.go $cache/.rvm $hom/.gem

# .config
tar -cf $dir/home-misc.tar -C / $hom/.purple $hom/.zotero $hom/nltk_data
tar -cf $dir/home-config-others.tar -C / $hom/.vim $hom/.oh-my-zsh $hom/.dotfiles $hom/.ssh $hom/.fonts $hom/.net $hom/.js $hom/.css
tar -cf $dir/home-config.tar -C / $hom/.config

# Backup all 1 level files whose names start with '.'
tar -cf $dir/home-files.tar "$(find "$HOME" -maxdepth 1 -type f -name "\.*")"