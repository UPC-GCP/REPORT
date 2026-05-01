% ##############################################################################
% Document class identification.
% ##############################################################################
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cttc-thesis}[2018/06/20 CTTC PhD Thesis template]

% ##############################################################################
% Required packages.
% More packages are being loaded below,
% after the 'book' document class has been loaded.
% ##############################################################################
\RequirePackage{psfrag,wrapfig,color}
\RequirePackage{setspace,amsmath,tabularx,ifthen,ifpdf,ifxetex,url}
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{xspace}

% ##############################################################################
% Option processing.
% ##############################################################################
% ------------------------------------------------------------------------------
% option: norightchapter
%
% The chapters may start on odd or even pages. The
% default is that they only start at odd pages.
% ------------------------------------------------------------------------------
\def\right@chapter{1}
\DeclareOption{norightchapter}{%
  \def\right@chapter{0}
}
% ------------------------------------------------------------------------------
% option: nosidetitle
%
% Does not print a side title with autor's name
% and thesis presentation date. The default is to
% print the side title.
% ------------------------------------------------------------------------------
\def\no@sidetitle{}
\DeclareOption{nosidetitle}{%
  \def\no@sidetitle{0}
}
% ------------------------------------------------------------------------------
% option: nochbib
%
% Does not include the chapterbib package,
% responsible of some problems with the
% bibliography
%
% ********** WARNING ***********
% when using the natbib package, the references
% start a new chapter instead a new section.
% invoke natbib with sectionbib option:
% \usepackage[sectionbib]{natbib}
% \addtocontents{toc}{section}{References}
% \renewcommand\bibsection{%
% \section*{\refname\@mkboth{{\refname}}{{\refname}}}%
% }
% ******************************
% ------------------------------------------------------------------------------
\def\no@chbib{}
\DeclareOption{nochbib}{%
  \def\no@chbib{0}
}
% ------------------------------------------------------------------------------
% option: cover
%
% generates the cover
% ------------------------------------------------------------------------------
\def\c@ver{}
\DeclareOption{cover}{%
  \def\c@ver{0}
}

\ProcessOptions\relax

% ##############################################################################
% Clase base: book.
% ##############################################################################
\LoadClass[10pt,openright]{book}
\RequirePackage{longtable,graphicx,makeidx,cite}
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\ifx\no@chbib\empty\RequirePackage{chapterbib}\fi
\ifpdf%
  \RequirePackage[pdftex]{hyperref}
  \def\hy@colorlink#1{\begingroup\color{#1}}%
  \def\hy@endcolorlink{\endgroup}%
  \pdfoutput=1\pdfpagewidth=210mm\pdfpageheight=297mm
  \paperwidth=210mm\paperheight=297mm\pdfadjustspacing=1
\fi%

% ##############################################################################
% Main code.
% DO NOT CHANGE THIS SETUP!
% ##############################################################################
\RequirePackage{geometry}
\geometry{text={130mm,172mm},centering}

% keeps constant the distance between paragraphs
\raggedbottom

% ------------------------------------------------------------------------------
% Define the different parts of the document.
% Makes sure that headers supply the correct information.
% ------------------------------------------------------------------------------
\newcounter{usedchap} \setcounter{usedchap}{0}
\def\leaderfill{\leavevmode\leaders\hrule height0.8pt\hfill\kern\z@}
\def\capname{}

\pagenumbering{alph}

\renewcommand\frontmatter{%
  \setcounter{chapter}{0}%
    \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{roman}
  \def\chaptermark##1{\markboth{\it##1}{\it##1}}
  \def\chaptername{}
}

\renewcommand\mainmatter{%
  \setcounter{chapter}{0}%
    \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
  \def\sectionmark##1{\markright{\it\thesection~~##1}{}}
  \def\chaptermark##1{\markboth{\it\chaptername~\thechapter.~##1}{}}
  \def\chaptername{Chapter}
}

\renewcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \def\thechapter{\@Alph\c@chapter}
  \def\capname{\appendixname}
  \def\chaptername{Appendix}
}

% ------------------------------------------------------------------------------
% Defines the ChapterAbstract command, which is intended
% to be the abstract for each chapter of the thesis. As an
% optional argument it accepts a note (useful if the chapter
% has been published somewhere).
% ------------------------------------------------------------------------------
\def\chapabsfont{\rm}
\newcommand{\ChapterAbstract}[2][]{%
  {\chapabsfont\fontsize{9pt}{11}\selectfont%
  \ifx#1\empty\else\noindent{#1}\par\fi%
  \vspace{1em}
  \noindent{\bfseries Abstract.} #2}
  \eject
}

% ------------------------------------------------------------------------------
% Redefinition of \tableofcontents to avoid
% the uppercase of \contentsname.
% ------------------------------------------------------------------------------
\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }

% ------------------------------------------------------------------------------
% Labels "Bibliography" as "References", at a section level.
% Heading marks are not uppercase and an entry is added to
% the table of contents.
% ------------------------------------------------------------------------------
\def\BIBname{References}
\renewenvironment{thebibliography}[1]
  {\section*{\BIBname
      \phantomsection%
      %\@mkboth{\it\BIBname}{\it\BIBname}}
      \markright{\it\BIBname}}
    \addcontentsline{toc}{section}{\numberline{}{\BIBname}}%
    \list{\@biblabel{\@arabic\c@enumiv}}%
    {\settowidth\labelwidth{\@biblabel{#1}}%
      \leftmargin\labelwidth
      \advance\leftmargin\labelsep
      \@openbib@code
      \usecounter{enumiv}%
      \let\p@enumiv\@empty
      \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
    \endlist}

% ------------------------------------------------------------------------------
% Concept index.
% The concept index is disabled by default.
% ------------------------------------------------------------------------------
\renewenvironment{theindex}
  {\if@twocolumn
    \@restonecolfalse
  \else
    \@restonecoltrue
  \fi
  \columnseprule \z@
  \columnsep 35\p@
  \twocolumn[\cmdb{\indexname}]%
  \refstepcounter{chapter}%
  \addcontentsline{toc}{chapter}{\indexname}%
  \@mkboth{\indexname}%
  {\indexname}%
  \thispagestyle{plain}\parindent\z@
  \parskip\z@ \@plus .3\p@\relax
  \let\item\@idxitem}
  {\if@restonecol\onecolumn\else\clearpage\fi}

\renewcommand{\theequation}{\thechapter.\arabic{equation}}

% ------------------------------------------------------------------------------
% New commands/environments.
% ------------------------------------------------------------------------------
\def\chapterfig#1{%
\begin{htmlonly}
\begin{figure}[t]
\includegraphics[totalheight=11cm]{#1}
\end{figure}
\end{htmlonly}
}

% ------------------------------------------------------------------------------
% First pages of the thesis.
% ------------------------------------------------------------------------------
%
% Internal variables
% ******************

\def\@titol{No title}
\def\@author{No author}
\def\@image{}
\def\@prdate{No presentation date}
\def\@univ{Centre Tecnològic de Transferència de Calor\\%
           Departament de Màquines i Motors Tèrmics\\%
           Universitat Politècnica de Catalunya\\}
\def\tribu@text{Tribunal Qualificador}
\def\direc@text{\ifnum\value{diren}>1 Directors de la Tesi\else%
  Director de la tesi\fi}
\def\cdire@text{\ifnum\value{cdirn}>1 Co-directors de la Tesi\else%
  Co-director de la tesi\fi}
\def\tut@text{\ifnum\value{tutn}>1 Tutors\else%
  Tutor\fi}
\def\thesis@text{TESI DOCTORAL}
\def\presen@text{presentada al}
\def\obgrau@text{per a l'obtenció del grau de}
\def\grau@text{Doctor en Ciències Físiques}
\def\llocp@text{Terrassa}
\def\univp@text{Departament de Màquines i Motors Tèrmics\\%
                ESEIAAT\\%
                Universitat Politècnica de Catalunya\\}

\dimendef\ttf=255
\dimendef\uvf=254
\dimendef\auf=253
\dimendef\attf=252
\dimendef\mttf=251
\ttf=24pt
\mttf=36pt
\uvf=16pt
\auf=14pt
\attf=20pt

\newcounter{tribn} \setcounter{tribn}{0}
\newcounter{diren} \setcounter{diren}{0}
\newcounter{cdirn} \setcounter{cdirn}{0}
\newcounter{tutn} \setcounter{tutn}{0}
\newcounter{dummy} \setcounter{dummy}{0}

% External commands and variables
% *******************************
\newlength{\titleskip} \newlength{\titlesep} \newlength{\titleheight}
\newlength{\coverheight} \newlength{\covervadjust}
\setlength{\covervadjust}{0cm}
\newlength{\finetune} \setlength{\finetune}{2mm}
\setlength{\titleskip}{1.5cm}
\setlength{\titlesep}{0cm} \setlength{\titleheight}{0.5cm}

\gdef\@imageheight{8cm}
\newcommand{\settitle}[1]{\gdef\@titol{#1}}
\newcommand{\setauthor}[1]{\gdef\@author{#1}}
\newcommand{\setimage}[1]{\gdef\@image{#1}}
\newcommand{\setimageheight}[1]{\gdef\@imageheight{#1}}
\newcommand{\setprdate}[1]{\gdef\@prdate{#1}}
\newcommand{\setuniv}[1]{\gdef\@univ{#1}}
\newcommand{\settitlestring}[1]{\gdef\titlestring{#1}}
\newcommand{\setmaintitle}[1]{\gdef\main@title{#1}}

\long\def\titolfnt#1{\bfseries\fontsize{\ttf}{1.2\ttf}\selectfont{#1}}
\long\def\maintitlefont{\bfseries\sffamily\fontsize{\mttf}{1.2\mttf}\selectfont}

\long\def\atitolfnt#1{\bfseries\fontsize{\attf}{1.2\attf}\selectfont{#1}}
\long\def\univfnt#1{\fontsize{\uvf}{1.2\uvf}\selectfont{#1}}
\long\def\authorfnt#1{\fontsize{\auf}{1.3\auf}\selectfont{#1}}

\newcommand{\settribunal}[2]{%
  \addtocounter{tribn}{1}%
  \expandafter\def\csname trib@nom\romannumeral\thetribn\endcsname{#1}%
  \expandafter\def\csname trib@uni\romannumeral\thetribn\endcsname{#2}%
}

\newcommand{\setdirector}[1]{%
  \addtocounter{diren}{1}%
  \expandafter\def\csname dire@nom\romannumeral\thediren\endcsname{#1}%
}

\newcommand{\setcodirector}[1]{%
  \addtocounter{cdirn}{1}%
  \expandafter\def\csname cdir@nom\romannumeral\thecdirn\endcsname{#1}%
}

\newcommand{\settutor}[1]{%
  \addtocounter{tutn}{1}%
  \expandafter\def\csname tut@nom\romannumeral\thetutn\endcsname{#1}%
}

\newcommand{\setdegree}[1]{\def\grau@text{#1}}
\newcommand{\setdegreeintro}[1]{\def\obgrau@text{#1}}
\newcommand{\setdegreeloc}[1]{\def\llocp@text{#1}}
\newcommand{\setdegreename}[1]{\def\thesis@text{#1}}
\newcommand{\setdegreepres}[1]{\def\presen@text{#1}}
\newcommand{\setdegreeuniv}[1]{\def\univp@text{#1}}

% ##############################################################################
% Title command.
% ##############################################################################
\long\def\titol{%
  \ifpdf%
    \hypersetup{pdfauthor={\@author},pdftitle={\@titol}}
  \fi%
  \ifx\c@ver\empty
  %
  % First page. To be printed alone.
  %
  \thispagestyle{empty}
  \coverheight=241mm
  \newsavebox{\@@nom} \newsavebox{\@@rnom}
  \def\main@title{DOCTORAL THESIS}
  \def\datestrng{\it UPC $-$ \@prdate\hspace{\titlesep}}
  \setbox0=\hbox{\main@title}
  \setbox1=\hbox{\datestrng}
  \def\titlestring{%
    \hbox to 0pt{\hspace{\titlesep}\it\@author}
    \hspace{0.465\coverheight}%
    \hspace{-0.5\wd0}\main@title\hspace{-0.5\wd0}\hspace{0.465\coverheight}%
    \hspace{-\wd1}\datestrng}
  \ifpdf%
    \savebox{\@@nom}[229mm]{\titlestring}%warning!!
  \else
    \savebox{\@@nom}[0.95\paperheight]{\titlestring}
  \fi%
  %\savebox{\@@rnom}[0pt][l]{\rotatebox{270}{\usebox{\@@nom}}}
  \begin{center}
    \reversemarginpar
    \addtolength{\titleheight}{2cm}
    \addtolength{\titleheight}{\finetune}
    \marginparsep\titleheight
    \addtolength{\titleheight}{-2cm}
    \addtolength{\titleheight}{-\finetune}
    \ifx\no@sidetitle\empty\marginpar{\vspace{-3.2cm}\usebox{\@@rnom}}\fi
    \normalmarginpar
    \vspace{-3.0cm}{%
      \titolfnt{UPC \hfill CTTC}\par\vspace{2.0cm}
      {\maintitlefont\baselineskip=30pt\@titol}\par%
    }
    \vfill
    \ifx\@image\empty%
      \par\vspace{2cm}\else
      \par\vspace{0.5cm}\includegraphics[height=\@imageheight]{\@image}
      \par\vspace{0.5cm}
    \fi
    \par\vfill
    {\univfnt{\@univ}}\par
    \par\vfill
    {\authorfnt{\@author\par\vspace{2mm} Doctoral Thesis}}
  \end{center}
  \eject
  %
  % Blank page
  %
  \strut\thispagestyle{empty}\eject
  %
  % Page 2. Degree of Doctor
  %
  \thispagestyle{empty}
  \begin{center}
    {\atitolfnt{\@titol}\par}
    \par\vspace{\titleskip}
    {\authorfnt{\@author}\par}
    \vspace{\titleskip}
    \thesis@text\par
    \vspace{\titleskip}
    \presen@text\par
    \vspace{1cm}
    \univp@text\par
    \vspace{1.5cm}
    \obgrau@text\par
    \vspace{0.5cm}
    \grau@text\par
    \vspace{2cm}
    \llocp@text, \@prdate\par
    \vfill
  \end{center}
  \eject
  %
  % Blank page
  %
  \strut\thispagestyle{empty}\eject
  %
  % Page 3. Qualifying tribunal.
  %
  \thispagestyle{empty}
  \begin{center}
    {\atitolfnt{\@titol}\par}
    %\par\vspace{2cm}
    \par\vfill
    {\authorfnt{\@author}\par}
    %\vspace{2cm}
    \par\vfill
    {\bf\authorfnt{\direc@text}\par\vspace{0.5cm}}
    \ifnum\value{diren}=0\errmessage{No has definit el/s director/s!!!}\fi
    \setcounter{dummy}{0}
    \loop\ifnum\value{dummy}<\value{diren}{%
      \addtocounter{dummy}{1}
      {\authorfnt{\csname dire@nom\romannumeral\thedummy\endcsname}}\par\vspace{0.8ex}
    }
    \repeat
    %\vspace{2cm}
    \par\vspace{5mm}
    \ifnum\value{cdirn}>0{%
      {\bf\authorfnt{\cdire@text}\par\vspace{0.3cm}}
      \setcounter{dummy}{0}
      \loop\ifnum\value{dummy}<\value{cdirn}{%
        \addtocounter{dummy}{1}
        {\authorfnt{\csname cdir@nom\romannumeral\thedummy\endcsname}}\par\vspace{0.8ex}
      }
      \repeat
      \par\vspace{5mm}
    }\fi
    \ifnum\value{tutn}>0{%
      {\bf\authorfnt{\tut@text}\par\vspace{0.3cm}}
      \setcounter{dummy}{0}
      \loop\ifnum\value{dummy}<\value{tutn}{%
        \addtocounter{dummy}{1}
        {\authorfnt{\csname tut@nom\romannumeral\thedummy\endcsname}}\par\vspace{0.8ex}
      }
      \repeat
    }\fi
    \par\vfill
    {\bf\authorfnt{\tribu@text}\par\vspace{0.3cm}}
    \ifnum\value{tribn}=0\errmessage{No has definit el tribunal!!!}\fi
    \setcounter{dummy}{0}
    \loop\ifnum\value{dummy}<\value{tribn}{%
      \addtocounter{dummy}{1}
      {\authorfnt{\csname trib@nom\romannumeral\thedummy\endcsname}}\par
      \csname trib@uni\romannumeral\thedummy\endcsname\par\vspace{0.25cm}
    }
    \repeat
    %\vfill
  \end{center}
  \eject
  %
  % Blank page
  %
  \strut\thispagestyle{empty}\eject
  \else
  \cover
  \fi
}

% ##############################################################################
% Cover command.
% ##############################################################################
\long\def\cover{%
  \paperwidth=400mm\coverheight=241mm
  \ifpdf%
    \pdfpagewidth=420.2mm\pdfpageheight=297mm\setlength{\covervadjust}{-0.8cm}
  \fi
  \hoffset=224.6mm %with the natural 1inch (25.4mm) offset that makes 130mm
  \thispagestyle{empty}
  \def\main@title{DOCTORAL THESIS}
  \def\datestrng{\it UPC $-$ \@prdate\hspace{\titlesep}}
  \setbox0=\hbox{\main@title}
  \setbox1=\hbox{\datestrng}
  \def\titlestring{%
    \hbox to 0pt{\hspace{\titlesep}\it\@author}
    \hspace{0.465\coverheight}%
    \hspace{-0.5\wd0}\main@title\hspace{-0.5\wd0}\hspace{0.465\coverheight}%
    \hspace{-\wd1}\datestrng}
  \newsavebox{\@@nom} \newsavebox{\@@rnom}
  \savebox{\@@nom}[0.95\paperheight]{\titlestring}
  \savebox{\@@rnom}[0pt][l]{\rotatebox{270}{\usebox{\@@nom}}}
  \begin{center}
    \reversemarginpar%
    \addtolength{\titleheight}{2cm}%
    \addtolength{\titleheight}{\finetune}
    \marginparsep\titleheight
    \addtolength{\titleheight}{-2cm}
    \addtolength{\titleheight}{-\finetune}
    \addtolength{\covervadjust}{-5.5cm}
    \ifx\no@sidetitle\empty\marginpar{\vspace{\covervadjust}\usebox{\@@rnom}}\fi
    \normalmarginpar
    \vspace{-3.0cm}{\titolfnt{UPC \hfill CTTC}\par\vspace{2.0cm}
    {\maintitlefont\baselineskip=30pt\@titol}
    \par}
    \vfill
    \par\vspace{\@imageheight}\vfill
    {\univfnt{\@univ}}\par
    \par\vfill
    {\authorfnt{\@author\par\vspace{2mm} Doctoral Thesis}}
  \end{center}

  \eject
  \end{document}
  }
