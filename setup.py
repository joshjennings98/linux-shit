# setup.py

import subprocess, sys, os, shutil
from typing import Dict, List
from pathlib import Path


def main(): # Modify stuff in main to change how stuff is set up. Should move these into distro specific functions than can be run depending on distro

    packages = [
        "vim",
        "mpv",
        "alsa-base",
        "alsa-utils",
        "feh",
        "network-manager",
        "htop",
        "steam",
        "expressvpn",
        "maim",
        #"blueman",
        "pinta",
        "calibre",
        "firefox",
        "discord",
        "keepassxc",
        "libimlib2-dev",
        "libxext-dev",
        "libxcb1-dev",
        "libxcb-damage0-dev",
        "libxcb-xfixes0-dev",
        "libxcb-shape0-dev",
        "libxcb-render-util0-dev",
        "libxcb-render0-dev",
        "libxcb-randr0-dev",
        "libxcb-composite0-dev",
        "libxcb-image0-dev",
        "libxcb-present-dev",
        "libxcb-xinerama0-dev",
        "libxcb-glx0-dev",
        "libpixman-1-dev",
        "libdbus-1-dev",
        "libconfig-dev",
        "libgl1-mesa-dev",
        "libpcre2-dev",
        "libevdev-dev",
        "uthash-dev",
        "libev-dev",
        "libx11-xcb-dev",
        "libx11-dev",
        "xorg-dev",
        "build-essential",
        "asciidoc",
        "ninja-build",
        "meson",
        "code"
    ]
    
    pip_packages = [
        "ueberzug",
        "ranger-fm"
    ]

    execute("sudo add-apt-repository universe")
    execute("sudo add-apt-repository multiverse")
    execute("sudo apt-get update")
    
    install_packages("sudo apt-get install -y", packages, "sudo snap install")
    install_packages("pip3 install", pip_packages, "sudo -H pip3 install") 
    
    copy_file("~/linux-stuff/system/fonts/Font Awesome 5 Free-Solid-900.otf", "/usr/share/fonts/opentype")
    copy_file("~/linux-stuff/system/fonts/iosevka-regular.ttf", "/usr/local/share/fonts")
    execute("sudo fc-cache -f -v") 
    
    copy_folder("~/linux-stuff/applications/ranger/", "~/.config/ranger")
    
    copy_folder("~/linux-stuff/system/")
    
    copy_file("~/linux-stuff/applications/vscode/settings.json", "~/.config/Code/User/")
    execute("bash ~/linux-stuff/scripts/codeextensions.sh -l ~/linux-stuff/applications/vscode/vscodeextensions.txt")
    
    copy_folder("~/linux-stuff/applications/dwm/", "~")
    copy_folder("~/linux-stuff/applications/dmenu/", "~")
    copy_folder("~/linux-stuff/applications/slock/", "~")
    copy_folder("~/linux-stuff/applications/st/", "~")
    copy_folder("~/linux-stuff/applications/slstatus/", "~")
    make("~/dwm")
    make("~/dmenu")
    make("~/slock")
    make("~/st")
    make("~/slstatus")

    execute("sudo mv ~/dwm/dwm.desktop /usr/share/xsessions/")
    
    copy_file("~/linux-stuff/scripts/statusMenu.sh", "~/dwm")
    copy_file("~/linux-stuff/scripts/toggleVolume.sh", "~/dwm")
    copy_file("~/linux-stuff/scripts/powerMenu.sh", "~/dwm")

    copy_file("~/linux-stuff/system/.vimrc", "~")

    # See information here: https://github.com/yshui/picom
    clone("https://github.com/yshui/picom", "~/picom")
    execute("git submodule update --init --recursive")
    execute("meson --buildtype=release . build")
    execute("ninja -C build")
    execute("ninja -C build install")

    download_and_run("http://installer.jdownloader.org/JD2SilentSetup_x64.sh")
    
    make_folder_contents_executable("~/linux-stuff/scripts/")
    
    copy_folder("~/linux-stuff/wallpapers/", "~/wallpapers")     

    shutdown_prompt()
    

def install_packages(install : str, packages : List[str] = [], alt_install : str = "") -> None:
    """
    Install the required packages:
    - `install`: the default command used to install programs.
    - `alt_install`: command used to install programs if `install` fails, defaults to `install`.
    - `packages`: the list of programs to install.
    Commands are called using `subprocess.check_output()`.
    """
    
    if not install or packages == []:
        print(f"You must provide an install command and a list of packages to install.")
        return
    
    alt_install = install if alt_install == "" else alt_install
    install_command = install.strip().split(' ')
    alt_install_command = alt_install.strip().split(' ')
    
    installed = []
    not_installed = []

    for package in packages:
        try:
            print(f"Attempting to install {package} using '{install}'.")
            subprocess.check_output(install_command + [package])
            installed.append(package)
        except:
            try:
                print(f"Could not install {package} with '{install}', trying with '{alt_install}'.")
                subprocess.check_output(alt_install_command + [package])
                installed.append(package)
            except:
                print(f"Could not install {package}.")
                not_installed.append(package)

    print(f"Installed: {installed}\nNot Installed: {not_installed}")


def copy_file(src : str, dst : str = "~") -> None:
    """
    Copy a file located at `src` to the directory `dst`. 
    If the directory doesn't exist, it'll be created.
    Default destination `~`.
    """
    source = Path(os.path.expanduser(src))
    destination = Path(os.path.expanduser(dst))

    if not source.is_file():
        raise Exception(f"{src} is not a valid file")

    print(f"Copying file {src} to {dst}.")

    if not destination.is_dir():
        destination.mkdir()
    try:
        shutil.copy2(source, destination)
    except:
        check = input(f"Couldn't copy {src} to {dst}. Would you like to try with 'sudo'? (y/N)\n")
        if check in 'n':
            print(f"{src} was not copied to {dst}.")
        else:
            try:
                subprocess.check_output(["sudo", "cp", "-f", source, destination])
            except:
                print(f"Could not copy {src} to {dst} with sudo.")


def copy_folder(src : str, dst : str = "~") -> None:
    """
    Copy all files located in the directory `src` to the directory `dst`. 
    If the directory doesn't exist, it'll be created.
    Default destination `~`.
    """
    
    if not src:
        print(f"You must provide a source directory.")
        return
    
    source = Path(os.path.expanduser(src))
    destination = Path(os.path.expanduser(dst))

    print(f"Copying files in {src} to {dst}.")

    if not destination.is_dir():
        destination.mkdir()
    for file in os.listdir(path=source):
        if Path(f"{source}/{file}").is_file():
            print(f"\tCopying {src}{file} to {dst}.")
            shutil.copy2(f"{source}/{file}", destination)
        elif Path(f"{source}/{file}").is_dir():
            copy_folder(f"{source}/{file}", f"{destination}/{file}")


def make_executable(src : str) -> None:
    """
    Make a file executable.
    """
    
    if not src:
        print(f"You must provide a source file to make executable.")
        return
    
    file = Path(os.path.expanduser(src))

    if not file.is_file():
        raise Exception(f"{src} is not a valid file")

    print(f"Making {src} executable.")
    subprocess.run(["chmod", "+x", file])


def make_folder_contents_executable(src : str) -> None:
    """
    Make all files in a folder executable.
    """
    
    if not src:
        print(f"You must provide a source folder whose contents you wish to make executable.")
        return
    
    folder = Path(os.path.expanduser(src))

    if not folder.is_dir():
        raise Exception(f"{src} is not a valid folder")

    print(f"In folder '{src}':")
    
    for file in os.listdir(path=folder):
        print(f"\tMaking '{file}' executable.")
        subprocess.run(["chmod", "+x", f"{folder}/{file}"])


def download_and_run(url : str, dst : str = "~/Downloads") -> None:
    """
    Use wget to download a script and then execute it.
    Default destination `~/Downloads`.
    """
    destination = Path(os.path.expanduser(dst))

    if not url:
        print(f"You must provide an url to download with wget.")
        return
        
    file = url.split('/')[-1]

    try:
        subprocess.run(["wget", "-P", destination, url])
        subprocess.check_output(["bash", f"{destination}/{file}"])
    except:
        print(f"Could not download and run {url}.")
            

def clone(url : str, dst : str = ".") -> None:
    """
    Clone a git directory.
    Default destination `.`.
    """
    destination = Path(os.path.expanduser(dst))
    
    if not url:
        print(f"You must provide an url to clone.")
        return

    try:
        subprocess.run(["git", "clone", url, destination])
    except:
        print(f"Could not clone {url} to {dst}.")


def make(loc : str = ".") -> None:
    """
    CD into `loc` and make the contents assuming there is a makefile.
    """
    location = Path(os.path.expanduser(loc))
    
    try:
        subprocess.check_output(["make", "-C", loc])
    except:
        print(f"Could not make {loc}")


def execute(script : str) -> None:
    """
    Run `script`.
    """
    def fix_path(word : str) -> str:
        return os.path.expanduser(word) if '/' in word else word
        
    if not script:
        print(f"You must provide a script to execute.")
        return

    for line in script.split('\n'):
        stripped = line.strip()
        if stripped != '' and stripped[0] != '#':
            print(f"Running '{stripped}'.")
            subprocess.run([fix_path(word) for word in stripped.split(' ')])


def shutdown_prompt() -> None:
    """
    Prompt a shutdown.
    """
    check = input("Setup complete - would you like to reboot? (y/N)\n")
    if check in 'n':
        exit()
    else:
        os.system("reboot")


if __name__ == "__main__":
    main()
