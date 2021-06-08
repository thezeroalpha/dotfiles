caffeinate start: user.system_path_command('killall caffeinate; setsid -f caffeinate -d && notify "Caffeinated" "Sleep disabled" talon')
caffeinate stop: user.system_path_command('killall caffeinate && notify "Sleepy" "Will sleep again" talon')
caffeinate status: user.system_path_command('if pgrep caffeinate; then notify "Caffeinated" "Not sleeping" talon; else notify "Sleepy" "Will sleep if given the chance" talon; fi')
battery:
    speech.disable()
    user.system_path_command('say "$(battery -p)%"')
    speech.enable()
