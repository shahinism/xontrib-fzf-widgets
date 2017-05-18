import os
import re
from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import Condition, EmacsInsertMode, ViInsertMode

def check_command(cmd):
    result = $(which @(cmd))
    return os.path.exists(result)


class RequiredCommand:
    def __init__(self, cmd):
        self.cmd = check_command(cmd)

    def __call__(self, func):
        def error():
            print("fzf-widgets: command not found: {}".format(self.cmd))

        def wrapped(*args):
            func(*args)

        if self.cmd:
            return wrapped
        else:
            return error


def get_fzf_selector():
    if $(echo $TMUX):
        return 'fzf-tmux'
    return 'fzf'


def fzf_insert(items, current_buffer, prefix='', suffix=''):
    selector = get_fzf_selector()
    choice = $(echo @(items) | @(selector) --tac  --tiebreak=index +m).replace('\n', '')

    if choice:
        command = prefix + choice + suffix
        current_buffer.insert_text(command)


@events.on_ptk_create
def custom_keybindings(bindings, **kw):
    def handler(key):
        def do_nothing(func):
            pass

        if key:
            return bindings.registry.add_binding(key)
        return do_nothing

    @handler(fzf_history_binding)
    @RequiredCommand('fzf')
    def fzf_history(event):
        items = $(history show all)
        fzf_insert(items, event.current_buffer)

    @handler(fzf_ssh_binding)
    @RequiredCommand('fzf')
    def fzf_ssh(event):
        items = re.sub(r'(?i)host ', '', $(cat ~/.ssh/config /etc/ssh/ssh_config | grep -i '^host'))
        fzf_insert(items, event.current_buffer, prefix='ssh ')


fzf_history_binding = Keys.ControlR
fzf_ssh_binding = Keys.ControlS
