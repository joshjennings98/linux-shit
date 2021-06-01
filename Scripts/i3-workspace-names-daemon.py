#!/usr/bin/env python3

# Dynamically update i3wm workspace names based on the applications running in each.

import os.path
import argparse
import i3ipc

def build_rename(i3, args):
    """
    Build rename callback function to pass to i3ipc.
    """
    delim = args.delimiter
    length = args.max_title_length
    uniq = args.uniq

    def get_name(leaf, length):
        """
        Get the classname of a window.
        """
        for identifier in ('name', 'window_title', 'window_instance', 'window_class'):
            name = getattr(leaf, identifier, None)
            if name is None:
                continue
            if "st-256color" in name:
                return "terminal"
        return name[:length] if name else '?'

    def rename(i3, e):
        """
        Create the callback function that will be used to rename workspaces.
        """
        workspaces = i3.get_tree().workspaces()
        # need to use get_workspaces since the i3 con object doesn't have the visible property for some reason
        workdicts = i3.get_workspaces()
        visible = [workdict.name for workdict in workdicts if workdict.visible]
        visworkspaces = []
        focus = ([workdict.name for workdict in workdicts if workdict.focused] or [None])[0]
        focusname = None

        commands = []
        for workspace in workspaces:
            # currently window classes in programs I use only contain '-' instead of space
            names = [get_name(leaf, length).replace('-', ' ').title() for leaf in workspace.leaves()]
            if uniq:
                seen = set()
                names = [x for x in names if x not in seen and not seen.add(x)]
            names = delim.join(names)
            
            newname = f"{workspace.num}: {names}"

            if workspace.name in visible:
                visworkspaces.append(newname)
            if workspace.name == focus:
                focusname = newname

            if workspace.name != newname:
                old = workspace.name.replace('"', '\\"')
                new = newname.replace('"', '\\"')
                commands.append(f"rename workspace \"{old}\" to \"{new}\"") # escape any double quotes in old or new name.

        # we have to join all the activate workspaces commands into one or the order
        # might get scrambled by multiple i3-msg instances running asyncronously
        # causing the wrong workspace to be activated last, which changes the focus.
        i3.command(u';'.join(commands))
    return rename

def _get_i3_dir():
    """
    Return the path of the i3 directory.
    """
    I3_CONFIG_PATHS = tuple(os.path.expanduser(path) for path in ("~/.i3", "~/.config/i3", "~/.config/i3-regolith")) # standard i3 locations
    for path in I3_CONFIG_PATHS:
        if os.path.isdir(path):
            return path
    raise SystemExit(f"Could not find i3 config directory! Expected one of {I3_CONFIG_PATHS} to be present")

def main():
    """
    Entry point of the program.
    """
    parser = argparse.ArgumentParser(__doc__)
    parser.add_argument("-d", "--delimiter",
                        help="The delimiter used to separate multiple window names in the same workspace.",
                        required=False,
                        default=", ")
    parser.add_argument("-l", "--max_title_length", help="Truncate title to specified length.",
                        required=False,
                        default=20,
                        type=int)
    parser.add_argument("-u", "--uniq", help="Remove duplicate icons in case the same application ",
                        action="store_true",
                        required=False,
                        default=False)
    args = parser.parse_args()

    # build i3-connection
    i3 = i3ipc.Connection()

    rename = build_rename(i3, args)
    for case in ['window::move', 'window::new', 'window::title', 'window::close']:
        i3.on(case, rename)
    i3.main()

if __name__ == '__main__':
    main()
