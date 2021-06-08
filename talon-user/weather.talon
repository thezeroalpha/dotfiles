weather forecast: user.system_path_command('env LESS="RiX" setsid -f alacritty -e weather nebusice')
weather now:
    speech.disable()
    user.system_path_command('curl -sL https://wttr.in/\\?format=%C:%t:%f:%w:%p\\&m | ruby -e "d=ARGF.read.split(\':\'); puts d.first + \', temperature \' + d[2] + \', wind \' + d[3] + \', rain \' + d[4]" | say')
    speech.enable()
