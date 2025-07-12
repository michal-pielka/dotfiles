from kittens.tui.handler import result_handler

def main(args):
    pass

@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    direction = args[1]
    tab = boss.active_tab

    if direction == 'left':
        tab.resize_window('wider', 1)
    elif direction == 'right':
        tab.resize_window('narrower', 1)
    elif direction == 'up':
        tab.resize_window('taller', 1)
    elif direction == 'down':
        tab.resize_window('shorter', 1)
