# setup.py (requires Python 3.8)

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

    copy_folder("linux-stuff/wallpapers/", "wallpapers") # Leave out ~/ because subprocess doesn't like it
    copy_folder("linux-stuff/rofi/", "rofi")
    copy_folder("linux-stuff/i3/", ".config/i3")
    copy_folder("linux-stuff/ranger/", ".config/ranger")
    copy_folder("linux-stuff/polybar/", ".config/polybar")
    copy_folder("linux-stuff/system stuff/")

    copy_file("linux-stuff/fonts/Font Awesome 5 Free-Solid-900.otf", "/usr/share/fonts/opentype")
    execute("sudo fc-cache -f -v")

    copy_file("linux-stuff/vscode/settings.json", ".config/Code/User/")
    execute("bash linux-stuff/scripts/codeextensions.sh -l vscode/vscodeextensions.txt")

    download_and_run("http://installer.jdownloader.org/JD2SilentSetup_x64.sh")

    make_folder_contents_executable("linux-stuff/scripts/")

    shutdown_prompt()


def install_packages(installCommand : str, packages : List[str], altInstallCommand : str = "") -> None:
    """
    Install the required packages:
    - `installCommand`: the default command used to install programs. In a form to be used with `subprocess.run()` or subprocess.check_output()`.
    - `altInstallCommand`: the secondary command used to install programs if `install_command` can't install a package.
    - `packages`: the list of programs to install.
    """
    install_command = installCommand.strip().split(' ')
    alt_install_command = install_command if altInstallCommand == "" else altInstallCommand.strip().split(' ')
    
    installed = []
    notInstalled = []

    for package in packages:
        try:
            print(f"Attempting to install {package} using '{' '.join(install_command)}'.")
            subprocess.check_output(install_command + [package])
            installed.append(package)
        except:
            try:
                print(f"Could not install {package} with '{' '.join(install_command)}'.\nAttempting to install {package} using '{' '.join(alt_install_command)}'.")
                subprocess.check_output(alt_install_command + [package])
                installed.append(package)
            except:
                print(f"Could not install {package}.")
                notInstalled.append(package)

    print(f"Installed: {installed}")
    print(f"Not Installed: {notInstalled}")


def copy_file(src : str, dst : str = "") -> None:
    """
    Copy a file located at `src` to the directory `dst`. If the directory doesn't exist, it'll be created.
    Default destination found using `os.path.expanduser("~")`
    """
    dst = dst if dst != "" else os.path.expanduser("~")
    destination = Path(dst)

    print(f"Copying file {src} to {dst}.")

    if not destination.is_dir():
        destination.mkdir()
    try:
        shutil.copy2(src, dst)
    except:
        check = input(f"Couldn't copy {src} to {dst}. This may be due to a lack of permissions. Would you like to try with 'sudo'? (y/n)\n")
        if check in 'n':
            print(f"{src} was not copied to {dst}.")
        else:
            try:
                subprocess.check_output(["sudo", "cp", "-f", src, dst])
            except:
                print(f"Could not copy {src} to {dst} with sudo.")


def copy_folder(srcFolder : str, dstFolder : str = "") -> None:
    """
    Copy all files located in the directory `src` to the directory `dst`. If the directory doesn't exist, it'll be created.
    Default destination found using `os.path.expanduser("~")`
    """
    dstFolder = dstFolder if dstFolder != "" else os.path.expanduser("~")
    destination = Path(dstFolder)

    print(f"Copying files in {srcFolder} to {dstFolder}.")

    if not destination.is_dir():
        destination.mkdir()
    for file in os.listdir(path=srcFolder):
        if Path(f"{srcFolder}/{file}").is_file():
            shutil.copy2(f"{srcFolder}/{file}", dstFolder)
        elif Path(f"{srcFolder}/{file}").is_dir():
            copy_folder(f"{srcFolder}/{file}", f"{dstFolder}/{file}")


def make_executable(file : str) -> None:
    """
    Make a file executable.
    """
    if not Path(file).is_file():
        raise Exception(f"{file} is not a valid file")

    print(f"Making {file} executable.")
    subprocess.run(["chmod", "+x", src])


def make_folder_contents_executable(folder : str) -> None:
    """
    Make all files in a folder executable.
    """
    if not Path(folder).is_dir():
        raise Exception(f"{folder} is not a valid folder")

    print(f"In folder '{Path(folder)}':")
    
    for file in os.listdir(path=folder):
        print(f"    - Making '{file}' executable.")
        subprocess.run(["chmod", "+x", f"{folder}/{file}"])


def download_and_run(url : str, dstFolder : str = "") -> None:
    """
    Use wget to download a script and then execute it.
    Default destination found using `os.path.expanduser("~/Downloads")`
    """
    dstFolder = dstFolder if dstFolder != "" else os.path.expanduser("~/Downloads")
    destination = Path(dstFolder)

    file = url.split('/')[-1]

    subprocess.run(["wget", "-P", destination, url])
    subprocess.check_output(["bash", f"{destination}/{file}"])


def execute(script : str) -> None:
    """
    Run `script`.
    """
    lines = [line.strip().split(' ') for line in script.split('\n') if (stripped := line.strip()) is not '' and stripped[0] != '#']

    for line in lines:
        print(f"Running '{' '.join(line)}'.")
        subprocess.check_output(line)


def shutdown_prompt() -> None:
    """
    Prompt a shutdown.
    """
    check = input("You should restart your computer to finalise changes (sourcing bashrc and Xresources etc.), would you like to now? (y/n)\n")
    if check in 'n':
        exit()
    else:
        os.system("reboot")


if __name__ == "__main__":
    main()
