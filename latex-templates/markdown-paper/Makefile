FLAGS = -f markdown --citeproc
pdf = paper.pdf
src = paper.md

all: $(pdf)

$(pdf): $(src)
	pandoc $(src) $(FLAGS) -o $(pdf)
