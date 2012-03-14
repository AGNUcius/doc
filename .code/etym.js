<html>
<head>
<style>
.quotedString
{
    color: #0000FF;
}
.comment
{
    color: #999999;
}
.operator
{
    color: #00CCCC;
}
.builtinVariable
{
    color: #CCCC00;
}
.variableSpecifier
{
    color: #FF0000;
}
.keyword
{
    color: #9900FF;
}
.builtinFunction
{
    color: #FF00FF;
}
.identifier
{
    color: #009900;
}
.number
{
    color: #9999FF;
}
</style>
<script>
var ie = document.all != null;
var moz = !ie && document.getElementById != null && document.layers ==
+ null;
function emulateHTMLModel()
{
    // copied from http://www.webfx.nu/dhtml/ieemu/htmlmodel.html

    // This function is used to generate a html string for the text pr
+operties/methods
    // It replaces '\n' with "<BR"> as well as fixes consecutive white
+ spaces
    // It also repalaces some special characters    
    function convertTextToHTML(s) {
        s = s.replace(/\&/g, "&amp;").replace(/</g, "&lt;").replace(/>
+/g, "&gt;").replace(/\n/g, "<BR>").replace(/\t/g, "    "); //tachyon
        while (/\s\s/.test(s))
            s = s.replace(/\s\s/, "&nbsp; ");
        return s.replace(/\s/g, " ");
    }


    HTMLElement.prototype.__defineSetter__("innerText", function (sTex
+t) {
        this.innerHTML = convertTextToHTML(sText);
        return sText;        
    });

    var tmpGet;
    HTMLElement.prototype.__defineGetter__("innerText", tmpGet = funct
+ion () {
        var r = this.ownerDocument.createRange();
        r.selectNodeContents(this);
        return r.toString();
    });

}

if (moz) 
    emulateHTMLModel();


// Regular Expressions largely copied from Cory Johns (darkness@yossma
+n.net) excellent Syntax::Highlight::Perl module (see http://search.cp
+an.org/~johnsca/)

var re;
var RE  = new Array;

// quoted string
re  = /('|"|`).*?\1/;
RE[0]  = new RegExp(re);

// comment
re  = /\#.*?[\r\n]+/; //tachyon
RE[1]  = new RegExp(re);
 
// operator
re = /xor|\.\.\.|and|not|\|\|\=|cmp|\>\>\=|\<\<\=|\<\=\>|\&\&\=|or|\=\
+>|\!\~|\^\=|\&\=|\|\=|\.\=|x\=|\%\=|\/\=|\*\=|\-\=|\+\=|\=\~|\*\*|\-\
+-|\.\.|\|\||\&\&|\+\+|\-\>|ne|eq|\!\=|\=\=|ge|le|gt|lt|\>\=|\<\=|\>\>
+|\<\<|\,|\=|\:|\?|\^|\||x|\%|\/|\*|\<|\&|\\|\~|\!|\>|\.|\-|\+ /;
RE[2]  = new RegExp(re);

// builtin variables
re = /\$\#?_|\$(?:\^[LAECDFHIMOPRSTWX]|[0-9&`'+*.\/|,\\";#%=\-~^:?!@\$
+<>()\[\]])|\$\#?ARGV(?:\s*\[)?|\$\#?INC\s*\[|\$(?:ENV|SIG|INC)\s*\{|\
+@(?:_|ARGV|INC)|\%(?:INC|ENV|SIG)/;
RE[3] = new RegExp(re);

// variable class specifiers
re = /(?:(?:[\@\%\*]|\$\#?)\$*)/;
RE[4] = new RegExp(re);

// keyword
re  = /(continue|foreach|require|package|scalar|format|unless|local|un
+til|while|elsif|next|last|goto|else|redo|sub|for|use|no|if|my)\b/;
RE[5]  = new RegExp(re);

// builtin function
re  = /(getprotobynumber|getprotobyname|getservbyname|gethostbyaddr|ge
+thostbyname|getservbyport|getnetbyaddr|getnetbyname|getsockname|getpe
+ername|setpriority|getprotoent|setprotoent|getpriority|endprotoent|ge
+tservent|setservent|endservent|sethostent|socketpair|getsockopt|getho
+stent|endhostent|setsockopt|setnetent|quotemeta|localtime|prototype|g
+etnetent|endnetent|rewinddir|wantarray|getpwuid|closedir|getlogin|rea
+dlink|endgrent|getgrgid|getgrnam|shmwrite|shutdown|readline|endpwent|
+setgrent|readpipe|formline|truncate|dbmclose|syswrite|setpwent|getpwn
+am|getgrent|getpwent|ucfirst|sysread|setpgrp|shmread|sysseek|sysopen|
+telldir|defined|opendir|connect|lcfirst|getppid|binmode|syscall|sprin
+tf|getpgrp|readdir|seekdir|waitpid|reverse|unshift|symlink|dbmopen|se
+mget|msgrcv|rename|listen|chroot|msgsnd|shmctl|accept|unpack|exists|f
+ileno|shmget|system|unlink|printf|gmtime|msgctl|semctl|values|rindex|
+substr|splice|length|msgget|select|socket|return|caller|delete|alarm|
+ioctl|index|undef|lstat|times|srand|chown|fcntl|close|write|umask|rmd
+ir|study|sleep|chomp|untie|print|utime|mkdir|atan2|split|crypt|flock|
+chmod|BEGIN|bless|chdir|semop|shift|reset|link|stat|chop|grep|fork|du
+mp|join|open|tell|pipe|exit|glob|warn|each|bind|sort|pack|eval|push|k
+eys|getc|kill|seek|sqrt|send|wait|rand|tied|read|time|exec|recv|eof|c
+hr|int|ord|exp|pos|pop|sin|log|abs|oct|hex|tie|cos|vec|END|ref|map|di
+e|\-C|\-b|\-S|\-u|\-t|\-p|\-l|\-d|\-f|\-g|\-s|\-z|uc|\-k|\-e|\-O|\-T|
+\-B|\-M|do|\-A|\-X|\-W|\-c|\-R|\-o|\-x|lc|\-w|\-r)\b/;
RE[6]  = new RegExp(re);

// identifier (variable, subroutine, packages)
re = /(?:(?:[A-Za-z_]|::)(?:\w|::)*)/;
RE[7] = new RegExp(re);

// number
re = /0x[\da-fA-F]+|[_.\d]+([eE][-+]?\d+)?/;
RE[8] = new RegExp(re);


var classes  = new Array("quotedString", "comment", "operator", "built
+inVariable", "variableSpecifier", "keyword", "builtinFunction", "iden
+tifier", "number");


/* This is the actual highlighting function.
 * Takes an html object as argument
 * returns nothing
 * replaces the text inside the html object with colored text using <s
+pan>'s
 * css is defined separately. See the array classes to find out the cs
+s class names.
 */
function HighlightCode(object)
{
    codeText = object.innerText; //HTML.replace(/<.*?>/g, "");
    object.innerHTML = '';
    var left;
    var match;
     var right;
    while (codeText.length > 0)
    {
        var mode = -1 ;
        var index = 999999999;
        for (var i = 0; i < RE.length; i++)
        {
            if ((codeText.match(RE[i])) && (RegExp.leftContext.length 
+< index))
            {
                left  = RegExp.leftContext;
                match = RegExp.lastMatch;
                right = RegExp.rightContext;
                index = RegExp.leftContext.length;
                 mode  = i;
            }
        }
        if (mode == -1)
        {
            object.appendChild(document.createTextNode(codeText)); //.
+replace(/\r\n/g, "\r")));
            codeText = '';
        }
        else
        {
            // append the plain text to the <code> block
            object.appendChild(document.createTextNode(left)); //.repl
+ace(/\r\n/g, "\r")));

            // create a new <span> with the current code
            var span = document.createElement("span");
            span.setAttribute("className", classes[mode]); // ie
            span.setAttribute("class", classes[mode]); //mozilla
            span.appendChild(document.createTextNode(match));
            object.appendChild(span);    

            codeText  = right;
        }
    }
}
</script>
</head>
<body>
<pre onClick ="HighlightCode(this);">
%EXPORT_TAGS = (
    crlf    => [qw(CR LF CRLF $CR $LF $CRLF)],
    all     => [@EXPORT, @EXPORT_OK],
);

BEGIN {
    sub CR   () {"\015"}
    sub LF   () {"\012"}
    sub CRLF () {"\015\012"}
}

*CR   = \CR();
*LF   = \LF();
*CRLF = \CRLF();

sub sockaddr_in {
    if (@_ == 6 && !wantarray) { # perl5.001m compat; use this && die
    my($af, $port, @quad) = @_;
    warnings::warn "6-ARG sockaddr_in call is deprecated" 
        if warnings::enabled();
    pack_sockaddr_in($port, inet_aton(join('.', @quad)));
    } elsif (wantarray) {
    croak "usage:   (port,iaddr) = sockaddr_in(sin_sv)" unless @_ == 1
+;
        unpack_sockaddr_in(@_);
    } else {
    croak "usage:   sin_sv = sockaddr_in(port,iaddr))" unless @_ == 2;
        pack_sockaddr_in(@_);
    }
}

# comment blaat
my $i = 2345;

sub sockaddr_un {
    if (wantarray) {
    croak "usage:   (filename) = sockaddr_un(sun_sv)" unless @_ == 1;
        unpack_sockaddr_un(@_);
    } else {
    croak "usage:   sun_sv = sockaddr_un(filename)" unless @_ == 1;
        pack_sockaddr_un(@_);
    }
}
</pre>
</body>
</html>


// At the moment it's rather colorfull but that's just to show what it can.

// Perhaps it could be discussed here if we could use it on the monestary.
// If you find bugs or have suggestions for improvements, you might want to pm/mail/call/write me.

// Comment on (Client side) Perl Syntax Highlighter
// Download Code
// Re: (Client side) Perl Syntax Highlighter
// by iguanodon on Mar 12, 2004 at 13:58 UTC

//       ++Jaap

//       Very cool, a fine piece of work.

// 	[reply]
// Re: (Client side) Perl Syntax Highlighter
// by Rich36 on Mar 12, 2004 at 15:23 UTC

//       That's really cool. You might consider calling the sub from an <body onLoad=""> event instead of the onClick. I noticed that when you click again in the text, some of the text moves a little on the screen - specifically lines that start with "my"(in IE 6). Or maybe set a variable so you can only fire the event once.

//       «Rich36» 

// 	[reply]
// Re: (Client side) Perl Syntax Highlighter
// by jdtoronto on Mar 12, 2004 at 15:56 UTC

//       A great contribution, I always knew there must be a good use for JavaScript!

// 	[reply]
// Re: (Client side) Perl Syntax Highlighter
// by krujos on Mar 12, 2004 at 17:19 UTC

//       ++
//       Thanks for a handy tool! 

// 	[reply]
// Re: (Client side) Perl Syntax Highlighter
// by PodMaster on Mar 12, 2004 at 18:24 UTC

//       Here's a few additions to make the javascript completely unobtrusive :)(all you add is the <script src...</script> and that's it)

//       addEvent(window, "load", FunHighlight);
//       function addEvent(obj, evType, fn){
//         /* adds an eventListener for browsers which support it
//            Written by Scott Andrew: nice one, Scott */
//         if (obj.addEventListener){
//           obj.addEventListener(evType, fn, true);
//           return true;
//         } else if (obj.attachEvent){
//           var r = obj.attachEvent("on"+evType, fn);
//           return r;
//         } else {
//           return false;
//         }
//       }
//       function FunHighlight()
//       {
//           // We don't actually need createElement, but we do
//           // need good DOM support, so this is a good check.
//           if (!document.createElement) return;
          
//           pres = document.getElementsByTagName("tt");
//           for(var prei=0; prei < pres.length; prei++) {
//               var pre = pres[prei];
//               if( pre.className == "code") {
//                   HighlightCode(pre);
//               }
//           }
//       }


//       This of course relies on the fact that <code> tags translate into <pre><tt class="code"><font size="-1"> .

//       MJD says "you can't just make shit up and expect the computer to know what you mean, retardo!"
//       I run a Win32 PPM repository for perl 5.6.x and 5.8.x -- I take requests (README).
//       ** The third rule of perl club is a statement of fact: pod is sexy.

// 	[reply]
// [d/l]
// [select]

//       Re: Re: (Client side) Perl Syntax Highlighter
//       by Jaap on Mar 12, 2004 at 21:34 UTC

//             Hmmm that's pretty nifty. The only problem that remains is how to get the <script .../> tags in.

//             Is this something we want on perlmonks?

// 	[reply]

//             Re: Re: Re: (Client side) Perl Syntax Highlighter
//             by PodMaster on Mar 12, 2004 at 22:57 UTC

//                       Is this something we want on perlmonks? 

//                   Sure, why not? It'd be perlmonks approved javascript (it already exists). It could be optional (a setting) but it doesn't have to be (if javascript is on, it works, otherwise, who cares).

//                   MJD says "you can't just make shit up and expect the computer to know what you mean, retardo!"
//                   I run a Win32 PPM repository for perl 5.6.x and 5.8.x -- I take requests (README).
//                   ** The third rule of perl club is a statement of fact: pod is sexy.

// 	[reply]
// Re: (Client side) Perl Syntax Highlighter
// by neniro on Mar 12, 2004 at 18:43 UTC

//       That's the best use for JS I've seen so far. Great work!

// 	[reply]
// Re: (Client side) Perl Syntax Highlighter
// by tachyon on Mar 12, 2004 at 19:08 UTC

//       Fascinating! These patches fix the moving my issue (actually any key word that follows a comment will right shift onClick refresh) and convert tabs to 4 spaces for consistency.

//       45c45
//       <         s = s.replace(/\&/g, "&amp;").replace(/</g, "&lt;").replace(
//       +/>/g, "&gt;").replace(/\n/g, "<BR>");
//       ---
//       >         s = s.replace(/\&/g, "&amp;").replace(/</g, "&lt;").replace(
//       +/>/g, "&gt;").replace(/\n/g, "<BR>").replace(/\t/g, '    ');
//       80c80
//       < re  = /\#.*?(\r|\n)/;
//       ---
//       > re  = /\#.*?[\r|\n]+/;

//       cheers

//       tachyon

// 	[reply]
// [d/l]

//       Re: Re: (Client side) Perl Syntax Highlighter
//       by Jaap on Mar 12, 2004 at 21:29 UTC

//             Thank you. Did you mean for the '|' to be between the \r and \n?

// 	[reply]

//             Re: Re: Re: (Client side) Perl Syntax Highlighter
//             by tachyon on Mar 12, 2004 at 21:45 UTC

//                   Nope! I meant [\n\r]+ Great work, very impressive use of JS. As the author you have to patch the patches :-)

//                   cheers

//                   tachyon

// 	[reply]
// [d/l]
// Re: (Client side) Perl Syntax Highlighter
// by BUU on Mar 13, 2004 at 10:43 UTC

//       Thats incredibly cool stuff. Two bugs though, stuff to the left of a => should be displayed as a string, and stuff inside a qwxx should also be displayed as strings, currently it's highlighting the sigils of variables inside one.

