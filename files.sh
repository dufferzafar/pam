# Make sure the backup directory exists
homebk="/mnt/OS/#Storage/Backup/ubuntu/home"
files="/mnt/OS/#Storage/Backup/ubuntu/files"

mkdir -p $files
mkdir -p $homebk

# The tar command
tar="tar -cpf"

# echo the commands being executed
set -x

############################################################## /

back_root() {
    # etc
    $tar $files/etc.tar -C / etc

    # bin - folders in $PATH
    $tar $files/binaries.tar -C / bin sbin usr/bin usr/sbin usr/local/sbin usr/local/bin

    # Apache2
    $tar $files/apache2.tar -C / etc/apache2 var/www
}

############################################################## /usr

back_usr() {
    # Python packages
    $tar $files/python_27_packages.tar -C / usr/local/lib/python2.7/dist-packages usr/lib/python2.7/dist-packages
    $tar $files/python_34_packages.tar -C / usr/local/lib/python3.4/dist-packages usr/lib/python3/dist-packages usr/lib/python3.4/dist-packages usr/lib/dist-python

    # Node Modules
    $tar $files/node_modules.tar -C / usr/lib/node_modules
}

############################################################# /home

back_home() {
    # Desktop Files
    hom=home/dufferzafar

    # .cache - I am pretty stingy when it comes to downloaded stuff
    cache=$hom/.cache
    $tar $homebk/cache.tar -C / $cache/bower $cache/pip $hom/.npm

    #########################

    # pipsi packages
    $tar $homebk/pipsi.tar -C / $hom/.local/venvs $hom/.local/bin

    #########################

    # Languages stuff
    $tar $homebk/cache_languages.tar -C / $hom/.go $hom/.rvm $hom/.gem

    #########################

    # Configurations
    # FoI: sublime-text-3, terminator
    $tar $homebk/config.tar -C / $hom/.config
    $tar $homebk/desktop_files.tar -C / $hom/.local/share/applications/

    #########################

    # Backup all 1 level files whose names start with '.'
    $tar $homebk/dotted_files.tar $(find "$HOME" -maxdepth 1 -type f -name "\.*")

    #########################

    # ~/.apps contains custom installed applications
    $tar $homebk/apps.tar -C / $hom/.apps

    #########################

    # Other folders
    $tar $homebk/research.tar -C / $hom/research
    $tar $homebk/movies.tar -C / $hom/Movies

    #########################

    # Everything but...

    # FoI:
    # .dotfiles, .vim, .oh-my-zsh, .ssh
    # .js, .css, .fonts
    $tar $homebk/everything.tar -C / $hom \
        --exclude="dev" \
        --exclude="Downloads" \
        --exclude="Documents" \
        --exclude="Movies" \
        --exclude="research" \
        --exclude="Videos" \
        --exclude=".apps" \
        --exclude=".cache" \
        --exclude=".codeintel" \
        --exclude=".config" \
        --exclude=".local" \
        --exclude=".mozilla" \
        --exclude=".rvm" \
        --exclude=".npm" \
        --exclude=".go" \
        --exclude=".wine"

    #########################

    $tar $homebk/home_git.tar -C /
        $hom/.dotfiles \
        $hom/.oh-my-zsh \
        $hom/.css \
        $hom/.js
}

back_home_rsync() {
    rsync -auh --info=progress2 ~/Downloads $homebk
    rsync -auh --info=progress2 ~/Videos $homebk
    rsync -auh --info=progress2 ~/Documents $homebk
    rsync -auh --info=progress2 ~/Music $homebk
}

############################################################# Run!

back_root
back_usr
back_home
back_home_rsync
