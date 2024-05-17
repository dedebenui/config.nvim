let base_dir = "~/.config/nvim" | path expand
print $base_dir
if not ($base_dir | path exists) {
    mkdir $base_dir
}

rsync -av --exclude=deploy.nu --exclude=.git --delete --delete-excluded . $base_dir
