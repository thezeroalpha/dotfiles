caffeinate start: user.system_command('killall caffeinate; setsid -f caffeinate -d && notify "Caffeinated" "Sleep disabled" talon')
caffeinate stop: user.system_command('killall caffeinate && notify "Sleepy" "Will sleep again" talon')
