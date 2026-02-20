set -gx PKGBUILDS_AUR_URI   "ssh://aur@aur.archlinux.org"
set -gx PKGBUILDS_REPO_ROOT "$HOME/pkgbuilds"
set -gx PKGBUILDS_GITDIR_ROOT "$PKGBUILDS_REPO_ROOT/.gitrepos"


function aurpkg-init --description 'Init pkgbuild with split git repo' -a repo_name
    test -n "$repo_name"; or begin
        echo "usage: pkg-init <repo_name>" >&2
        return 2
    end

    if string match -q -- "$PKGBUILDS_AUR_URI/*" "$repo_name"
        set repo_name (string replace -- "$PKGBUILDS_AUR_URI/" "" -- "$repo_name")
    end

    set -l repo_list "$PKGBUILDS_REPO_ROOT/repo.list"
    set -l pkg (string replace -r '\.git$' '' -- "$repo_name")

    set -l aur_uri "$PKGBUILDS_AUR_URI/$pkg.git"
    set -l git_dir "$PKGBUILDS_GITDIR_ROOT/$pkg.git"
    set -l work_tree "$PKGBUILDS_REPO_ROOT/$pkg"

    test ! -e "$work_tree" -a ! -e "$git_dir"; or begin
        echo "pkg-init: $pkg or $pkg.git already exists" >&2
        return 1
    end

    echo "# Init pkg:" "$pkg" "$aur_uri" "$git_dir" "$work_tree"

    command git clone "$aur_uri" --separate-git-dir "$git_dir" "$work_tree"; or return 1
    command rm -- "$work_tree/.git"; or return 1

    if not test -e "$repo_list"
        echo "$pkg" > "$repo_list"; or return 1
    else if not command grep -Fxq -- "$pkg" "$repo_list"
        echo "$pkg" >> "$repo_list"; or return 1
    end
end
