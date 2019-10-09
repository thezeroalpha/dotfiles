# Makefile for emacs-lisp package

# Copyright (C) 1998, 1999, 2004, 2007, 2010  Stefan Monnier <monnier@gnu.org>

# This file is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 3, or (at your option) any
# later version.

# This file is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.

# You should have received a copy of the GNU General Public License
# along with GNU Emacs; see the file COPYING.  If not, write to
# the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

# load the package-specific settings
include makefile.pkg

# set up the usual installation paths
prefix  = /usr/local
datadir = $(prefix)/share

# the directory where you install third-party emacs packges
lispdir = $(datadir)/emacs/site-lisp

# the directory where the .elc files will be installed
elcdir  = $(lispdir)/$(PACKAGE)
# the directory where the .el files will be installed
eldir   = $(elcdir)

# the file where the initialization goes.
#startupfile = $(HOME/.emacs
startupfile = $(lispdir)/site-start.el

# the directory where you installed the elib .elc files.
# This is only needed if your site-start.el (or default.el) does not
# set up elib correctly.
elibdir = $(lispdir)/elib

# the directory where you install the info doc
infodir = $(prefix)/info
docdir = $(prefix)/doc

EMACS	= emacs
MAKEINFO= makeinfo
TEXI2DVI= texi2dvi
SHELL	= /bin/sh
DVIPS	= dvips
CP	= cp
RM	= rm -f
MKDIR	= mkdir -p
ETAGS	= etags

######################################################################
###        No changes below this line should be necessary          ###
######################################################################

ELFLAGS	= --eval '(setq load-path (append (list "." "$(elibdir)" "$(lispdir)") load-path))'
ELC	= $(EMACS) -batch $(ELFLAGS) -f batch-byte-compile

ELCFILES = $(ELFILES:.el=.elc)

TEXEXTS =  *.cps *.fns *.kys *.vr *.tp *.pg *.log *.aux *.toc *.cp *.ky *.fn

.SUFFIXES: .elc .el .info .ps .dvi .texi
.PHONY: elcfiles info clean distclean default
.PHONY: install_startup install_elc install install_el install_info
.PHONY: dvi postscript

.el.elc:
	$(ELC) $<

.texi.info:
	$(MAKEINFO) $<

.texi.dvi:
	$(TEXI2DVI) $<

.dvi.ps:
	$(DVIPS) -f $< >$@

######################################################################

default: elcfiles

elcfiles: $(ELCFILES)
info: $(PACKAGE).info

install_elc: $(ELCFILES) $(PACKAGE)-startup.el
	$(MKDIR) $(elcdir)
	for f in $(ELCFILES) $(PACKAGE)-startup.el; do \
	    $(CP) $$f $(elcdir)/$$f ;\
	done

install_el:
	$(MKDIR) $(eldir)
	for f in $(ELFILES); do \
	    $(CP) $$f $(eldir)/$$f ;\
	done

install_info: $(PACKAGE).info
	$(MKDIR) $(infodir)
	$(CP) *.info* $(infodir)/
	-[ ! -w $(infodir)/dir ] \
	    || install-info --info-dir=$(infodir)/dir $(PACKAGE).info

install_startup:
	$(MKDIR) $(lispdir)
	@if grep $(PACKAGE) $(lispdir)/site-start.el >/dev/null 2>&1 || \
	    grep $(PACKAGE) $(startupfile) >/dev/null 2>&1 || \
	    grep $(PACKAGE) $(lispdir)/default.el >/dev/null 2>&1; \
	then \
	    echo "**********************************************************" ;\
	    echo "*** It seems you already have some setup code" ;\
	    echo "*** for $(PACKAGE) in your startup files." ;\
	    echo "*** Check that it properly loads \"$(PACKAGE)-startup\"" ;\
	    echo "**********************************************************" ;\
	else \
	    echo 'echo ";; load $(PACKAGE) setup code" >>$(startupfile)' ;\
	    echo ";; load $(PACKAGE) setup code" >>$(startupfile) ;\
	    echo 'echo "(load \"$(elcdir)/$(PACKAGE)-startup\")" >>$(startupfile)' ;\
	    echo "(load \"$(elcdir)/$(PACKAGE)-startup\")" >>$(startupfile) ;\
	fi

postscript: $(PACKAGE).ps
dvi: $(PACKAGE).dvi
install_dvi: dvi
	$(MKDIR) $(docdir)
	$(CP) `find . -type f -name '*.dvi' -print` $(docdir)/

install: install_elc install_info install_startup install_el

clean:
	$(RM) *~ core .\#* $(TEXEXTS)

TAGS tags:
	$(ETAGS) $(ELFILES)

distclean: clean
	$(RM) *.elc *.dvi *.info* *.ps

######################################################################
###                    don't look below                            ###
######################################################################

$(PACKAGE)-startup.el: $(ELFILES)
	echo "\
	;;; $@ --- automatically extracted autoloads\n\
	;;; Code:\n\
	(add-to-list 'load-path\n\
	             (or (file-name-directory load-file-name) (car load-path)))\n\
	" >$@
	$(EMACS) --batch --eval '(setq generated-autoload-file "'`pwd`'/$@")' -f batch-update-autoloads "."

##

#TAG = $(shell echo v$(VERSION) | tr '.' '_')
URL=$(shell sed -n -e '5p' .svn/entries)
TAG=$(shell dirname "$(URL)")/releases/$(PACKAGE)-$(VERSION)
ftpdir=/u/monnier/html/elisp/
cvsmodule=$(shell cat CVS/Repository)
cvsroot=$(shell cat CVS/Root)

dist:
	svn cp . "$(TAG)" &&\
	svn export "$(TAG)" "$(TMP)/$(PACKAGE)-$(VERSION)" &&\
	cd "$(TMP)/$(PACKAGE)-$(VERSION)" &&\
	$(MAKE) info $(PACKAGE)-startup.el &&\
	cd .. &&\
	ztar $(PACKAGE)-$(VERSION) &&\
	rm -rf $(PACKAGE)-$(VERSION)
	mv $(TMP)/$(PACKAGE)-$(VERSION).tar.gz $(ftpdir)/
	ln -sf $(PACKAGE)-$(VERSION).tar.gz $(ftpdir)/$(PACKAGE).tar.gz
