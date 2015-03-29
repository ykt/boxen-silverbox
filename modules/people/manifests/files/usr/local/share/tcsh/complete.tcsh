<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<title>complete.tcsh</title>
<style type="text/css">
.enscript-comment { font-style: italic; color: rgb(178,34,34); }
.enscript-function-name { font-weight: bold; color: rgb(0,0,255); }
.enscript-variable-name { font-weight: bold; color: rgb(184,134,11); }
.enscript-keyword { font-weight: bold; color: rgb(160,32,240); }
.enscript-reference { font-weight: bold; color: rgb(95,158,160); }
.enscript-string { font-weight: bold; color: rgb(188,143,143); }
.enscript-builtin { font-weight: bold; color: rgb(218,112,214); }
.enscript-type { font-weight: bold; color: rgb(34,139,34); }
.enscript-highlight { text-decoration: underline; color: 0; }
</style>
</head>
<body id="top">
<h1 style="margin:8px;" id="f1">complete.tcsh&nbsp;&nbsp;&nbsp;<span style="font-weight: normal; font-size: 0.5em;">[<a href="?txt">plain text</a>]</span></h1>
<hr/>
<div></div>
<pre>
#
# $tcsh: complete.tcsh,v 1.51 2007/10/01 21:51:59 christos Exp $
# example file using the new completion code
#
# Debian GNU/Linux
# /usr/share/doc/tcsh/examples/complete.gz
#
# This file may be read from user's ~/.cshrc or ~/.tcshrc file by
# decompressing it into the home directory as ~/.complete and
# then adding the line &quot;source ~/.complete&quot; and maybe defining
# some of the shell variables described below.
#
# Added two Debian-specific completions: dpkg and dpkg-deb (who
# wrote them?). Changed completions of several commands. The ones
# are evaluated if the `traditional_complete' shell variable is
# defined.
#
# Debian enhancements by Vadim Vygonets &lt;<a href="mailto:vadik@cs.huji.ac.il">vadik@cs.huji.ac.il</a>&gt;.
# Bugfixes and apt completions by Miklos Quartus &lt;<a href="mailto:miklos.quartus@nokia.com">miklos.quartus@nokia.com</a>&gt;.
# Cleanup by Martin A. Godisch &lt;<a href="mailto:martin@godisch.de">martin@godisch.de</a>&gt;.

onintr -
if (! $?prompt) goto end

if ($?tcsh) then
    if ($tcsh != 1) then
   	set rev=$tcsh:r
	set rel=$rev:e
	set pat=$tcsh:e
	set rev=$rev:r
    endif
    if ($rev &gt; 5 &amp;&amp; $rel &gt; 1) then
	set _complete=1
    endif
    unset rev rel pat
endif

if ($?_complete) then
    set noglob
    if ( ! $?hosts ) set hosts
    foreach f (&quot;$HOME/.hosts&quot; /usr/local/etc/csh.hosts &quot;$HOME/.rhosts&quot; /etc/hosts.equiv)
        if ( -r &quot;$f&quot; ) then
	    set hosts = ($hosts `grep -v &quot;+&quot; &quot;$f&quot; | grep -E -v &quot;^#&quot; | tr -s &quot; &quot; &quot;	&quot; | cut -f 1`)
	endif
    end
    if ( -r &quot;$HOME/.netrc&quot; ) then
	set f=`awk '/machine/ { print $2 }' &lt; &quot;$HOME/.netrc&quot;` &gt;&amp; /dev/null
	set hosts=($hosts $f)
    endif
    if ( -r &quot;$HOME/.ssh/known_hosts&quot; ) then
	set f=`cat &quot;$HOME/.ssh/known_hosts&quot; | cut -f 1 -d \ ` &gt;&amp; /dev/null
	set f=`cat &quot;$HOME/.ssh/known_hosts&quot; | cut -f 1 -d \ | sed -e 's/,/ /g'` &gt;&amp; /dev/null
	set hosts=($hosts $f)
    endif
    unset f
    if ( ! $?hosts ) then
	set hosts=(hyperion.ee.cornell.edu phaeton.ee.cornell.edu \
		   guillemin.ee.cornell.edu vangogh.cs.berkeley.edu \
		   ftp.uu.net prep.ai.mit.edu export.lcs.mit.edu \
		   labrea.stanford.edu sumex-aim.stanford.edu \
		   tut.cis.ohio-state.edu)
    endif

    complete ywho  	n/*/\$hosts/	# argument from list in $hosts
    complete rsh	p/1/\$hosts/ c/-/&quot;(l n)&quot;/   n/-l/u/ N/-l/c/ n/-/c/ p/2/c/ p/*/f/
    complete ssh	p/1/\$hosts/ c/-/&quot;(l n)&quot;/   n/-l/u/ N/-l/c/ n/-/c/ p/2/c/ p/*/f/
    complete xrsh	p/1/\$hosts/ c/-/&quot;(l 8 e)&quot;/ n/-l/u/ N/-l/c/ n/-/c/ p/2/c/ p/*/f/
    complete rlogin 	p/1/\$hosts/ c/-/&quot;(l 8 e)&quot;/ n/-l/u/
    complete telnet 	p/1/\$hosts/ p/2/x:'&lt;port&gt;'/ n/*/n/

    complete cd  	p/1/d/		# Directories only
    complete chdir 	p/1/d/
    complete pushd 	p/1/d/
    complete popd 	p/1/d/
    complete pu 	p/1/d/
    complete po 	p/1/d/
    complete complete 	p/1/X/		# Completions only
    complete uncomplete	n/*/X/
    complete exec 	p/1/c/		# Commands only
    complete trace 	p/1/c/
    complete strace 	p/1/c/
    complete which	n/*/c/
    complete where	n/*/c/
    complete skill 	p/1/c/
    complete dde	p/1/c/ 
    complete adb	c/-I/d/ n/-/c/ N/-/&quot;(core)&quot;/ p/1/c/ p/2/&quot;(core)&quot;/
    complete sdb	p/1/c/
    complete dbx	c/-I/d/ n/-/c/ N/-/&quot;(core)&quot;/ p/1/c/ p/2/&quot;(core)&quot;/
    complete xdb	p/1/c/
    complete gdb	n/-d/d/ n/*/c/
    complete ups	p/1/c/
    complete set	'c/*=/f/' 'p/1/s/=' 'n/=/f/'
    complete unset	n/*/s/
    complete alias 	p/1/a/		# only aliases are valid
    complete unalias	n/*/a/
    complete xdvi 	n/*/f:*.dvi/	# Only files that match *.dvi
    complete dvips 	n/*/f:*.dvi/
    if ($?traditional_complete) then
        complete tex 	n/*/f:*.tex/	# Only files that match *.tex
    else
        complete tex 	n/*/f:*.{tex,texi}/	# Files that match *.tex and *.texi
    endif
    complete latex 	n/*/f:*.{tex,ltx}/
    complete su		c/--/&quot;(login fast preserve-environment command shell \
			help version)&quot;/	c/-/&quot;(f l m p c s -)&quot;/ \
			n/{-c,--command}/c/ \
			n@{-s,--shell}@'`cat /etc/shells`'@ n/*/u/
    complete cc 	c/-[IL]/d/ \
              c@-l@'`\ls -1 /usr/lib/lib*.a | sed s%^.\*/lib%%\;s%\\.a\$%%`'@ \
			c/-/&quot;(o l c g L I D U)&quot;/ n/*/f:*.[coasi]/
    complete acc 	c/-[IL]/d/ \
       c@-l@'`\ls -1 /usr/lang/SC1.0/lib*.a | sed s%^.\*/lib%%\;s%\\.a\$%%`'@ \
			c/-/&quot;(o l c g L I D U)&quot;/ n/*/f:*.[coasi]/
    complete gcc 	c/-[IL]/d/ \
		 	c/-f/&quot;(caller-saves cse-follow-jumps delayed-branch \
		               elide-constructors expensive-optimizations \
			       float-store force-addr force-mem inline \
			       inline-functions keep-inline-functions \
			       memoize-lookups no-default-inline \
			       no-defer-pop no-function-cse omit-frame-pointer \
			       rerun-cse-after-loop schedule-insns \
			       schedule-insns2 strength-reduce \
			       thread-jumps unroll-all-loops \
			       unroll-loops syntax-only all-virtual \
			       cond-mismatch dollars-in-identifiers \
			       enum-int-equiv no-asm no-builtin \
			       no-strict-prototype signed-bitfields \
			       signed-char this-is-variable unsigned-bitfields \
			       unsigned-char writable-strings call-saved-reg \
			       call-used-reg fixed-reg no-common \
			       no-gnu-binutils nonnull-objects \
			       pcc-struct-return pic PIC shared-data \
			       short-enums short-double volatile)&quot;/ \
		 	c/-W/&quot;(all aggregate-return cast-align cast-qual \
		      	       comment conversion enum-clash error format \
		      	       id-clash-len implicit missing-prototypes \
		      	       no-parentheses pointer-arith return-type shadow \
		      	       strict-prototypes switch uninitialized unused \
		      	       write-strings)&quot;/ \
		 	c/-m/&quot;(68000 68020 68881 bitfield fpa nobitfield rtd \
			       short c68000 c68020 soft-float g gnu unix fpu \
			       no-epilogue)&quot;/ \
		 	c/-d/&quot;(D M N)&quot;/ \
		 	c/-/&quot;(f W vspec v vpath ansi traditional \
			      traditional-cpp trigraphs pedantic x o l c g L \
			      I D U O O2 C E H B b V M MD MM i dynamic \
			      nodtdlib static nostdinc undef)&quot;/ \
		 	c/-l/f:*.a/ \
		 	n/*/f:*.{c,C,cc,o,a,s,i}/
    complete g++ 	n/*/f:*.{C,cc,o,s,i}/
    complete CC 	n/*/f:*.{C,cc,cpp,o,s,i}/
    complete rm 	c/--/&quot;(directory force interactive verbose \
			recursive help version)&quot;/ c/-/&quot;(d f i v r R -)&quot;/ \
			n/*/f:^*.{c,cc,C,h,in}/	# Protect precious files
    complete vi 	n/*/f:^*.[oa]/
    complete bindkey    N/-a/b/ N/-c/c/ n/-[ascr]/'x:&lt;key-sequence&gt;'/ \
			n/-[svedlr]/n/ c/-[vedl]/n/ c/-/&quot;(a s k c v e d l r)&quot;/\
			n/-k/&quot;(left right up down)&quot;/ p/2-/b/ \
			p/1/'x:&lt;key-sequence or option&gt;'/

    complete find 	n/-fstype/&quot;(nfs 4.2)&quot;/ n/-name/f/ \
		  	n/-type/&quot;(c b d f p l s)&quot;/ n/-user/u/ n/-group/g/ \
			n/-exec/c/ n/-ok/c/ n/-cpio/f/ n/-ncpio/f/ n/-newer/f/ \
		  	c/-/&quot;(fstype name perm prune type user nouser \
		  	     group nogroup size inum atime mtime ctime exec \
			     ok print ls cpio ncpio newer xdev depth \
			     daystart follow maxdepth mindepth noleaf version \
			     anewer cnewer amin cmin mmin true false uid gid \
			     ilname iname ipath iregex links lname empty path \
			     regex used xtype fprint fprint0 fprintf \
			     print0 printf not a and o or)&quot;/ \
			     n/*/d/

    complete -%*	c/%/j/			# fill in the jobs builtin
    complete {fg,bg,stop}	c/%/j/ p/1/&quot;(%)&quot;//

    complete limit	c/-/&quot;(h)&quot;/ n/*/l/
    complete unlimit	c/-/&quot;(h)&quot;/ n/*/l/

    complete -co*	p/0/&quot;(compress)&quot;/	# make compress completion
						# not ambiguous
    if ($?traditional_complete) then
        complete zcat	n/*/f:*.Z/
    else
        # &quot;zcat&quot; may be linked to &quot;compress&quot; or &quot;gzip&quot;
        if (-X zcat) then
            zcat --version &gt;&amp; /dev/null
            if ($status != 0) then
                complete zcat	n/*/f:*.Z/
            else
                complete zcat	c/--/&quot;(force help license quiet version)&quot;/ \
				c/-/&quot;(f h L q V -)&quot;/ n/*/f:*.{gz,Z,z,zip}/
	    endif
        endif
    endif

    complete finger	c/*@/\$hosts/ n/*/u/@ 
    complete ping	p/1/\$hosts/
    complete traceroute	p/1/\$hosts/

    complete {talk,ntalk,phone}	p/1/'`users | tr &quot; &quot; &quot;\012&quot; | uniq`'/ \
		n/*/\`who\ \|\ grep\ \$:1\ \|\ awk\ \'\{\ print\ \$2\ \}\'\`/

    complete ftp	c/-/&quot;(d i g n v)&quot;/ n/-/\$hosts/ p/1/\$hosts/ n/*/n/

    # this one is simple...
    #complete rcp c/*:/f/ C@[./\$~]*@f@ n/*/\$hosts/:
    # From Michael Schroeder &lt;<a href="mailto:mlschroe@immd4.informatik.uni-erlangen.de">mlschroe@immd4.informatik.uni-erlangen.de</a>&gt; 
    # This one will rsh to the file to fetch the list of files!
    complete rcp 'c%*@*:%`set q=$:-0;set q=&quot;$q:s/@/ /&quot;;set q=&quot;$q:s/:/ /&quot;;set q=($q &quot; &quot;);rsh $q[2] -l $q[1] ls -dp $q[3]\*`%' 'c%*:%`set q=$:-0;set q=&quot;$q:s/:/ /&quot;;set q=($q &quot; &quot;);rsh $q[1] ls -dp $q[2]\*`%' 'c%*@%$hosts%:' 'C@[./$~]*@f@'  'n/*/$hosts/:'

    complete dd c/--/&quot;(help version)&quot;/ c/[io]f=/f/ \
		c/conv=*,/&quot;(ascii ebcdic ibm block unblock \
			    lcase notrunc ucase swab noerror sync)&quot;/,\
		c/conv=/&quot;(ascii ebcdic ibm block unblock \
			  lcase notrunc ucase swab noerror sync)&quot;/,\
	        c/*=/x:'&lt;number&gt;'/ \
		n/*/&quot;(if of conv ibs obs bs cbs files skip file seek count)&quot;/=

    complete nslookup   p/1/x:'&lt;host&gt;'/ p/2/\$hosts/

    complete ar c/[dmpqrtx]/&quot;(c l o u v a b i)&quot;/ p/1/&quot;(d m p q r t x)&quot;// \
		p/2/f:*.a/ p/*/f:*.o/

    # these should be merged with the MH completion hacks below - jgotts
    complete {refile,sprev,snext,scan,pick,rmm,inc,folder,show} \
		&quot;c@+@F:$HOME/Mail/@&quot;

    # these and interrupt handling from Jaap Vermeulen &lt;<a href="mailto:jaap@sequent.com">jaap@sequent.com</a>&gt;
    complete {rexec,rxexec,rxterm,rmterm} \
			'p/1/$hosts/' 'c/-/(l L E)/' 'n/-l/u/' 'n/-L/f/' \
			'n/-E/e/' 'n/*/c/'
    complete kill	'c/-/S/' 'c/%/j/' \
			'n/*/`ps -u $LOGNAME | awk '&quot;'&quot;'{print $1}'&quot;'&quot;'`/'

    # these from Marc Horowitz &lt;<a href="mailto:marc@cam.ov.com">marc@cam.ov.com</a>&gt;
    complete attach 'n/-mountpoint/d/' 'n/-m/d/' 'n/-type/(afs nfs rvd ufs)/' \
		    'n/-t/(afs nfs rvd ufs)/' 'n/-user/u/' 'n/-U/u/' \
		    'c/-/(verbose quiet force printpath lookup debug map \
			  nomap remap zephyr nozephyr readonly write \
			  mountpoint noexplicit explicit type mountoptions \
			  nosetuid setuid override skipfsck lock user host)/' \
		    'n/-e/f/' 'n/*/()/'
    complete hesinfo	'p/1/u/' \
			'p/2/(passwd group uid grplist pcap pobox cluster \
			      filsys sloc service)/'

    # these from E. Jay Berkenbilt &lt;<a href="mailto:ejb@ERA.COM">ejb@ERA.COM</a>&gt;
    # = isn't always followed by a filename or a path anymore - jgotts
    if ($?traditional_complete) then
        complete ./configure \
			 'c/--*=/f/' 'c/--{cache-file,prefix,exec-prefix,\
    				bindir,sbindir,libexecdir,datadir,\
				sysconfdir,sharedstatedir,localstatedir,\
				libdir,includedir,oldincludedir,infodir,\
				mandir,srcdir}/(=)//' \
			 'c/--/(cache-file verbose prefix exec-prefix bindir \
			 	sbindir libexecdir datadir sysconfdir \
				sharedstatedir localstatedir libdir \
				includedir oldincludedir infodir mandir \
				srcdir)//'
    else
	complete ./configure \
			'c@--{prefix,exec-prefix,bindir,sbindir,libexecdir,datadir,sysconfdir,sharedstatedir,localstatedir,infodir,mandir,srcdir,x-includes,x-libraries}=*@x:&lt;directory e.g. /usr/local&gt;'@ \
 			'c/--cachefile=*/x:&lt;filename&gt;/' \
  			'c/--{enable,disable,with}-*/x:&lt;feature&gt;//' \
 			'c/--*=/x:&lt;directory&gt;//' \
  			'c/--/(prefix= exec-prefix= bindir= \
			sbindir= libexecdir= datadir= sysconfdir= \
   			sharedstatedir= localstatedir= infodir= \
			mandir= srcdir= x-includes= x-libraries= cachefile= \
 			enable- disable- with- \
 			help no-create quiet silent version verbose )//'
    endif
    complete gs 'c/-sDEVICE=/(x11 cdjmono cdj550 epson eps9high epsonc \
			      dfaxhigh dfaxlow laserjet ljet4 sparc pbm \
			      pbmraw pgm pgmraw ppm ppmraw bit)/' \
		'c/-sOutputFile=/f/' 'c/-s/(DEVICE OutputFile)/=' \
		'c/-d/(NODISPLAY NOPLATFONTS NOPAUSE)/' 'n/*/f/'
    complete perl	'n/-S/c/'
    complete printenv	'n/*/e/'
    complete sccs	p/1/&quot;(admin cdc check clean comb deledit delget \
			delta diffs edit enter fix get help info \
			print prs prt rmdel sccsdiff tell unedit \
			unget val what)&quot;/
    complete setenv	'p/1/e/' 'c/*:/f/'

    # these and method of setting hosts from Kimmo Suominen &lt;<a href="mailto:kim@tac.nyc.ny.us">kim@tac.nyc.ny.us</a>&gt;
    if ( -f &quot;$HOME/.mh_profile&quot; &amp;&amp; -x &quot;`which folders`&quot; ) then 

    if ( ! $?FOLDERS ) setenv FOLDERS &quot;`folders -fast -recurse`&quot;
    if ( ! $?MHA )     setenv MHA     &quot;`ali | sed -e '/^ /d' -e 's/:.*//'`&quot;

    set folders = ( $FOLDERS )
    set mha = ( $MHA )

    complete ali \
        'c/-/(alias nolist list nonormalize normalize nouser user help)/' \
        'n,-alias,f,'

    complete anno \
        'c/-/(component noinplace inplace nodate date text help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete burst \
        'c/-/(noinplace inplace noquiet quiet noverbose verbose help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete comp \
        'c/-/(draftfolder draftmessage nodraftfolder editor noedit file form nouse use whatnowproc nowhatnowproc help)/' \
        'c,+,$folders,'  \
        'n,-whatnowproc,c,'  \
        'n,-file,f,'\
        'n,-form,f,'\
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete dist \
        'c/-/(noannotate annotate draftfolder draftmessage nodraftfolder editor noedit form noinplace inplace whatnowproc nowhatnowproc help)/' \
        'c,+,$folders,'  \
        'n,-whatnowproc,c,'  \
        'n,-form,f,'\
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete folder \
        'c/-/(all nofast fast noheader header nopack pack noverbose verbose norecurse recurse nototal total noprint print nolist list push pop help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete folders \
        'c/-/(all nofast fast noheader header nopack pack noverbose verbose norecurse recurse nototal total noprint print nolist list push pop help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete forw \
        'c/-/(noannotate annotate draftfolder draftmessage nodraftfolder editor noedit filter form noformat format noinplace inplace digest issue volume whatnowproc nowhatnowproc help)/' \
        'c,+,$folders,'  \
        'n,-whatnowproc,c,'  \
        'n,-filter,f,'\
        'n,-form,f,'\
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete inc \
        'c/-/(audit file noaudit nochangecur changecur file form format nosilent silent notruncate truncate width help)/' \
        'c,+,$folders,'  \
        'n,-audit,f,'\
        'n,-form,f,'

    complete mark \
        'c/-/(add delete list sequence nopublic public nozero zero help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete mhmail \
        'c/-/(body cc from subject help)/' \
        'n,-cc,$mha,'  \
        'n,-from,$mha,'  \
        'n/*/$mha/'

    complete mhpath \
        'c/-/(help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete msgchk \
        'c/-/(nodate date nonotify notify help)/' 

    complete msh \
        'c/-/(prompt noscan scan notopcur topcur help)/' 

    complete next \
        'c/-/(draft form moreproc nomoreproc length width showproc noshowproc header noheader help)/' \
        'c,+,$folders,'  \
        'n,-moreproc,c,'  \
        'n,-showproc,c,'  \
        'n,-form,f,'

    complete packf \
        'c/-/(file help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete pick \
        'c/-/(and or not lbrace rbrace cc date from search subject to othercomponent after before datefield sequence nopublic public nozero zero nolist list help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete prev \
        'c/-/(draft form moreproc nomoreproc length width showproc noshowproc header noheader help)/' \
        'c,+,$folders,'  \
        'n,-moreproc,c,'  \
        'n,-showproc,c,'  \
        'n,-form,f,'

    complete prompter \
        'c/-/(erase kill noprepend prepend norapid rapid nodoteof doteof help)/' 

    complete refile \
        'c/-/(draft nolink link nopreserve preserve src file help)/' \
        'c,+,$folders,'  \
        'n,-file,f,'\
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete rmf \
        'c/-/(nointeractive interactive help)/' \
        'c,+,$folders,'  

    complete rmm \
        'c/-/(help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete scan \
        'c/-/(noclear clear form format noheader header width noreverse reverse file help)/' \
        'c,+,$folders,'  \
        'n,-form,f,'\
        'n,-file,f,'\
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete send \
        'c/-/(alias draft draftfolder draftmessage nodraftfolder filter nofilter noformat format noforward forward nomsgid msgid nopush push noverbose verbose nowatch watch width help)/' \
        'n,-alias,f,'\
        'n,-filter,f,'

    complete show \
        'c/-/(draft form moreproc nomoreproc length width showproc noshowproc header noheader help)/' \
        'c,+,$folders,'  \
        'n,-moreproc,c,'  \
        'n,-showproc,c,'  \
        'n,-form,f,'\
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete sortm \
        'c/-/(datefield textfield notextfield limit nolimit noverbose verbose help)/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete vmh \
        'c/-/(prompt vmhproc novmhproc help)/' \
        'n,-vmhproc,c,'  

    complete whatnow \
        'c/-/(draftfolder draftmessage nodraftfolder editor noedit prompt help)/' 

    complete whom \
        'c/-/(alias nocheck check draft draftfolder draftmessage nodraftfolder help)/' \
        'n,-alias,f,'

    complete plum \
        'c/-/()/' \
        'c,+,$folders,'  \
        'n,*,`(mark | sed &quot;s/:.*//&quot;;echo next cur prev first last)|tr &quot; &quot; &quot;\12&quot; | sort -u`,'

    complete mail \
        'c/-/()/' \
        'n/*/$mha/'

    endif

    #from Dan Nicolaescu &lt;<a href="mailto:dann@ics.uci.edu">dann@ics.uci.edu</a>&gt;
    if ( $?MODULESHOME ) then
	alias Compl_module 'find ${MODULEPATH:as/:/ /} -name .version -o -name .modulea\* -prune -o -print  | sed `echo &quot;-e s@${MODULEPATH:as%:%/\*@@g -e s@%}/\*@@g&quot;`'
	complete module 'p%1%(add load unload switch display avail use unuse update purge list clear help initadd initrm initswitch initlist initclear)%' \
	'n%{unl*,sw*,inits*}%`echo &quot;$LOADEDMODULES:as/:/ /&quot;`%' \
	'n%{lo*,di*,he*,inita*,initr*}%`eval Compl_module`%' \
	'N%{sw*,initsw*}%`eval Compl_module`%' 'C%-%(-append)%' 'n%{use,unu*,av*}%d%' 'n%-append%d%' \
	'C%[^-]*%`eval Compl_module`%'
    endif

    # from George Cox
    complete acroread	'p/*/f:*.{pdf,PDF}/'
    complete apachectl  'c/*/(start stop restart fullstatus status graceful \
			configtest help)/'
    complete appletviewer	'p/*/f:*.class/'
    complete bison	'c/--/(debug defines file-prefix= fixed-output-files \
			help name-prefix= no-lines no-parser output= \
			token-table verbose version yacc)/' \
			'c/-/(b d h k l n o p t v y V)/' 'n/-b/f/' 'n/-o/f/' \
			'n/-p/f/'
    complete bzcat	c/--/&quot;(help test quiet verbose license version)&quot;/ \
			c/-/&quot;(h t L V -)&quot;/ n/*/f:*.{bz2,tbz}/
    complete bunzip2	c/--/&quot;(help keep force test stdout quiet verbose \
                        license version)&quot;/ c/-/&quot;(h k f t c q v L V -)&quot;/ \
			n/*/f:*.{bz2,tbz}/
    complete bzip2	c/--/&quot;(help decompress compress keep force test \
			stdout quiet verbose license version small)&quot;/ \
			c/-/&quot;(h d z k f t c q v L V s 1 2 3 4 5 6 7 8 9 -)&quot;/ \
			n/{-d,--decompress}/f:*.{bz2,tbz}/ \
			N/{-d,--decompress}/f:*.{bz2,tbz}/ n/*/f:^*.{bz2,tbz}/
    complete c++	'p/*/f:*.{c++,cxx,c,cc,C,cpp}/'
    complete co		'p@1@`\ls -1a RCS | sed -e &quot;s/\(.*\),v/\1/&quot;`@'
    complete crontab	'n/-u/u/'
    complete camcontrol	'p/1/(cmd debug defects devlist eject inquiry \
			modepage negotiate periphlist rescan reset start \
			stop tags tur)/'
    complete ctlinnd	'p/1/(addhist allow begin cancel changegroup \
			checkfile drop feedinfo flush flushlogs go hangup \
			logmode mode name newgroup param pause readers refile \
			reject reload renumber reserve rmgroup send shutdown \
			kill throttle trace xabort xexec)/'
    complete cvs	'c/--/(help help-commands help-synonyms)/' \
			'p/1/(add admin annotate checkout commit diff \
			edit editors export history import init log login \
			logout rdiff release remove rtag status tag unedit \
			update watch watchers)/' 'n/-a/(edit unedit commit \
			all none)/' 'n/watch/(on off add remove)/'
    complete svn 	'C@<a href="file:///">file:///</a>@`'&quot;${HOME}/etc/tcsh/complete.d/svn&quot;'`@@' \
			'n@ls@(<a href="file:///">file:///</a> svn+ssh:// svn://)@@' \
			'n@help@(add blame cat checkout \
			cleanup commit copy delete export help \
			import info list ls lock log merge mkdir \
			move propdel propedit propget proplist \
			propset resolved revert status switch unlock \
			update)@' 'p@1@(add blame cat checkout \
			cleanup commit copy delete export help \
			import info list ls lock log merge mkdir \
			move propdel propedit propget proplist \
			propset resolved revert status switch unlock \
			update)@'
    complete cxx	'p/*/f:*.{c++,cxx,c,cc,C,cpp}/'
    complete detex	'p/*/f:*.tex/'
    complete edquota    'n/*/u/'
    complete exec	'p/1/c/'
    complete ghostview	'p/*/f:*.ps/'
    complete gv		'p/*/f:*.ps/'
    complete ifconfig	'p@1@`ifconfig -l`@' 'n/*/(range phase link netmask \
			mtu vlandev vlan metric mediaopt down delete \
			broadcast arp debug)/'
    complete imake	'c/-I/d/'
    complete ipfw 	'p/1/(flush add delete list show zero)/' \
			'n/add/(allow permit accept pass deny drop reject \
			reset count skipto num divert port tee port)/'
    complete javac	'p/*/f:*.java/'
    complete ldif2ldbm	'n/-i/f:*.ldif/'
    complete libtool	'c/--mode=/(compile execute finish install link \
			uninstall)/' 'c/--/(config debug dry-run features \
			finish help quiet silent version mode=)/'
    complete libtoolize	'c/--/(automake copy debug dry-run force help ltdl \
			ltdl-tar version)/'
    complete links	'c/-/(assume-codepage async-dns download-dir \
			format-cache-size ftp-proxy help http-proxy \
			max-connections max-connections-to-host \
			memory-cache-size receive-timeout retries \
			unrestartable-receive-timeout version)/'
    complete natd	c/-/'(alias_address config deny_incoming dynamic \
			inport interface log log_denied log_facility \
			outport outport port pptpalias proxy_only \
			proxy_rule redirect_address redirect_port \
			reverse same_ports unregistered_only use_sockets \
			verbose)'/ 'n@-interface@`ifconfig -l`@'
    complete netstat	'n@-I@`ifconfig -l`@'
    complete objdump	'c/--/(adjust-vma= all-headers architecture= \
			archive-headers debugging demangle disassemble \
			disassemble-all disassemble-zeroes dynamic-reloc \
			dynamic-syms endian= file-headers full-contents \
			headers help info line-numbers no-show-raw-insn \
			prefix-addresses private-headers reloc section-headers \
			section=source stabs start-address= stop-address= \
			syms target= version wide)/' \
			'c/-/(a h i f C d D p r R t T x s S l w)/'
    complete xmodmap	'c/-/(display help grammar verbose quiet n e pm pk \
			pke pp)/'
    complete lynx	'c/-/(accept_all_cookies anonymous assume_charset= \
			assume_local_charset= assume_unrec_charset= auth= base \
			book buried_news cache= case cfg= child cookie_file= \
			cookies core crawl debug_partial display= dump editor= \
			emacskeys enable_scrollback error_file= force_html \
			force_secure forms_options from ftp get_data head help \
			hiddenlinks= historical homepage= image_links index= \
			ismap link= localhost mime_header minimal \
			newschunksize= newsmaxchunk= nobrowse nocc nocolor \
			nofilereferer nolist nolog nopause noprint noredir \
			noreferer nostatus number_links partial partial_thres \
			pauth= popup post_data preparsed print pseudo_inlines \
			raw realm reload restrictions= resubmit_posts rlogin \
			selective show_cursor soft_dquotes source stack_dump \
			startfile_ok tagsoup telnet term= tlog trace traversal \
			underscore useragent= validate verbose version vikeys \
			width=)/' 'c/(http|ftp)/$URLS/'
    complete gmake	'c/{--directory=,--include-dir=}/d/' \
			'c/{--assume-new,--assume-old,--makefile,--new-file,--what-if,--file}/f/' \
			'c/--/(assume-new= assume-old= debug directory= \
			dry-run environment-overrides file= help \
			ignore-errors include-dir= jobs[=N] just-print \
			keep-going load-average[=N] makefile= max-load[=N] \
			new-file= no-builtin-rules no-keep-going \
			no-print-directory old-file= print-data-base \
			print-directory question quiet recon silent stop \
			touch version warn-undefined-variables what-if=)/' \
			'n@*@`cat -s GNUMakefile Makefile makefile |&amp; sed -n -e &quot;/No such file/d&quot; -e &quot;s/^\([A-Za-z0-9-]*\):.*/\1/p&quot;`@' \
			'n/=/f/' 'n/-f/f/'
    complete mixer	p/1/'(vol bass treble synth pcm speaker mic cd mix \
			pcm2 rec igain ogain line1 line2 line3)'/ \
			p@2@'`mixer $:-1 | awk \{\ print\ \$7\ \}`'@

    complete mpg123	'c/--/(2to1 4to1 8bit aggressive au audiodevice \
    			auth buffer cdr check doublespeed equalizer frames \
			gain halfspeed headphones left lineout list mix mono \
			proxy quiet random rate reopen resync right scale \
			shuffle single0 single1 skip speaker stdout stereo \
			test verbose wav)/'
    complete mysqladmin	'n/*/(create drop extended-status flush-hosts \
			flush-logs flush-status flush-tables flush-privileges \
			kill password ping processlist reload refresh \
			shutdown status variables version)/'
    complete mutt	&quot;c@-f=@F:${HOME}/Mail/@&quot; \
			n/-a/f/ \
			n/-F/f/ n/-H/f/ \
			n/-s/x:'&lt;subject line&gt;'/ \
			n/-e/x:'&lt;command&gt;'/ \
			n@-b@'`cat &quot;${HOME}/.muttrc-alias&quot; | awk '&quot;'&quot;'{print $2 }'&quot;'&quot;\`@ \
			n@-c@'`cat &quot;${HOME}/.muttrc-alias&quot; | awk '&quot;'&quot;'{print $2 }'&quot;'&quot;\`@ \
			n@*@'`cat &quot;${HOME}/.muttrc-alias&quot; | awk '&quot;'&quot;'{print $2 }'&quot;'&quot;\`@
    complete ndc	'n/*/(status dumpdb reload stats trace notrace \
			querylog start stop restart )/'
    if ($?traditional_complete) then
        complete nm \
		'c/--/(debug-syms defined-only demangle dynamic \
			extern-only format= help line-numbers no-demangle \
			no-sort numeric-sort portability print-armap \
			print-file-name reverse-sort size-sort undefined-only \
			version)/' 'p/*/f:^*.{h,C,c,cc}/'
    else
	complete nm \
		'c/--radix=/x:&lt;radix: _o_ctal _d_ecimal he_x_adecimal&gt;/' \
		'c/--target=/x:&lt;bfdname&gt;/' \
		'c/--format=/(bsd sysv posix)/n/' \
		'c/--/(debugsyms extern-only demangle dynamic print-armap \
			print-file-name numeric-sort no-sort reverse-sort \
			size-sort undefined-only portability target= radix= \
			format= defined-only\ line-numbers no-demangle version \
			help)//' \
		'n/*/f:^*.{h,c,cc,s,S}/'
    endif
    complete nmap	'n@-e@`ifconfig -l`@' 'p/*/$hostnames/'
    complete perldoc 	'n@*@`\ls -1 /usr/libdata/perl/5.*/pod | sed s%\\.pod.\*\$%%`@'
    complete postfix    'n/*/(start stop reload abort flush check)/'
    complete postmap	'n/1/(hash: regexp:)' 'c/hash:/f/' 'c/regexp:/f/'
    complete rcsdiff	'p@1@`\ls -1a RCS | sed -e &quot;s/\(.*\),v/\1/&quot;`@'
    complete X		'c/-/(I a ac allowMouseOpenFail allowNonLocalModInDev \
			allowNonLocalXvidtune ar1 ar2 audit auth bestRefresh \
			bgamma bpp broadcast bs c cc class co core deferglyphs \
			disableModInDev disableVidMode displayID dpi dpms f fc \
			flipPixels fn fp gamma ggamma help indirect kb keeptty \
			ld lf logo ls nolisten string noloadxkb nolock nopn \
			once p pn port probeonly query quiet r rgamma s \
			showconfig sp su t terminate to tst v verbose version \
			weight wm x xkbdb xkbmap)/'
    complete users      'c/--/(help version)/' 'p/1/x:&quot;&lt;accounting_file&gt;&quot;/'
    complete vidcontrol	'p/1/(132x25 132x30 132x43 132x50 132x60 40x25 80x25 \
			80x30 80x43 80x50 80x60 EGA_80x25 EGA_80x43 \
			VESA_132x25 VESA_132x30 VESA_132x43 VESA_132x50 \
			VESA_132x60 VESA_800x600 VGA_320x200 VGA_40x25 \
			VGA_80x25 VGA_80x30 VGA_80x50 VGA_80x60)/'
    complete vim	'n/*/f:^*.[oa]/'
    complete where	'n/*/c/'
    complete which	'n/*/c/'
    complete wmsetbg	'c/-/(display D S a b c d e m p s t u w)/' \
			'c/--/(back-color center colors dither help match \
			maxscale parse scale smooth tile update-domain \
			update-wmaker version workspace)/'
    complete xdb	'p/1/c/'
    complete xdvi	'c/-/(allowshell debug display expert gamma hushchars \
			hushchecksums hushspecials install interpreter keep \
			margins nogrey noinstall nomakepk noscan paper safer \
			shrinkbuttonn thorough topmargin underlink version)/' \
			'n/-paper/(a4 a4r a5 a5r)/' 'p/*/f:*.dvi/'
    complete xlock	'c/-/(allowaccess allowroot debug description \
			echokeys enablesaver grabmouse grabserver hide inroot \
			install inwindow mono mousemotion nolock remote \
			resetsaver sound timeelapsed use3d usefirst verbose \
			wireframe background batchcount bg bitmap both3d \
			count cycles delay delta3d display dpmsoff \
			dpmsstandby dpmssuspend endCmd erasedelay erasemode \
			erasetime fg font foreground geometry help \
			icongeometry info invalid left3d lockdelay logoutCmd \
			mailCmd mailIcon message messagefile messagefont \
			messagesfile mode name ncolors nice nomailIcon none3d \
			parent password planfont program resources right3d \
			saturation size startCmd timeout username validate \
			version visual)/' 'n/-mode/(ant atlantis ball bat \
			blot bouboule bounce braid bubble bubble3d bug cage \
			cartoon clock coral crystal daisy dclock decay deco \
			demon dilemma discrete drift eyes fadeplot flag flame \
			flow forest galaxy gears goop grav helix hop hyper \
			ico ifs image invert julia kaleid kumppa lament laser \
			life life1d life3d lightning lisa lissie loop lyapunov \
			mandelbrot marquee matrix maze moebius morph3d \
			mountain munch nose pacman penrose petal pipes puzzle \
			pyro qix roll rotor rubik shape sierpinski slip sphere \
			spiral spline sproingies stairs star starfish strange \
			superquadrics swarm swirl tetris thornbird triangle \
			tube turtle vines voters wator wire world worm xjack \
			blank bomb random)/' 
    complete xfig	'c/-/(display)/' 'p/*/f:*.fig/'
    complete wget 	c/--/&quot;(accept= append-output= background cache= \
			continue convert-links cut-dirs= debug \
			delete-after directory-prefix= domains= \
			dont-remove-listing dot-style= exclude-directories= \
			exclude-domains= execute= follow-ftp \
			force-directories force-html glob= header= help \
			http-passwd= http-user= ignore-length \
			include-directories= input-file= level= mirror \
			no-clobber no-directories no-host-directories \
			no-host-lookup no-parent non-verbose \
			output-document= output-file= passive-ftp \
			proxy-passwd= proxy-user= proxy= quiet quota= \
			recursive reject= relative retr-symlinks save-headers \
			server-response span-hosts spider timeout= \
			timestamping tries= user-agent= verbose version wait=)&quot;/

    # these from Tom Warzeka &lt;<a href="mailto:tom@waz.cc">tom@waz.cc</a>&gt;

    # this one works but is slow and doesn't descend into subdirectories
    # complete	cd	C@[./\$~]*@d@ \
    #			p@1@'`\ls -1F . $cdpath | grep /\$ | sort -u`'@ n@*@n@

    if ( -r /etc/shells ) then
        complete setenv	p@1@e@ n@DISPLAY@\$hosts@: n@SHELL@'`cat /etc/shells`'@
    else
	complete setenv	p@1@e@ n@DISPLAY@\$hosts@:
    endif
    complete unsetenv	n/*/e/

    set _maildir = /var/mail
    if (-r &quot;$HOME/.mailrc&quot;) then
        complete mail	c/-/&quot;(e i f n s u v)&quot;/ c/*@/\$hosts/ \
			&quot;c@+@F:$HOME/Mail@&quot; C@[./\$~]@f@ n/-s/x:'&lt;subject&gt;'/ \
			n@-u@T:$_maildir@ n/-f/f/ \
			n@*@'`sed -n s/alias//p &quot;$HOME/.mailrc&quot; | \
			tr -s &quot; &quot; &quot;	&quot; | cut -f 2`'@
    else
        complete mail	c/-/&quot;(e i f n s u v)&quot;/ c/*@/\$hosts/ \
			&quot;c@+@F:$HOME/Mail@&quot; C@[./\$~]@f@ n/-s/x:'&lt;subject&gt;'/ \
			n@-u@T:$_maildir@ n/-f/f/ n/*/u/
    endif
    unset _maildir

    if (! $?MANPATH) then
	if (-r /usr/share/man) then
	    setenv MANPATH /usr/share/man:
	else
	    setenv MANPATH /usr/man:
	endif
    endif

    if ($?traditional_complete) then
        # use of $MANPATH from Dan Nicolaescu &lt;<a href="mailto:dann@ics.uci.edu">dann@ics.uci.edu</a>&gt;
        # use of 'find' adapted from Lubomir Host &lt;<a href="mailto:host8@kepler.fmph.uniba.sk">host8@kepler.fmph.uniba.sk</a>&gt;
        complete man \
	    'n@1@`set q = &quot;$MANPATH:as%:%/man1 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.1.\*\$%%`@'\
	    'n@2@`set q = &quot;$MANPATH:as%:%/man2 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.2.\*\$%%`@'\
	    'n@3@`set q = &quot;$MANPATH:as%:%/man3 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.3.\*\$%%`@'\
	    'n@4@`set q = &quot;$MANPATH:as%:%/man4 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.4.\*\$%%`@'\
	    'n@5@`set q = &quot;$MANPATH:as%:%/man5 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.5.\*\$%%`@'\
	    'n@6@`set q = &quot;$MANPATH:as%:%/man6 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.6.\*\$%%`@'\
	    'n@7@`set q = &quot;$MANPATH:as%:%/man7 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.7.\*\$%%`@'\
	    'n@8@`set q = &quot;$MANPATH:as%:%/man8 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.8.\*\$%%`@'\
	    'n@9@`set q = &quot;$MANPATH:as%:%/man9 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.9.\*\$%%`@'\
	    'n@0@`set q = &quot;$MANPATH:as%:%/man0 %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.0.\*\$%%`@'\
	    'n@n@`set q = &quot;$MANPATH:as%:%/mann %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.n.\*\$%%`@'\
	    'n@o@`set q = &quot;$MANPATH:as%:%/mano %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.o.\*\$%%`@'\
	    'n@l@`set q = &quot;$MANPATH:as%:%/manl %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.l.\*\$%%`@'\
	    'n@p@`set q = &quot;$MANPATH:as%:%/manp %&quot; ; \ls -1 $q |&amp; sed -e s%^.\*:.\*\$%% -e s%\\.p.\*\$%%`@'\
	    c@-@&quot;(- f k M P s S t)&quot;@ n@-f@c@ n@-k@x:'&lt;keyword&gt;'@ n@-[MP]@d@   \
	    'N@-[MP]@`\ls -1 $:-1/man? |&amp; sed -n s%\\..\\+\$%%p`@'            \
	    'n@-[sS]@`\ls -1 $MANPATH:as%:% % |&amp; sed -n s%^man%%p | sort -u`@'\
	    'n@*@`find $MANPATH:as%:% % \( -type f -o -type l \) -printf &quot;%f &quot; |&amp; sed -e &quot;s%find: .*: No such file or directory%%&quot; -e &quot;s%\([^\.]\+\)\.\([^ ]*\) %\1 %g&quot;`@'
	    #n@*@c@ # old way -- commands only
    else
        complete man	    n@1@'`\ls -1 /usr/man/man1 | sed s%\\.1.\*\$%%`'@ \
			    n@2@'`\ls -1 /usr/man/man2 | sed s%\\.2.\*\$%%`'@ \
			    n@3@'`\ls -1 /usr/man/man3 | sed s%\\.3.\*\$%%`'@ \
			    n@4@'`\ls -1 /usr/man/man4 | sed s%\\.4.\*\$%%`'@ \
			    n@5@'`\ls -1 /usr/man/man5 | sed s%\\.5.\*\$%%`'@ \
			    n@6@'`\ls -1 /usr/man/man6 | sed s%\\.6.\*\$%%`'@ \
			    n@7@'`\ls -1 /usr/man/man7 | sed s%\\.7.\*\$%%`'@ \
			    n@8@'`\ls -1 /usr/man/man8 | sed s%\\.8.\*\$%%`'@ \
    n@9@'`[ -r /usr/man/man9 ] &amp;&amp; \ls -1 /usr/man/man9 | sed s%\\.9.\*\$%%`'@ \
    n@0@'`[ -r /usr/man/man0 ] &amp;&amp; \ls -1 /usr/man/man0 | sed s%\\.0.\*\$%%`'@ \
  n@new@'`[ -r /usr/man/mann ] &amp;&amp; \ls -1 /usr/man/mann | sed s%\\.n.\*\$%%`'@ \
  n@old@'`[ -r /usr/man/mano ] &amp;&amp; \ls -1 /usr/man/mano | sed s%\\.o.\*\$%%`'@ \
n@local@'`[ -r /usr/man/manl ] &amp;&amp; \ls -1 /usr/man/manl | sed s%\\.l.\*\$%%`'@ \
n@public@'`[ -r /usr/man/manp ]&amp;&amp; \ls -1 /usr/man/manp | sed s%\\.p.\*\$%%`'@ \
		c/-/&quot;(- f k P s t)&quot;/ n/-f/c/ n/-k/x:'&lt;keyword&gt;'/ n/-P/d/ \
		N@-P@'`\ls -1 $:-1/man? | sed s%\\..\*\$%%`'@ n/*/c/
    endif

    complete ps	        c/-t/x:'&lt;tty&gt;'/ c/-/&quot;(a c C e g k l S t u v w x)&quot;/ \
			n/-k/x:'&lt;kernel&gt;'/ N/-k/x:'&lt;core_file&gt;'/ n/*/x:'&lt;PID&gt;'/
    complete compress	c/-/&quot;(c f v b)&quot;/ n/-b/x:'&lt;max_bits&gt;'/ n/*/f:^*.Z/
    complete uncompress	c/-/&quot;(c f v)&quot;/                        n/*/f:*.Z/

    complete uuencode	p/1/f/ p/2/x:'&lt;decode_pathname&gt;'/ n/*/n/
    complete uudecode	c/-/&quot;(f)&quot;/ n/-f/f:*.{uu,UU}/ p/1/f:*.{uu,UU}/ n/*/n/

    complete xhost	c/[+-]/\$hosts/ n/*/\$hosts/
    complete xpdf	c/-/&quot;(z g remote raise quit cmap rgb papercolor       \
			      eucjp t1lib freetype ps paperw paperh level1    \
			      upw fullscreen cmd q v h help)&quot;/                \
			n/-z/x:'&lt;zoom (-5 .. +5) or &quot;page&quot; or &quot;width&quot;&gt;'/      \
			n/-g/x:'&lt;geometry&gt;'/ n/-remote/x:'&lt;name&gt;'/            \
			n/-rgb/x:'&lt;number&gt;'/ n/-papercolor/x:'&lt;color&gt;'/       \
			n/-{t1lib,freetype}/x:'&lt;font_type&gt;'/                  \
			n/-ps/x:'&lt;PS_file&gt;'/ n/-paperw/x:'&lt;width&gt;'/           \
			n/-paperh/x:'&lt;height&gt;'/ n/-upw/x:'&lt;password&gt;'/        \
			n/-/f:*.{pdf,PDF}/                                    \
			N/-{z,g,remote,rgb,papercolor,t1lib,freetype,ps,paperw,paperh,upw}/f:*.{pdf,PDF}/ \
			N/-/x:'&lt;page&gt;'/ p/1/f:*.{pdf,PDF}/ p/2/x:'&lt;page&gt;'/

    complete tcsh	c/-D*=/'x:&lt;value&gt;'/ c/-D/'x:&lt;name&gt;'/ \
			c/-/&quot;(b c d D e f F i l m n q s t v V x X -version)&quot;/ \
			n/-c/c/ n/{-l,--version}/n/ n/*/'f:*.{,t}csh'/

    complete rpm	c/--/&quot;(query verify nodeps nofiles nomd5 noscripts    \
	                nogpg nopgp install upgrade freshen erase allmatches  \
		        notriggers repackage test rebuild recompile initdb    \
		        rebuilddb addsign resign querytags showrc setperms    \
		        setugids all file group package querybynumber qf      \
		        triggeredby whatprovides whatrequires changelog       \
		        configfiles docfiles dump filesbypkg info last list   \
		        provides queryformat requires scripts state triggers  \
		        triggerscripts allfiles badreloc excludepath checksig \
	                excludedocs force hash ignoresize ignorearch ignoreos \
		        includedocs justdb noorder oldpackage percent prefix  \
		        relocate replace-files replacepkgs buildroot clean    \
		        nobuild rmsource rmspec short-circuit sign target     \
		        help version quiet rcfile pipe dbpath root specfile)&quot;/\
		        c/-/&quot;(q V K i U F e ba bb bp bc bi bl bs ta tb tp tc  \
			ti tl ts a f g p c d l R s h ? v vv -)&quot;/              \
		n/{-f,--file}/f/ n/{-g,--group}/g/ n/--pipe/c/ n/--dbpath/d/  \
		n/--querybynumber/x:'&lt;number&gt;'/ n/--triggeredby/x:'&lt;package&gt;'/\
		n/--what{provides,requires}/x:'&lt;capability&gt;'/ n/--root/d/     \
		n/--{qf,queryformat}/x:'&lt;format&gt;'/ n/--buildroot/d/           \
		n/--excludepath/x:'&lt;oldpath&gt;'/  n/--prefix/x:'&lt;newpath&gt;'/     \
		n/--relocate/x:'&lt;oldpath=newpath&gt;'/ n/--target/x:'&lt;platform&gt;'/\
		n/--rcfile/x:'&lt;filelist&gt;'/ n/--specfile/x:'&lt;specfile&gt;'/       \
	        n/{-[iUFep],--{install,upgrade,freshen,erase,package}}/f:*.rpm/

    # these conform to the latest GNU versions available at press time ...
    # updates by John Gotts &lt;<a href="mailto:jgotts@engin.umich.edu">jgotts@engin.umich.edu</a>&gt;
    if (-X emacs) then
      # TW note:  if your version of GNU Emacs supports the &quot;--version&quot; option,
      #           uncomment this line and comment the next to automatically
      #           detect the version, else set &quot;_emacs_ver&quot; to your version.
      #set _emacs_ver=`emacs --version | sed -e 's%GNU Emacs %%' -e q | cut -d . -f1-2`
      set _emacs_ver=21.3
      set _emacs_dir=`which emacs | sed s%/bin/emacs%%` 
      complete emacs	c/--/&quot;(batch terminal display no-windows no-init-file \
                               user debug-init unibyte multibyte version help \
                               no-site-file funcall load eval insert kill)&quot;/ \
                        c/-/&quot;(t d nw q u f l -)&quot;/ c/+/x:'&lt;line_number&gt;'/ \
			n/{-t,--terminal}/x:'&lt;terminal&gt;'/ n/{-d,--display}/x:'&lt;display&gt;'/ \
	                n/{-u,--user}/u/ n/{-f,--funcall}/x:'&lt;lisp_function&gt;'/ \
			n@{-l,--load}@F:$_emacs_dir/share/emacs/$_emacs_ver/lisp@ \
			n/--eval/x:'&lt;expression&gt;'/ n/--insert/f/ n/*/f:^*[\#~]/
      unset _emacs_ver _emacs_dir
    endif

    complete gzcat	c/--/&quot;(force help license quiet version)&quot;/ \
			c/-/&quot;(f h L q V -)&quot;/ n/*/f:*.{gz,Z,z,zip}/
    complete gzip	c/--/&quot;(stdout to-stdout decompress uncompress \
			force help list license no-name quiet recurse \
			suffix test verbose version fast best)&quot;/ \
			c/-/&quot;(c d f h l L n q r S t v V 1 2 3 4 5 6 7 8 9 -)&quot;/\
			n/{-S,--suffix}/x:'&lt;file_name_suffix&gt;'/ \
			n/{-d,--{de,un}compress}/f:*.{gz,Z,z,zip,taz,tgz}/ \
			N/{-d,--{de,un}compress}/f:*.{gz,Z,z,zip,taz,tgz}/ \
			n/*/f:^*.{gz,Z,z,zip,taz,tgz}/
    complete {gunzip,ungzip} c/--/&quot;(stdout to-stdout force help list license \
			no-name quiet recurse suffix test verbose version)&quot;/ \
			c/-/&quot;(c f h l L n q r S t v V -)&quot;/ \
			n/{-S,--suffix}/x:'&lt;file_name_suffix&gt;'/ \
			n/*/f:*.{gz,Z,z,zip,taz,tgz}/
    complete zgrep	c/-*A/x:'&lt;#_lines_after&gt;'/ c/-*B/x:'&lt;#_lines_before&gt;'/\
			c/-/&quot;(A b B c C e f h i l n s v V w x)&quot;/ \
			p/1/x:'&lt;limited_regular_expression&gt;'/ N/-*e/f/ \
			n/-*e/x:'&lt;limited_regular_expression&gt;'/ n/-*f/f/ n/*/f/
    complete zegrep	c/-*A/x:'&lt;#_lines_after&gt;'/ c/-*B/x:'&lt;#_lines_before&gt;'/\
			c/-/&quot;(A b B c C e f h i l n s v V w x)&quot;/ \
			p/1/x:'&lt;full_regular_expression&gt;'/ N/-*e/f/ \
			n/-*e/x:'&lt;full_regular_expression&gt;'/ n/-*f/f/ n/*/f/
    complete zfgrep	c/-*A/x:'&lt;#_lines_after&gt;'/ c/-*B/x:'&lt;#_lines_before&gt;'/\
			c/-/&quot;(A b B c C e f h i l n s v V w x)&quot;/ \
			p/1/x:'&lt;fixed_string&gt;'/ N/-*e/f/ \
			n/-*e/x:'&lt;fixed_string&gt;'/ n/-*f/f/ n/*/f/
    complete znew	c/-/&quot;(f t v 9 P K)&quot;/ n/*/f:*.Z/
    complete zmore	n/*/f:*.{gz,Z,z,zip}/
    complete zfile	n/*/f:*.{gz,Z,z,zip,taz,tgz}/
    complete ztouch	n/*/f:*.{gz,Z,z,zip,taz,tgz}/
    complete zforce	n/*/f:^*.{gz,tgz}/

    complete dcop 'p/1/`$:0`/ /' \
	'p/2/`$:0 $:1 | awk \{print\ \$1\}`/ /' \
	'p/3/`$:0 $:1 $:2 | sed &quot;s%.* \(.*\)(.*%\1%&quot;`/ /'


    complete grep	c/-*A/x:'&lt;#_lines_after&gt;'/ c/-*B/x:'&lt;#_lines_before&gt;'/\
			c/--/&quot;(extended-regexp fixed-regexp basic-regexp \
			regexp file ignore-case word-regexp line-regexp \
			no-messages revert-match version help byte-offset \
			line-number with-filename no-filename quiet silent \
			text directories recursive files-without-match \
			files-with-matches count before-context after-context \
			context binary unix-byte-offsets)&quot;/ \
			c/-/&quot;(A a B b C c d E e F f G H h i L l n q r s U u V \
				v w x)&quot;/ \
			p/1/x:'&lt;limited_regular_expression&gt;'/ N/-*e/f/ \
			n/-*e/x:'&lt;limited_regular_expression&gt;'/ n/-*f/f/ n/*/f/
    complete egrep	c/-*A/x:'&lt;#_lines_after&gt;'/ c/-*B/x:'&lt;#_lines_before&gt;'/\
			c/--/&quot;(extended-regexp fixed-regexp basic-regexp \
			regexp file ignore-case word-regexp line-regexp \
			no-messages revert-match version help byte-offset \
			line-number with-filename no-filename quiet silent \
			text directories recursive files-without-match \
			files-with-matches count before-context after-context \
			context binary unix-byte-offsets)&quot;/ \
			c/-/&quot;(A a B b C c d E e F f G H h i L l n q r s U u V \
				v w x)&quot;/ \
			p/1/x:'&lt;full_regular_expression&gt;'/ N/-*e/f/ \
			n/-*e/x:'&lt;full_regular_expression&gt;'/ n/-*f/f/ n/*/f/
    complete fgrep	c/-*A/x:'&lt;#_lines_after&gt;'/ c/-*B/x:'&lt;#_lines_before&gt;'/\
			c/--/&quot;(extended-regexp fixed-regexp basic-regexp \
			regexp file ignore-case word-regexp line-regexp \
			no-messages revert-match version help byte-offset \
			line-number with-filename no-filename quiet silent \
			text directories recursive files-without-match \
			files-with-matches count before-context after-context \
			context binary unix-byte-offsets)&quot;/ \
			c/-/&quot;(A a B b C c d E e F f G H h i L l n q r s U u V \
				v w x)&quot;/ \
			p/1/x:'&lt;fixed_string&gt;'/ N/-*e/f/ \
			n/-*e/x:'&lt;fixed_string&gt;'/ n/-*f/f/ n/*/f/

    complete sed	c/--/&quot;(quiet silent version help expression file)&quot;/   \
			c/-/&quot;(n V e f -)&quot;/ n/{-e,--expression}/x:'&lt;script&gt;'/  \
			n/{-f,--file}/f:*.sed/ N/-{e,f,-{file,expression}}/f/ \
			n/-/x:'&lt;script&gt;'/ N/-/f/ p/1/x:'&lt;script&gt;'/ p/2/f/

    complete users	c/--/&quot;(help version)&quot;/ p/1/x:'&lt;accounting_file&gt;'/
    complete who	c/--/&quot;(heading idle count mesg message writable help \
    			version)&quot;/ c/-/&quot;(H i m q s T w u -)&quot;/ \
			p/1/x:'&lt;accounting_file&gt;'/ n/am/&quot;(i)&quot;/ n/are/&quot;(you)&quot;/

    complete chown	c/--/&quot;(changes dereference no-dereference silent \
    			quiet reference recursive verbose help version)&quot;/ \
			c/-/&quot;(c f h R v -)&quot;/ C@[./\$~]@f@ c/*[.:]/g/ \
			n/-/u/: p/1/u/: n/*/f/
    complete chgrp	c/--/&quot;(changes no-dereference silent quiet reference \
    			recursive verbose help version)&quot;/ \
			c/-/&quot;(c f h R v -)&quot;/ n/-/g/ p/1/g/ n/*/f/
    complete chmod	c/--/&quot;(changes silent quiet verbose reference \
    			recursive help version)&quot;/ c/-/&quot;(c f R v)&quot;/
    complete df		c/--/&quot;(all block-size human-readable si inodes \
			kilobytes local megabytes no-sync portability sync \
			type print-type exclude-type help version)&quot;/ \
			c/-/&quot;(a H h i k l m P T t v x)&quot;/
    complete du		c/--/&quot;(all block-size bytes total dereference-args \
    			human-readable si kilobytes count-links dereference \
			megabytes separate-dirs summarize one-file-system \
			exclude-from exclude max-depth help version&quot;/ \
			c/-/&quot;(a b c D H h k L l m S s X x)&quot;/

    complete cat	c/--/&quot;(number-nonblank number squeeze-blank show-all \
			show-nonprinting show-ends show-tabs help version)&quot;/ \
			c/-/&quot;(A b E e n s T t u v -)&quot;/ n/*/f/
    complete mv		c/--/&quot;(backup force interactive update verbose suffix \
			version-control help version)&quot;/ \
			c/-/&quot;(b f i S u V v -)&quot;/ \
			n/{-S,--suffix}/x:'&lt;suffix&gt;'/ \
			n/{-V,--version-control}/&quot;(t numbered nil existing \
			never simple)&quot;/ n/-/f/ N/-/d/ p/1/f/ p/2/d/ n/*/f/
    complete cp		c/--/&quot;(archive backup no-dereference force \
    			interactive link preserve parents sparse recursive \
			symbolic-link suffix update verbose version-control \
			one-file-system help version)&quot;/ \
			c/-/&quot;(a b d f i l P p R r S s u V v x -)&quot;/ \
			n/-*r/d/ n/{-S,--suffix}/x:'&lt;suffix&gt;'/ \
			n/{-V,--version-control}/&quot;(t numbered nil existing \
			never simple)&quot;/ n/-/f/ N/-/d/ p/1/f/ p/2/d/ n/*/f/
    complete ln		c/--/&quot;(backup directory force no-dereference \
    			interactive symbolic suffix verbose version-control \
			help version)&quot;/ \
			c/-/&quot;(b d F f i n S s V v -)&quot;/ \
			n/{-S,--suffix}/x:'&lt;suffix&gt;'/ \
			n/{-V,--version-control}/&quot;(t numbered nil existing \
			never simple)&quot;/ n/-/f/ N/-/x:'&lt;link_name&gt;'/ \
			p/1/f/ p/2/x:'&lt;link_name&gt;'/
    complete touch	c/--/&quot;(date reference time help version)&quot;/ \
			c/-/&quot;(a c d f m r t -)&quot;/ \
			n/{-d,--date}/x:'&lt;date_string&gt;'/ \
			c/--time/&quot;(access atime mtime modify use)&quot;/ \
			n/{-r,--file}/f/ n/-t/x:'&lt;time_stamp&gt;'/ n/*/f/
    complete mkdir	c/--/&quot;(mode parents verbose help version)&quot;/ \
    			c/-/&quot;(p m -)&quot;/ \
			n/{-m,--mode}/x:'&lt;mode&gt;'/ n/*/d/
    complete rmdir	c/--/&quot;(ignore-fail-on-non-empty parents verbose help \
    			version)&quot;/ c/-/&quot;(p -)&quot;/ n/*/d/
    complete env 	'c/*=/f/' 'p/1/e/=/' 'p/2/c/'

    complete tar	c/-[Acru]*/&quot;(b B C f F g G h i l L M N o P \
			R S T v V w W X z Z)&quot;/ \
			c/-[dtx]*/&quot;( B C f F g G i k K m M O p P \
			R s S T v w x X z Z)&quot;/ \
			p/1/&quot;(A c d r t u x -A -c -d -r -t -u -x \
			--catenate --concatenate --create --diff --compare \
			--delete --append --list --update --extract --get \
			--help --version)&quot;/ \
			c/--/&quot;(catenate concatenate create diff compare \
			delete append list update extract get atime-preserve \
			block-size read-full-blocks directory checkpoint file \
			force-local info-script new-volume-script incremental \
			listed-incremental dereference ignore-zeros \
			ignore-failed-read keep-old-files starting-file \
			one-file-system tape-length modification-time \
			multi-volume after-date newer old-archive portability \
			to-stdout same-permissions preserve-permissions \
			absolute-paths preserve record-number remove-files \
			same-order preserve-order same-owner sparse \
			files-from null totals verbose label version \
			interactive confirmation verify exclude exclude-from \
			compress uncompress gzip ungzip use-compress-program \
			block-compress help version)&quot;/ \
			c/-/&quot;(b B C f F g G h i k K l L m M N o O p P R s S \
			T v V w W X z Z 0 1 2 3 4 5 6 7 -)&quot;/ \
			C@/dev@f@ \
			n/-c*f/x:'&lt;new_tar_file, device_file, or &quot;-&quot;&gt;'/ \
			n/{-[Adrtux]j*f,--file}/f:*.{tar.bz2,tbz}/ \
			n/{-[Adrtux]z*f,--file}/f:*.{tar.gz,tgz}/ \
			n/{-[Adrtux]Z*f,--file}/f:*.{tar.Z,taz}/ \
			n/{-[Adrtux]*f,--file}/f:*.tar/ \
			N/{-xj*f,--file}/'`tar -tjf $:-1`'/ \
			N/{-xz*f,--file}/'`tar -tzf $:-1`'/ \
			N/{-xZ*f,--file}/'`tar -tZf $:-1`'/ \
			N/{-x*f,--file}/'`tar -tf $:-1`'/ \
			n/--use-compress-program/c/ \
			n/{-b,--block-size}/x:'&lt;block_size&gt;'/ \
			n/{-V,--label}/x:'&lt;volume_label&gt;'/ \
			n/{-N,--{after-date,newer}}/x:'&lt;date&gt;'/ \
			n/{-L,--tape-length}/x:'&lt;tape_length_in_kB&gt;'/ \
			n/{-C,--directory}/d/ \
			N/{-C,--directory}/'`\ls $:-1`'/ \
			n/-[0-7]/&quot;(l m h)&quot;/

    switch ( &quot;$OSTYPE&quot; )
    case &quot;linux&quot;:
      # Linux filesystems
      complete  mount	c/-/&quot;(a f F h l n o r s t U v V w)&quot;/ n/-[hV]/n/ \
			n/-o/x:'&lt;options&gt;'/ n/-t/x:'&lt;vfstype&gt;'/ \
			n/-L/x:'&lt;label&gt;'/ n/-U/x:'&lt;uuid&gt;'/ \
			n@*@'`grep -v &quot;^#&quot; /etc/fstab | tr -s &quot; &quot; &quot;	 &quot; | cut -f 2`'@
      complete umount	c/-/&quot;(a h n r t v V)&quot;/ n/-t/x:'&lt;vfstype&gt;'/ \
			  n/*/'`mount | cut -d &quot; &quot; -f 3`'/
      breaksw
    case &quot;sunos*&quot;:
    case &quot;solaris&quot;:
      # Solaris filesystems
      complete  mount	c/-/&quot;(a F m o O p r v V)&quot;/ n/-p/n/ n/-v/n/ \
      			n/-o/x:'&lt;FSType_options&gt;'/ \
      			n@-F@'`\ls -1 /usr/lib/fs`'@ \
      			n@*@'`grep -v &quot;^#&quot; /etc/vfstab | tr -s &quot; &quot; &quot;	 &quot; | cut -f 3`'@
      complete umount	c/-/&quot;(a o V)&quot;/ n/-o/x:'&lt;FSType_options&gt;'/ \
      			n/*/'`mount | cut -d &quot; &quot; -f 1`'/
      complete  mountall	c/-/&quot;(F l r)&quot;/ n@-F@'`\ls -1 /usr/lib/fs`'@
      complete umountall	c/-/&quot;(F h k l r s)&quot;/ n@-F@'`\ls -1 /usr/lib/fs`'@ \
      			n/-h/'`df -k | cut -s -d &quot;:&quot; -f 1 | sort -u`'/
      breaksw
    case &quot;cygwin&quot;:
      # Cygwin mounts
      complete  mount	c/-/&quot;(b c f h m o p s t u v x E X)&quot;/ n/-[hmpv]/n/ \
      			n/-c/x:'/'/ \
			n/-o/&quot;(user system binary text exec notexec cygexec nosuid managed)&quot;/ \
      			n@*@'`mount -p | tail -1 | cut -d &quot; &quot; -f 1 | xargs ls -1 | awk '&quot;'&quot;'{print $1&quot;:/&quot;; } END{print &quot;//&quot;;}'&quot;'&quot;'`'@
      complete umount	c/-/&quot;(A c h s S u U v)&quot;/ n/-[AhSUv]/n/ \
      			n@*@'`mount | grep -v noumount | cut -d &quot; &quot; -f 3`'@
      breaksw
    default:
      breaksw
    endsw

    # these deal with NIS (formerly YP); if it's not running you don't need 'em
    if (-X domainname) then
      set _domain = &quot;`domainname`&quot;
      set _ypdir  = /var/yp	# directory where NIS (YP) maps are kept
      if (&quot;$_domain&quot; != &quot;&quot; &amp;&amp; &quot;$_domain&quot; != &quot;noname&quot;) then
        complete domainname p@1@D:$_ypdir@&quot; &quot; n@*@n@
        complete ypcat	    c@-@&quot;(d k t x)&quot;@ n@-x@n@ n@-d@D:$_ypdir@&quot; &quot; \
	                    N@-d@\`\\ls\ -1\ $_ypdir/\$:-1\ \|\ sed\ -n\ s%\\\\.pag\\\$%%p\`@ \
	                    n@*@\`\\ls\ -1\ $_ypdir/$_domain\ \|\ sed\ -n\ s%\\\\.pag\\\$%%p\`@
        complete ypmatch    c@-@&quot;(d k t x)&quot;@ n@-x@n@ n@-d@D:$_ypdir@&quot; &quot; \
	                    N@-d@x:'&lt;key ...&gt;'@ n@-@x:'&lt;key ...&gt;'@ p@1@x:'&lt;key ...&gt;'@ \
	                    n@*@\`\\ls\ -1\ $_ypdir/$_domain\ \|\ sed\ -n\ s%\\\\.pag\\\$%%p\`@
        complete ypwhich    c@-@&quot;(d m t x V1 V2)&quot;@ n@-x@n@ n@-d@D:$_ypdir@&quot; &quot; \
	                    n@-m@\`\\ls\ -1\ $_ypdir/$_domain\ \|\ sed\ -n\ s%\\\\.pag\\\$%%p\`@ \
			    N@-m@n@ n@*@\$hosts@
      endif
      unset _domain _ypdir
    endif

    complete make \
	'n/-f/f/' \
      	'c/*=/f/' \
	'n@*@`cat -s GNUmakefile Makefile makefile |&amp; sed -n -e &quot;/No such file/d&quot; -e &quot;/^[^     #].*:/s/:.*//p&quot;`@'

    if ( -f /etc/printcap ) then
	set printers=(`sed -n -e &quot;/^[^     #].*:/s/:.*//p&quot; /etc/printcap`)

	complete lpr    'c/-P/$printers/'
	complete lpq    'c/-P/$printers/'
	complete lprm   'c/-P/$printers/'
	complete lpquota        'p/1/(-Qprlogger)/' 'c/-P/$printers/'
	complete dvips  'c/-P/$printers/' 'n/-o/f:*.{ps,PS}/' 'n/*/f:*.dvi/'
	complete dvilj	'p/*/f:*.dvi/'
    endif

    # From Alphonse Bendt
    complete ant \
	 'n/-f/f:*.xml/' \
	      'n@*@`cat build.xml | sed -n -e &quot;s/[ \t]*&lt;target[\t\n]*name=.\([a-zA-Z0-9_:]*\).*/\1/p&quot;`@'

    if ($?P4CLIENT &amp;&amp; -X perl) then
	# This is from Greg Allen.
	set p4cmds=(add branch branches commands change changes client clients \
	    counter counters delete depot depots describe diff diff2 \
	    edit filelog files fix fixes fstat group groups have help \
	    info integrate integrated job jobs jobspec label labels \
	    labelsync lock obliterate opened passwd print protect rename \
	    reopen resolve resolved revert review reviews set submit \
	    sync triggers unlock user users verify where)
	complete p4 'p/1/$p4cmds/' 'n/help/$p4cmds/' \
	    'n%{-l,label}%`p4 labels | sed &quot;s/Label \([^ ]*\) .*/\1/&quot;`%' \
	    'n%-t%`p4 $:1s | sed &quot;s/[^ ]* \([^ ]*\) .*/\1/&quot;`%' \
	    'c%*@%`p4 labels | sed &quot;s/Label \([^ ]*\) .*/\1/&quot;`%' \
	    'c@//*/*@`p4 files $:-0... |&amp; perl -nle &quot;m%\Q$:-0\E([^#][^/# ] \
	    *)%;print &quot;\$&quot;1 if \\\!/no such/&amp;&amp;\!&quot;\$&quot;h{&quot;\$&quot;1}++&quot;`@@' \
	    'c@//@`p4 depots | sed &quot;s/Depot \([^ ]*\) .*/\1/&quot;`@/@'
    endif


    if (! $?traditional_complete) then
        uncomplete vi
        uncomplete vim
        complete {vi,vim,gvim,nvi,elvis} 	n/*/f:^*.{o,a,so,sa,aux,dvi,log,fig,bbl,blg,bst,idx,ilg,ind,toc}/
        complete {ispell,spell,spellword}	'n@-d@`ls /usr/lib/ispell/*.aff | sed -e &quot;s/\.aff//&quot; `@' 'n/*/f:^*.{o,a,so,sa,aux,dvi,log,fig,bbl,blg,bst,idx,ilg,ind,toc}/'
        complete elm	'n/-[Ai]/f/' 'c@=@F:$HOME/Mail/@' 'n/-s/x:\&lt;subject\&gt;/'
        complete ncftp	'n@*@`sed -e '1,2d' $HOME/.ncftp/bookmarks | cut -f 1,2 -d &quot;,&quot; | tr &quot;,&quot; &quot;\012&quot; | sort | uniq ` '@
        complete bibtex	'n@*@`ls *.aux | sed -e &quot;s/\.aux//&quot;`'@
        complete dvi2tty	n/*/f:*.dvi/	# Only files that match *.dvi
	uncomplete gv
	uncomplete ghostview
        complete {gv,ghostview}	'n/*/f:*.{ps,eps,epsi}/'
        complete enscript \
		'c/--/(columns= pages= header= no-header truncate-lines \
			line-numbers setpagedevice= escapes font= \
			header-font= fancy-header no-job-header \
			highlight-bars indent= filter= borders page-prefeed \
			no-page-prefeed lineprinter lines-per-page= mail \
			media= copies= newline= output= missing-characters \
			printer= quiet silent landscape portrait \
			baselineskip= statusdict= title= tabsize= underlay= \
			verbose version encoding pass-through download-font= \
			filter-stdin= help highlight-bar-gray= list-media \
			list-options non-printable-format= page-label-format= \
			printer-options= ul-angle= ul-font= ul-gray= \
			ul-position= ul-style= \
		     )/'
    endif

    complete dpkg \
		'c/--{admindir,instdir,root}=/d/' \
		'c/--debug=/n/' \
		'c/--{admindir,debug,instdir,root}/(=)//' \
		'c/--/(admindir= debug= instdir= root= \
			assert-support-predepends assert-working-epoch \
			audit auto-deconfigure clear-avail \
			compare-versions configure contents control \
			extract force-bad-path field \
			force-configure-any force-conflicts \
			force-depends force-depends-version force-help \
			force-hold force-non-root \
			force-overwrite-diverted \
			force-remove-essential force-remove-reinstreq \
			forget-old-unavail fsys-tarfile get-selections \
			help ignore-depends info install largemem \
			license list listfiles merge-avail no-act \
			pending predep-package print-architecture \
			print-gnu-build-architecture \
			print-installation-architecture print-avail \
			purge record-avail recursive refuse-downgrade \
			remove search set-selections selected-only \
			skip-same-version smallmem status unpack \
			update-avail version vextract \
		      )//' \
		'n/{-l}/`dpkg -l|awk \{print\ \$2\}`/' \
		'n/*/f:*.deb'/
    complete dpkg-deb 	   'c/--{build}=/d/' \
			   'c/--/(build contents info field control extract \
				 vextract fsys-tarfile help version \
				 license)//' \
			   'n/*/f:*.deb/'
    complete apt-get \
	        'c/--/(build config-file diff-only download-only \
		   fix-broken fix-missing force-yes help ignore-hold no-download \
		   no-upgrade option print-uris purge reinstall quiet simulate \
		   show-upgraded target-release tar-only version yes )/' \
	    	'c/-/(b c= d f h m o= q qq s t x y )/' \
 		'n/{source,build-dep}/x:&lt;pkgname&gt;/' \
 		'n/{remove}/`dpkg -l|grep ^ii|awk \{print\ \$2\}`/' \
 		'n/{install}/`apt-cache pkgnames | sort`/' \
 		'C/*/(update upgrade dselect-upgrade source \
		   build-dep check clean autoclean install remove)/'
    complete apt-cache \
 		'c/--/(all-versions config-file generate full help important \
 		names-only option pkg-cache quiet recurse src-cache version )/' \
 	    	'c/-/(c= h i o= p= q s= v)/' \
  		'n/{search}/x:&lt;regex&gt;/' \
 		'n/{pkgnames,policy,show,showpkg,depends,dotty}/`apt-cache pkgnames | sort`/' \
 		'C/*/(add gencaches showpkg stats dump dumpavail unmet show \
 		search depends pkgnames dotty policy )/'

    unset noglob
    unset _complete
    unset traditional_complete
endif

end:
	onintr
</pre>
<hr />
</body></html>