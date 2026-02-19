set -gx PKGBUILDS_AUR_URI   "ssh://aur@aur.archlinux.org"
set -gx PKGBUILDS_REPO_ROOT "$HOME/pkgbuilds"
set -gx PKGBUILDS_GITDIR_ROOT "$PKGBUILDS_REPO_ROOT/.gitrepos"


function aurpkg --description 'Manage pkgbuild with split git repo'
    set -l repo_root "$PKGBUILDS_REPO_ROOT"
    set -l gitdir_root "$PKGBUILDS_GITDIR_ROOT"
    set -l cwd (pwd -P)

    if test "$cwd" = "$repo_root"
        echo "pkg: enter a package directory under $repo_root" >&2
        return 1
    end

    set -l prefix "$repo_root/"
    if not string match -q -- "$prefix*" "$cwd"
        echo "pkg: current directory is outside $repo_root" >&2
        return 1
    end

    set -l rel (string replace -- "$prefix" "" "$cwd")
    set -l pkg_name (string split "/" -- "$rel")[1]
    set -l work_tree "$repo_root/$pkg_name"
    set -l git_dir "$gitdir_root/$pkg_name.git"

    if not test -d "$work_tree"
        echo "pkg: missing work tree: $work_tree" >&2
        return 1
    end

    if not test -d "$git_dir"
        echo "pkg: missing git repo: $git_dir" >&2
        return 1
    end

    echo "#" $pkg_name $work_tree $git_dir
    command git --git-dir="$git_dir" --work-tree="$work_tree" $argv
end
