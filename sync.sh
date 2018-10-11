if [ -z "$HOME" ]; then
    echo "HOME (~) is undefined, cannot sync"
    exit 1
fi

# remove suffix slash if exist
HOME=${HOME%"/"}

overwrite_prompt () {
    link=$(readlink -f $1)
    while true; do
        read -n 1 -p "$1 is linked to other directory ($link). [o]verwrite, or [i]gnore? " oi
        case $oi in
            [Oo]* ) echo "overwrite"; break;;
            [Ii]* ) break;;
            * ) echo "Please answer [o]verwrite, or [i]gnore.";;
        esac
    done
}

link_directory_to_home () {
    for f in $(ls -d $1)
    do
        # check if directory
        if ! [[ -d "$f" ]]
        then
            continue
        fi

        dir=${f#"./"}
        target=$(echo "$HOME/$dir")


        if [[ -L "$target" ]]
        then
            # target exist
            if ! [ "$target" -ef "$dir" ]
            then
                # target is not expected

                action=$(overwrite_prompt $target)
                if [ -z $action ]
                then
                    # ignore
                    echo "$dir is being ignored."
                    continue
                else
                    # overwrite
                    rm $target
                fi
            else
                echo -e "\e[32m✓\e[39m $dir"
                continue
            fi
        fi

	echo "$target"

        ln -s $(realpath $dir) $target
    done
}

link_directory () {
    echo "Linking... $1"

    for f in $(ls --ignore ".git" --ignore "*.nosync" "$1")
    do
        f="$1/$f"
        # ignore items with .nosync suffix
        if [[ $f == *.nosync ]]
        then
            continue
        fi

        # is directory?
        if [[ -d "$f" ]]
        then
            echo "$f: Directory"
            link_directory $f
            continue
        fi

        if [[ -f "$f" ]]
        then
            echo "$f: File"
            continue
        fi
    done
}

link_files_in_dir_to_home () {
    dir=${1%"/"}

    for base in $(ls -al $1 --ignore "*.example" | grep '^-' | awk '{ print $9 }')
    do
        # if starts with hashtag, then it is emacs file
        if [[ $base =~ ^# ]]
        then
            continue
        fi

        # ignore .example files
        if [[ $base =~ *.example$ ]]
        then
            continue
        fi

        # ignore this file
        if [[ $base =~ ^sync ]]
        then
            continue
        fi

        f="$dir/$base"


        echo -e "\e[32m✓\e[39m $base"

	if ! [ -L "$HOME/$base" ]; then
	    ln -s $(realpath $f) "$HOME/$base" 2>&1 > /dev/null
	fi
    done
}

link_directory_to_home .emacs.d
link_directory_to_home .scripts
link_directory_to_home .exec
link_directory_to_home .urxvt
link_directory_to_home .notifications
link_directory_to_home ".config/*"
link_files_in_dir_to_home .
