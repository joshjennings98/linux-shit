# setup.py

import subprocess, sys, os, shutil
from typing import Dict, List
from pathlib import Path


def main(): # Modify stuff in main to change how stuff is set up

    install_command = "sudo apt-get install -y"
    alt_install_command = "sudo snap install"

    packages = [
        "vim",
        "vlc",
        "tesdafklsnmd"
    ]

    install_packages(install_command, packages, alt_install_command)

    copy_folder("~/linux-stuff/wallpapers/", "~/wallpapersjjj") 
    copy_file("~/linux-stuff/wallpapers/nebula.jpg", "~/wallpapersXX55")
    
    copy_folder("~/linux-stuff/rofi/", "~/rofi")
    copy_folder("~/linux-stuff/i3/", "~/.config/i3")
    copy_folder("~/linux-stuff/ranger/", "~/.config/ranger")
    copy_folder("~/linux-stuff/polybar/", "~/.config/polybar")
    copy_folder("~/linux-stuff/system stuff/")
    
    copy_file("~/linux-stuff/fonts/Font Awesome 5 Free-Solid-900.otf", "/usr/share/fonts/opentype")
    execute("sudo fc-cache -f -v")

    copy_file("~/linux-stuff/vscode/settings.json", "~/.config/Code/User/")
    execute("bash ~/linux-stuff/scripts/codeextensions.sh -l ~/linux-stuff/vscode/vscodeextensions.txt")

    download_and_run("http://installer.jdownloader.org/JD2SilentSetup_x64.sh")

    make_folder_contents_executable("~/linux-stuff/scripts/")

    shutdown_prompt()
    

def install_packages(install : str, packages : List[str], alt_install : str = "") -> None:
    """
    Install the required packages:
    - `install`: the default command used to install programs.
    - `alt_install`: command used to install programs if `install` fails, defaults to `install`.
    - `packages`: the list of programs to install.
    Commands are called using `subprocess.run()` or subprocess.check_output()`.
    """
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
    file = Path(os.path.expanduser(src))

    if not file.is_file():
        raise Exception(f"{src} is not a valid file")

    print(f"Making {src} executable.")
    subprocess.run(["chmod", "+x", file])


def make_folder_contents_executable(src : str) -> None:
    """
    Make all files in a folder executable.
    """
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

    file = url.split('/')[-1]

    subprocess.run(["wget", "-P", destination, url])
    subprocess.check_output(["bash", f"{destination}/{file}"])


def execute(script : str) -> None:
    """
    Run `script`.
    """
    def fix_path(word : str) -> str:
        return os.path.expanduser(word) if '/' in word else word

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
