print_message () {

    local messages
    local message

    ### STANDARD INSULTS ###
    declare -a array1=(
        "(╯°□°）╯︵ ┻━┻"
        "¯\_(ツ)_/¯"
        "ACHTUNG! ALLES TURISTEN UND NONTEKNISCHEN LOOKENPEEPERS! DAS KOMPUTERMASCHINE IST NICHT FÜR DER GEFINGERPOKEN UND MITTENGRABEN! ODERWISE IST EASY TO SCHNAPPEN DER SPRINGENWERK, BLOWENFUSEN UND POPPENCORKEN MIT SPITZENSPARKEN. IST NICHT FÜR GEWERKEN BEI DUMMKOPFEN. DER RUBBERNECKEN SIGHTSEEREN KEEPEN DAS COTTONPICKEN HÄNDER IN DAS POCKETS MUSS. ZO RELAXEN UND WATSCHEN DER BLINKENLICHTEN."
        "And the Darwin Award goes to.... ${USER}!"
        "Allowing you to survive childbirth was medical malpractice."
        "Are you always this stupid or are you making a special effort today?!"
        "Are you even trying?!"
        "Bad."
        "Boooo!"
        "Brains aren't everything. In your case they're nothing."
        "Commands, random gibberish, who cares!"
        "Come on! You can do it!"
        "Don't you have anything better to do?!"
        "Don't you know anything?"
        "Dropped on your head as a baby, eh?"
        "error code: 1D10T"
        "Even your mom loves you only as a friend."
        "ERROR_INCOMPETENT_USER"
        "Fake it till you make it!"
        "Go outside."
        "Haha, n00b!"
        "How many times do I have to flush before you go away?"
        "I am _seriously_ considering 'rm -rf /'-ing myself..."
        "I don't know what makes you so stupid, but it really works."
        "I was going to give you a nasty look, but I see you already have one."
        "If beauty fades then you have nothing to worry about."
        "If brains were gasoline you wouldn’t have enough to propel a flea’s motorcycle around a doughnut."
        "If ignorance is bliss, you must be the happiest person on earth."
        "If shit was music, you'd be an orchestra."
        "If what you don't know can't hurt you, you're invulnerable."
        "Incompetence is also a form of competence"
        "I’d slap you, but that’d be animal abuse."
        "I’ve heard of being hit with the ugly stick, but you must have been beaten senseless with it."
        "Keep trying, someday you'll do something intelligent!"
        "Let’s play horse. I’ll be the front end. And you be yourself."
        "Life is good, you should get one."
        "lol"
        "lol... plz"
        "My keyboard is not a touch screen!"
        "My uptime is longer than your relationships."
        "Nice try."
        "n00b alert!"
        "Pathetic"
        "Perhaps computers are not for you..."
        "Perhaps you should leave the command line alone..."
        "Please step away from the keyboard!"
        "plz uninstall"
        "Pro tip: type a valid command!"
        "Rose are red. Violets are blue. I have five fingers. The middle one's for you."
        "RTFM!"
        "Sorry what? I don’t understand idiot language."
        "The degree of your stupidity is enough to boil water."
        "The worst one today!"
        "This is not a search engine."
        "This is not Windows"
        "This is why nobody likes you."
        "This is why you get to see your children only once a month."
        "Try using your brain the next time!"
        "Two wrongs don't make a right, take your parents as an example."
        "Typing incorrect commands, eh?"
        "u suk"
        "What if... you type an actual command the next time!"
        "What if I told you... it is possible to type valid commands."
        "What is this...? Amateur hour!?"
        "Why are you so stupid?!"
        "Why are you doing this to me?!"
        "Why did the chicken cross the road? To get the hell away from you."
        "Wow! That was impressively wrong!"
        "Y u no speak computer???"
        "You are not as bad as people say, you are much, much worse."
        "You are not useless since you can still be used as a bad example."
        "You must have been born on a highway because that's where most accidents happen."
        "Your application for reduced salary has been sent!"
        "Your mom had a severe case of diarrhea when you were born."
        "You're proof that god has a sense of humor."
        "You’re so dumb your first words were DUH."
        "You're so fat, people jog around you for exercise."
        "You’re the reason Santa says ho, ho, ho, on Christmas!"
    )
    ### SHAKESPEARE INSULTS ###
    declare -a array2=(
        "A most notable coward, an infinite and endless liar, an hourly promise breaker, the owner of no one good quality."
        "Away, you starvelling, you elf-skin, you dried neat's-tongue, bull's-pizzle, you stock-fish!"
        "Away, you three-inch fool! "
        "Come, come, you froward and unable worms!"
        "Go, prick thy face, and over-red thy fear, Thou lily-liver’d boy."
        "His wit's as thick as a Tewkesbury mustard."
        "I am pigeon-liver'd and lack gall."
        "I am sick when I do look on thee "
        "I must tell you friendly in your ear, sell when you can, you are not for all markets."
        "If thou wilt needs marry, marry a fool; for wise men know well enough what monsters you make of them."
        "I'll beat thee, but I would infect my hands."
        "I scorn you, scurvy companion. "
        "Methink'st thou art a general offence and every man should beat thee."
        "More of your conversation would infect my brain."
        "My wife's a hobby horse!"
        "Peace, ye fat guts!"
        "Poisonous bunch-backed toad! "
        "The rankest compound of villainous smell that ever offended nostril"
        "The tartness of his face sours ripe grapes."
        "There's no more faith in thee than in a stewed prune."
        "Thine forward voice, now, is to speak well of thine friend; thine backward voice is to utter foul speeches and to detract."
        "That trunk of humours, that bolting-hutch of beastliness, that swollen parcel of dropsies, that huge bombard of sack, that stuffed cloak-bag of guts, that roasted Manningtree ox with pudding in his belly, that reverend vice, that grey Iniquity, that father ruffian, that vanity in years?"
        "Thine face is not worth sunburning."
        "This woman's an easy glove, my lord, she goes off and on at pleasure."
        "Thou art a boil, a plague sore."
        "Was the Duke a flesh-monger, a fool and a coward?"
        "Thou art as fat as butter."
        "Here is the babe, as loathsome as a toad."
        "Like the toad; ugly and venomous."
        "Thou art unfit for any place but hell."
        "Thou cream faced loon"
        "Thou clay-brained guts, thou knotty-pated fool, thou whoreson obscene greasy tallow-catch!"
        "Thou damned and luxurious mountain goat."
        "Thou elvish-mark'd, abortive, rooting hog!"
        "Thou leathern-jerkin, crystal-button, knot-pated, agatering, puke-stocking, caddis-garter, smooth-tongue, Spanish pouch!"
        "Thou lump of foul deformity"
        "That poisonous bunch-back'd toad!"
        "Thou sodden-witted lord! Thou hast no more brain than I have in mine elbows "
        "Thou subtle, perjur'd, false, disloyal man!"
        "Thou whoreson zed , thou unnecessary letter!"
        "Thy sin’s not accidental, but a trade."
        "Thy tongue outvenoms all the worms of Nile."
        "Would thou wert clean enough to spit upon"
        "Would thou wouldst burst!"
        "You poor, base, rascally, cheating lack-linen mate! "
        "You are as a candle, the better burnt out."
        "You scullion! You rampallian! You fustilarian! I’ll tickle your catastrophe!"
        "You starvelling, you eel-skin, you dried neat's-tongue, you bull's-pizzle, you stock-fish-O for breath to utter what is like thee!-you tailor's-yard, you sheath, you bow-case, you vile standing tuck!"
        "Your brain is as dry as the remainder biscuit after voyage."
        "Virginity breeds mites, much like a cheese."
        "Villain, I have done thy mother"
    )
    ### MARTIN LUTHER INSULTS ###
    declare -a array3=(
        "You live like simple cattle or irrational pigs and, despite the fact that the gospel has returned, have mastered the fine art of misusing all your freedom."
        "You shameful gluttons and servants of your bellies are better suited to be swineherds and keepers of dogs."
        "You deserve not only to be given no food to eat, but also to have the dogs set upon you and to be pelted with horse manure."
        "Oh, what mad senseless fools you are!"
        "For this you deserve to have God deprive you of his Word and blessing and once again allow preachers of lies to arise who lead you to the devil - and wring sweat and blood out of you besides."
        "All your holiness is only stench and filth, and it merits nothing but wrath and damnation."
        "May your grain spoil in the barn, your beer in the cellar, your cattle perish in the stall. Yes, your entire hoard ought to be consumed by rust so that you will never enjoy it."
        "You relish and delight in the chance to stir up someone else's dirt like pigs that roll in manure and root around in it with their snouts."
        "Your sin smells to high heaven."
        "Your words are so foolishly and ignorantly composed that I cannot believe you understand them."
        "You are the most insane heretics and ingrafters of heretical perversity."
        "What you say is a blasphemy that has made you worthy of a thousand deaths."
        "Behold, indeed, this little golden work of a golden teacher! It is a work most worthy of golden letters, and lest there be something about it which is not golden, it must be handed down by golden disciples, namely, by those about whom it is said, 'The idols of the nations are silver and gold. They have eyes, but they see not.'"
        "You are worthy only to be mocked by the words of error."
        "It is presumptuous for people who are as ignorant as you are not to take up the work of a herdsman."
        "What bilgewater of heresies has ever been spoken so heretically as what you have said?"
        "What do you mean when you say this? Are you dreaming in the throes of a fever or are you laboring under a madness?"
        "Your astute minds have been completely turned into stinking mushrooms."
        "You are the prostitute of heretics!"
        "I am tired of the pestilent voice of your sirens."
        "You are a bungling magpie, croaking loudly."
        "You forgot to purge yourself with hellabore while you were preparing to fabricate this lie."
        "You are more corrupt than any Babylon or Sodom ever was, and, as far as I can see, are characterized by a completely depraved, hopeless, and notorious godlessness."
        "Your home, once the holiest of all, has become the most licentious den of thieves, the most shameless of all brothels, the kingdom of sin, death, and hell. It is so bad that even Antichrist himself, if he should come, could think of nothing to add to its wickedness."
        "What devilish unchristian thing would you not undertake?"
        "You are an extraordinary creature, being neither God nor man. Perhaps you are the devil himself."
        "Even if the Antichrist appears, what greater evil can he do than what you have done and do daily?"
        "It may be that you want to build yourself a heaven of your own, like those jugglers build themselves out of linen cloth at the Shrove Tuesday carnival. Is it not disgusting that we have to hear such foolish and childish things from you?"
        "In our country, fruit grows on trees and from trees, and meditation upon sin grows from contrition. But in your land, trees may grow on fruits, contrition from sins, people walk on their ears, and everything is upside down."
        "O you wolf in Christendom!"
        "You know less than does a log on the ground."
        "I think that all the devils have at once entered into you."
        "You are worse than all the devils. What you have done, no devil has ever done. Your end is near, you son of perdition and Antichrist! Stop now, you are going to far!"
        "You are the true, chief, and final Antichrist."
        "How far will you go, O devilish pride?"
        "All Christians should be on guard against your antichristian poison."
        "I think you received these ideas in your pipe dreams."
        "You are in all you do the very opposite of Christ as befits a true Antichrist."
        "You are a person of sin and the child of perdition, leading all the world with you to the devil, using your lying and deceitful ways."
        "You are not a pious fraud, but an infernal, diabolical, antichristian fraud."
        "You are the Roman Nimrod and a teacher of sin."
        "It is the old dragon from the abyss of hell who is standing before me!"
        "You hold fast to human dreams and the doctrines of devils."
        "If you who are assembled in a council are so frivolous and irresponsible as to waste time and money on unnecessary questions, when it is the business of a council to deal only with the important and necessary matters, we should not only refuse to obey you, but consider you insane or criminals."
        "Even Lucifer was not guilty of so great a sacrilege in heaven, for he only presumed to be God's equal. God help us!"
        "You condemned the holy gospel and replaced it with the teaching of the dragon from hell."
        "Your words are un-Christian, antichristian, and spoken by the inspiration of the evil spirit."
        "What happened to the house built on sand in Matthew 7 will also happen to you."
        "Must we believe your nightmares?"
        "Look how this great heretic speaks brazenly and sacrilegiously."
        "You run against God with the horns of your pride up in the air and thus plunge into the abyss of hell. Woe unto you, Antichrist!"
        "You are the devil's most dangerous tool!"
        "It seems I must have liars and villains for opponents. I am not worthy in the sight of God that a godly and honorable person should discuss these matters with me in a Christian way. This is my greatest lament."
        "May the Lord Jesus protect me and all devout souls from your contagion and your company!"
        "This venom - the mere smell of which kills a man!"
        "You are a Baal-zebub - that is, a man of flies."
        "You are full of poisonous refuse and insane foolishness."
        "You are ignorant, stupid, godless blasphemers."
        "You moderate enforcer and eulogizer of moderation. You are one of those bloody and deceitful people who affect modesty in words and appearance, but who meanwhile breathe out threats and blood."
        "We leave you to your own devices, for nothing properly suits you except hypocrisy, flattery, and lies."
        "In lying fashion you ignore what even children know."
        "The reward of such flattery is what your crass stupidity deserves. Therefore, we shall turn from you, a sevenfold stupid and blasphemous wise person."
        "People of your sort are hirelings, dumb dogs unable to bark, who see the wolf coming and flee or, rather, join up with the wolf."
        "You are a wolf and apostle of Satan."
        "You are the ultimate scourges of the world, the Antichrist together with your sophists and bishops."
        "You cowardly slave, you corrupt sycophant, with your sickening advice!"
        "You are idiots and swine."
        "Every letter of yours breathes Moabitish pride. So much can a single bull inflate a single bubble that you practically make distinguished asses into gods."
        "You sophistic worms, grasshoppers, locusts, frogs and lice!"
        "You completely close your mind and do nothing but shout, "Anathema, anathema, anathema!" so that by your own voice you are judged mad."
        "Let this generation of vipers prepare itself for unquenchable fire!"
        "You rush forward as an ass under the pelt of a lion."
        "In appearance and words you simulate modesty, but you are so swollen with haughtiness, arrogance, pride, malice, villainy, rashness, superciliousness, ignorance, and stupidity that there is nothing to surpass you."
        "Blind moles!"
        "We despise your whorish impudence."
    )
    ### EDIT THIS LINE IF YOU ONLY WANT TO USE CERTAIN INSULT LISTS ###
    messages=( "${array1[@]}" "${array2[@]}" "${array3[@]}" )

    # If CMD_NOT_FOUND_MSGS array is populated use those messages instead of the defaults
    [[ -n ${CMD_NOT_FOUND_MSGS} ]] && messages=( "${CMD_NOT_FOUND_MSGS[@]}" )

    # If CMD_NOT_FOUND_MSGS_APPEND array is populated append those to the existing messages
    [[ -n ${CMD_NOT_FOUND_MSGS_APPEND} ]] && messages+=( "${CMD_NOT_FOUND_MSGS_APPEND[@]}" )

    # Seed RANDOM with an integer of some length
    RANDOM=$(od -vAn -N4 -tu < /dev/urandom)

    # Print a randomly selected message, but only about half the time to annoy the user a
    # little bit less.
    if [[ $((${RANDOM} % 2)) -lt 1 ]]; then
        message=${messages[${RANDOM} % ${#messages[@]}]}
        printf "\n  $(tput bold)$(tput setaf 1)${message}$(tput sgr0)\n\n" >&2
    fi
}

function_exists () {
    # Zsh returns 0 even on non existing functions with -F so use -f
    declare -f $1 > /dev/null
    return $?
}

#
# The idea below is to copy any existing handlers to another function
# name and insert the message in front of the old handler in the
# new handler. By default, neither bash or zsh has has a handler function
# defined, so the default behaviour is replicated.
#
# Also, ensure the handler is only copied once. If we do not ensure this
# the handler would add itself recursively if this file happens to be
# sourced multiple times in the same shell, resulting in a neverending
# stream of messages.
#

if function_exists command_not_found_handler; then
    if ! function_exists orig_command_not_found_handler; then
        eval "orig_$(declare -f command_not_found_handler)"
    fi
else
    orig_command_not_found_handler () {
        printf "zsh: command not found: %s\n" "$1" >&2
        return 127
    }
fi

command_not_found_handler () {
    print_message
    orig_command_not_found_handler "$@"
}
