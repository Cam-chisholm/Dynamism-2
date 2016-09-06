\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{grattanAlphaXe}[2015/02/27 Reports of the Grattan Institute, Melbourne using XeLaTeX]

\LoadClass[a4paper,11pt,titlepage,headings=big,chapterprefix=false,headsepline,
parskip=half-,twocolumn,numbers=noenddot]{scrreprt}
\RequirePackage{scrhack}
\RequirePackage{acronym}
\RequirePackage{makeidx}
  \makeindex
\RequirePackage{xcolor}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{adjustbox}
\RequirePackage{tikz}
  \usetikzlibrary{positioning}
  \usetikzlibrary{decorations.text}
  \usetikzlibrary{decorations.pathmorphing}
  \usetikzlibrary{patterns,arrows,decorations.pathreplacing} % for waterfalls
\RequirePackage{float}
\RequirePackage{placeins}
\RequirePackage{afterpage}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{etoolbox}
\AtBeginEnvironment{tabularx}{\relax\small}

\RequirePackage{eso-pic}
%% Options around ragged and sloppiness
\newif\if@microtype\@microtypefalse
\DeclareOption{microtype}{\@microtypetrue}
\newif\if@ragged\@raggedtrue
\DeclareOption{ragged}{\@raggedtrue}
\newif\if@sloppy\@sloppytrue

\setlength{\parskip}{7pt plus 3pt minus 2pt}

%% FrontPage options
%% First, the default, plain front page with a title.
\newcommand*{\titleTH}{\begingroup % Create the command for including the title page in the document
\raggedleft % Right-align all text
\vfil
\phantom{.}\hfill 
\includegraphics[width=0.225\paperwidth,keepaspectratio]{./logos/GrattanSVGLogo}
\vspace{30pt}
\vfil % Whitespace at the top of the page

{\bfseries\textcolor{Orange}{\fontsize{30}{30}\selectfont \mytitle}}\\[\baselineskip] % Title page font size
%% This is a working paper.
{\Large \mysubtitle}\\[2\baselineskip] % Tagline or further description

{\LARGE \myauthor}

\vfill% Whitespace at the bottom of the page
\endgroup}
\newcommand{\BackgroundPic}{}

% Alternatively, if FrontPage is declared, the file there is used as the frontpage picture
\DeclareOption{FrontPage}{
	\IfFileExists{./FrontPage/FrontPage.pdf}{%
	    %\includegraphics[width=\paperwidth,keepaspectratio]{./FrontPage/FrontPage}%
	  }{
	    \ClassError{grattanAlpha}{%
			'./FrontPage/FrontPage.pdf' does not exist
	    }{%
			You have asked for a fullpicture option, but we can't find 
			a file at './FrontPage/FrontPage.pdf'. Try placing the image
			there or not using the fullpicture option.
		}
	  }
	\renewcommand\BackgroundPic{%
		\put(0,0){%
		\parbox[b][\paperheight]{\paperwidth}{%
		\vfill
		\centering
		% Amend
		\IfFileExists{./FrontPage/FrontPage.pdf}{%
			\includegraphics[width=\paperwidth,keepaspectratio]{./FrontPage/FrontPage.pdf}%
		}{
			\ClassError{grattanAlpha}{%
				'./FrontPage/FrontPage' does not exist
			}{%
				You have asked for a fullpicture option, but we can't find 
				a file at './FrontPage/FrontPage'. Try placing the image
				there or not using the fullpicture option.
			}
		}
	\vfill
	}}}
	\renewcommand{\titleTH}{} % FrontPage should be entire.

}

\ProcessOptions\relax

\if@microtype
    \RequirePackage{microtype}
    \@raggedfalse
    \@sloppyfalse
\fi
\if@ragged
    \RequirePackage{ragged2e}
    \AtBeginDocument{\RaggedRight}
    \hyphenpenalty=5000
\fi
\if@sloppy
    \raggedbottom
\fi

%\DisableLigatures{encoding = T1, family = *}
% ------
% Grattan colors
\definecolor{Orange}{HTML/cmyk}{F68B33/0,0.435,0.7927,0.0353}
\definecolor{DarkOrange}{HTML/cmyk}{D4582A/0,0.5849,0.8019,0.1686}
\definecolor{OrangeBackground}{RGB}{254,240,222}  % for boxes
\definecolor{Color1}{RGB}{255,224,127}
\definecolor{Color2}{RGB}{255,195,90}
\definecolor{Color3}{RGB}{246,139,51}
\definecolor{Color4}{RGB}{212,88,42}
\definecolor{Color5}{RGB}{160,34,38}
\definecolor{Color6}{RGB}{98,18,20}
\definecolor{theGrey}{HTML}{6A737B}
\definecolor{AuthorPage}{RGB}{160,34,38}
\definecolor{AuthorGrey}{RGB}{174,174,174}

% See http://tex.stackexchange.com/questions/8510/reduce-size-of-bullet-character-in-lists
% Purpose to enlarge and subsequently raise the bullet
% see also \renewcommand{\labelitemi}{\raise .5ex\hbox{\tiny$\bullet$}}
\renewcommand{\labelitemi}{\color{Orange}\parbox[c]{.5em}{\ensuremath{\bullet}}}
\renewcommand{\labelenumi}{\color{Orange}{\bfseries \arabic{enumi}.~}}
% ------
\RequirePackage{colortbl}
\RequirePackage{array}
\RequirePackage{tablefootnote} % for footnotes within tables
\newcommand{\myhline}{\noalign{\global\arrayrulewidth1pt}\hline
                      \noalign{\global\arrayrulewidth1pt}}


\RequirePackage{graphicx}

% No widows
\RequirePackage[all]{nowidow}

% Arial font
\RequirePackage{fontspec}
\setmainfont[Path=Fonts/,BoldFont=arialbd.ttf,ItalicFont=ariali.ttf,BoldItalicFont=arialbi.ttf]{arial.ttf}

\RequirePackage[framemethod=TikZ]{mdframed}
\RequirePackage{newfloat}
\RequirePackage{caption}
% Cross references.
\RequirePackage{varioref}
% \RequirePackage{navigator}
% \newcommand\Chapter[1]{%
%   \chapter[\protect\jumplink{ch\thechapter}{#1}]{#1}%
%   \outline[fit=fitv]{1}[ch\thechapter]{#1}%
% }
\RequirePackage[colorlinks, colorlinks = true, urlcolor=blue, linkcolor=black,citecolor=black]{hyperref}
\RequirePackage{cleveref}

% Make url formatting the same
\urlstyle{same}

%% Footnotes:
\deffootnote[1em]{0em}{1em}{\textsuperscript{\thefootnotemark}\ }

\DeclareCaptionFont{Orange}{\color{Orange}}
\DeclareCaptionJustification{nohyphen}{\hyphenpenalty=10000}
\captionsetup{justification=nohyphen, singlelinecheck=false}

% Boxes
\crefname{boxe}{Box}{Boxes}
\Crefname{boxe}{Box}{Boxes}
\DeclareFloatingEnvironment[listname={List of boxes}, name = {Box}]{boxe}
\mdfdefinestyle{GrattanFrameBox}{%
    linecolor=Orange,
    nobreak=true, % prevents page breaking
    outerlinewidth=0.5pt,
    innertopmargin=0.5\baselineskip,
    innerbottommargin=\baselineskip,
    innerrightmargin=11pt,
    innerleftmargin=11pt,
    backgroundcolor=OrangeBackground
    }
    
\mdfdefinestyle{GrattanFrameBoxUltra}{%
    linecolor=Orange,
    nobreak=true, % prevents page breaking
    outerlinewidth=0.5pt,
    innertopmargin=0.5\baselineskip,
    innerbottommargin=\baselineskip,
    innerrightmargin=11pt,
    innerleftmargin=11pt,
    backgroundcolor=OrangeBackground
    }
    
% The smallbox is a box intended for onecolumn.
\newenvironment{smallbox}[3][p]{%
\setlength{\currentparskip}{\parskip}% save the value
\begin{boxe}[#1]
\null\vfill
\begin{mdframed}[style=GrattanFrameBox]%
\setlength{\parskip}{\currentparskip}% restore the value
\captionsetup{labelfont={bf,Orange},font={bf,Orange},skip=1.5ex,format=plain,justification=justified,singlelinecheck=false}
\caption{#2}\label{#3}
\vspace{-1.5ex}
}{\end{mdframed}\vfill\null\end{boxe}} 



% Big boxes -- over the whole page
% It is recommended to surround this with an \afterpage{% 
\newenvironment{bigbox}[2]{\onecolumn\setlength{\currentparskip}{\parskip}
\begin{boxe}
\begin{mdframed}[style=GrattanFrameBox]%
\setlength{\columnsep}{10mm}
\setlength{\parskip}{\currentparskip}% restore the value
 \captionsetup{labelfont={bf,Orange}, font={bf,Orange}, format=plain,justification=justified,singlelinecheck=false}
 \caption{#1}\label{#2} \begin{multicols}{2}%
 } {\end{multicols}\end{mdframed}\end{boxe}\twocolumn}

% dbl floats
\newenvironment{bigbox*}[2]{%
  \setlength{\currentparskip}{\parskip}
  \@dblfloat{boxe}%
  \begin{mdframed}[style=GrattanFrameBox]
  \setlength{\columnsep}{10mm}
 
  \setlength{\parskip}{\currentparskip}% restore the value
 \captionsetup{labelfont={bf,Orange}, font={bf,Orange}, format=plain,justification=justified,singlelinecheck=false}
 \caption{#1}\label{#2}  \begin{multicols}{2}%
}{%
  \end{multicols}\end{mdframed}
  \end@dblfloat
}

% caption above body text
\newenvironment{bigboxC*}[2]{%
  \setlength{\currentparskip}{\parskip}
  \@dblfloat{boxe}%
  \begin{mdframed}[style=GrattanFrameBox]
  \setlength{\columnsep}{10mm}
  \captionsetup{labelfont={bf,Orange}, position=top, skip=0pt, font={bf,Orange}, format=plain, justification=centering, singlelinecheck=false}
  \caption{#1}\label{#2}%
  \begin{multicols}{2}
  \setlength{\parskip}{\currentparskip}% restore the value
}{%
  \end{multicols}\end{mdframed}
  \end@dblfloat
}
 
\newenvironment{ultrabox}[2]{\onecolumn\setlength{\currentparskip}{\parskip}
\begin{boxe}
\pagecolor{OrangeBackground}
\begin{mdframed}[style=GrattanFrameBoxUltra]%
\setlength{\columnsep}{10mm}
\begin{minipage}[t][\textheight][t]{\textwidth} % textheight
\begin{multicols}{2}
\setlength{\parskip}{\currentparskip}% restore the value
 \captionsetup{labelfont={bf,Orange}, font={bf,Orange}, format=plain,justification=justified,singlelinecheck=false}
 \caption{#1}\label{#2}%
 } {\end{multicols}\end{minipage}\end{mdframed}\end{boxe}%
 \clearpage\twocolumn\nopagecolor}
 

% Captions in general
\DeclareCaptionFont{theGrey}{\color{theGrey}}
\captionsetup{format=plain,font={small,bf,theGrey}, skip=2pt, labelfont={small,bf,theGrey}}
% suppress hyphenation in caption
\DeclareCaptionJustification{nohyphen}{\hyphenpenalty=10000}
\captionsetup{justification=nohyphen}

\newcommand{\boxfigurecaption}[1]{%
\captionsetup{format=plain,font={small,bf,theGrey},labelfont={small,bf,theGrey}, justification=raggedright,
singlelinecheck=false,position=top,skip=0pt}
\caption{#1}
%\vspace{-11pt}
}

\newcommand{\units}[1]{%
\captionsetup{font={small,color=theGrey},skip=1pt}
\caption*{#1}
}

%\newcommand{\captionoffigurewithunits}[2]{%
%\captionsetup{format=plain,font={small,bf,theGrey},labelfont={small,bf,theGrey}, justification=raggedright,
%singlelinecheck=false}
%\captionof{figure}{#1}
%\vspace{-11pt}
%\captionsetup{font={small,color=theGrey}}
%\caption*{#2}
%}

% New user friendly (less typing) \Caption?
%\newcommand{\Caption}[3]{\captionwithunits{#1}{#2}\label{#3}}

\newcommand*{\source}[1]{%
\captionsetup{format=plain, font={footnotesize, it}, skip=1.5pt, justification=justified, singlelinecheck=false, position=below}
\caption*{Source:\ #1}
}
\newcommand*{\notes}[1]{%
\captionsetup{format=plain, font={footnotesize, it}, skip=1.5pt, justification=justified, singlelinecheck=false, position=below}
\caption*{Notes:\ #1}
}

%\newcommand{\source}[1]{\footnotesize\textit{Source: #1}}
%\newcommand{\notes}[1]{\footnotesize\textit{Notes: #1}}

\newcommand{\longsource}[1]{\footnotesize\begin{tabular}[t]{lp{0.85\linewidth}}\textit{Source:} & \textit{#1}\end{tabular}}
\newcommand{\longnotes}[1]{\footnotesize\begin{tabular}[t]{lp{0.85\linewidth}}\textit{Notes:} & \textit{#1}\end{tabular}}

\setkomafont{disposition}{\color{Orange}}
\addtokomafont{chapter}{\bfseries\Large}
\addtokomafont{section}{\bfseries\normalsize}
\addtokomafont{subsection}{\bfseries\normalsize}
\addtokomafont{subsubsection}{\normalsize}

% Spacing
\RedeclareSectionCommand[
  beforeskip=0.5\baselineskip,
  afterskip=1.5\baselineskip]{chapter}
\RedeclareSectionCommand[
  beforeskip=0.5\baselineskip,
  afterskip=1sp]{section}
\RedeclareSectionCommand[
  beforeskip=-.75\baselineskip,
  afterskip=1sp]{subsection}
\RedeclareSectionCommand[
  beforeskip=-.5\baselineskip,
  afterskip=1sp]{subsubsection}
\RedeclareSectionCommand[
  beforeskip=.5\baselineskip,
  afterskip=-1em]{paragraph}
\RedeclareSectionCommand[
  beforeskip=-.5\baselineskip,
  afterskip=-1em]{subparagraph}

  
\renewcommand*{\@seccntformat}[1]{\csname the#1\endcsname\hspace{1.25em}}

  
% --------------
%
% Grattan twocolumn
%
%---------------

% N.B. geometry must be after hyperref, and hence cleveref


\RequirePackage[landscape,twocolumn,
% orig Word specify 2.3 and 2.5
left=2.75cm,right=2.75cm,top=3.3cm,bottom=3.9cm,head=32.8pt
]{geometry}

  %\addtolength{\columnwidth}{50pt}
  \setlength{\columnsep}{15mm}  
  %\addtolength{\columnwidth}{0.2\columnwidth}

% Ensures hyperlinked chapter headings refer to their referent headings
% not the preceding baseline
% Add extra hyper target for chapter: chapter..\thechapter
\renewcommand*{\chapterformat}{%
  \mbox{\raisebox{25pt}[0pt][0pt]{\hypertarget{chapter..\thechapter}{}}% Add 
    \chapappifchapterprefix{\nobreakspace}\thechapter\hspace{1em}\autodot\enskip}%
}

% Update \addcontentsline to jump to new hyper target _only_ if \chapter is used
\patchcmd{\addcontentsline}% <cmd>
  {\Hy@writebookmark}% <search>
  {\ifnum\pdfstrcmp{chapter}{#2}=0 % Chapter mark
     \edef\@currentHref{chapter..\thechapter}%
   \fi
   \Hy@writebookmark}% <replace>
  {}{}% <success><failure>

  
 % Requests forcefully that figures refrain from
% appearing in the first column.  This will fail
% should a \clearpage be experienced.
  \g@addto@macro\@floatplacement{%
  \if@firstcolumn
  \global\@colnum\z@
  \fi
  }
  
%% ---------------------------------
%  Headers and footers
%% ---------------------------------
\RequirePackage[headsepline=1pt,plainheadsepline,footsepline=1pt,plainfootsepline]{scrlayer-scrpage}

\addtolength{\textheight}{2\baselineskip}
\addtolength{\footskip}{-30pt}


%\addtolength{\textheight}{44pt}
%\addtolength{\footskip}{-12pt}
\addtolength{\textfloatsep}{-10pt}

\clearscrheadings
\clearscrplain
\clearscrheadfoot
% -------
% Heads and footers
%
\newcommand{\classification}{}
% Avoid spaces or newlines in the following commands' arguments: they 
% may cause errors.
% Furthermore, optional arguments are required: they appear in Chapter 
% heading pages. Leaving them out will reset the titles on pages with 
% \chapter{}
%\lehead[\normalfont\textcolor{theGrey}{Widening gaps: Technical report}]{\normalfont\textcolor{theGrey}{Widening gaps: Technical report}}
%\lohead[\normalfont\textcolor{theGrey}{Widening gaps: Technical report}]{\normalfont\textcolor{theGrey}{Widening gaps: Technical report}}
%\cehead[\classification]{\classification}
%\cohead[\classification]{\classification}
%\ifoot[{\textcolor{theGrey}{\normalfont Grattan Institute \the\year\phantom{\Large X}}}]{\textcolor{theGrey}{\normalfont Grattan Institute \the\year\phantom{\Large X}}}
%\cfoot[\classification]{\classification}
%\ofoot[\normalfont\textcolor{theGrey}{\thepage}]{\normalfont\textcolor{theGrey}{\thepage}}


\lehead[\normalfont\textcolor{theGrey}{\vspace*{10pt}\fulltitle} \\ \vspace*{-18pt}\color{Orange}{\line(2,0){689}} \\]{\normalfont\textcolor{theGrey}{\vspace*{10pt}\fulltitle} \\ \vspace*{-18pt}\color{Orange}{\line(2,0){689}} \\}
\lohead[\normalfont\textcolor{theGrey}{\vspace*{10pt}\fulltitle} \\ \vspace*{-18pt}\color{Orange}{\line(2,0){689}} \\]{\normalfont\textcolor{theGrey}{\vspace*{10pt}\fulltitle} \\ \vspace*{-18pt}\color{Orange}{\line(2,0){689}} \\}
\cehead[\classification]{\classification}
\cohead[\classification]{\classification}
\ifoot[\vspace*{7pt}{\color{Orange}{\line(2,0){689}} \\ \textcolor{theGrey}{\normalfont  Grattan Institute 2016\phantom{\Large X}}}]{\vspace*{7pt}\color{Orange}{\line(2,0){689}}\\ \textcolor{theGrey}{\normalfont  Grattan Institute 2016\phantom{\Large X}}}
\cfoot[\classification]{\classification}
\ofoot[\vspace*{7pt}\\ \textcolor{theGrey}{\normalfont  \thepage}]{\vspace*{7pt}\\ \textcolor{theGrey}{\normalfont  \thepage}}





\setkomafont{headsepline}{\color{white}}
%\setheadsepline{0pt}
\setkomafont{footsepline}{\color{white}}
%\setfootsepline{0pt}

\newcommand{\logoskip}{\par\vspace{16pt}}

\newcommand\acknowledgements[1]{\renewcommand\@acknowledgements{#1}}
\newcommand\@acknowledgements{}

\newcommand{\fulltitle}{\mytitle: \mysubtitle}

\newcommand*{\oursubtitle}[1]{\renewcommand\@mysubtitle{#1}}
\newcommand{\@mysubtitle}{Report subtitle}
 
\AtBeginDocument{%
\pagestyle{empty}
	\let\mytitle\@title
	\let\myauthor\@author
	\let\mysubtitle\@subtitle
	% TitlePage
	\onecolumn
	\AddToShipoutPicture*{\BackgroundPic}
	\phantom{.}\hfill\titleTH
	\ClearShipoutPicture
	\clearpage
	\twocolumn
	%
% Following page.
\pagestyle{scrheadings}
\begin{minipage}[t][0.8\textheight][t]{\columnwidth}
\vspace{-20pt}
  \subsection*{Grattan Institute Support}  
  \begin{multicols}{2}
  \setlength{\parskip}{4.0pt}
  \subsection*{\textcolor{theGrey}{Founding members}}
  
  \makebox[\linewidth][c]{\includegraphics[width=4cm]{./logos/aus-gov-logo-stacked-black}}
  \vfill
  \makebox[\linewidth][c]{\includegraphics[width=3.75cm]{./logos/Vic_Gov_Logo-2016-blue}}
  \vfill
  \makebox[\linewidth][c]{\includegraphics[width=3.75cm]{./logos/UOM-Pos_S_PMS}}
  \vfill%
  % Bhp original a little too much whitespace on bottom:
  \makebox[\linewidth][c]{\includegraphics[trim = {0 3.8cm 0 0}, clip, width=3.75cm]{./logos/Bhp}}%
  \columnbreak
  
  \subsection*{\textcolor{theGrey}{\normalsize Program support}}
  
  \footnotesize Higher Education
  \begin{center}
  \includegraphics[width=2.5cm]{./logos/TMF_logo_green.pdf}
  \end{center}
  \subsection*{\textcolor{theGrey}{\normalsize Affiliate Partners}}
  
  Google 

  Origin Foundation

  \subsection*{\textcolor{theGrey}{\normalsize Senior Affiliates}}

  EY

  PwC

  Stockland

  The Scanlon Foundation

  Wesfarmers
  
  \subsection*{\textcolor{theGrey}{\normalsize Affiliates}}

  Ashurst

  Corrs

  Deloitte

  Jacobs

  Mercy Health

  Sinclair Knight Merz

  Urbis

  Westpac
  \end{multicols}
  \end{minipage} 
  \eject \normalsize
  \begin{minipage}[t][0.8\textheight][t]{\columnwidth}
  \setlength{\parskip}{5.5pt plus 2pt}
  \vspace{-20pt}
  \subsection*{Grattan Institute Technical Report, March 2016}
  \raggedright\small
  \@acknowledgements
  \end{minipage}
  \twocolumn
}

% Table of contents

\setlength{\@fptop}{0pt}
\setlength{\@fpbot}{0pt plus 1fil}
\setkeys{Gin}{width=\columnwidth}

\RequirePackage{multicol}
\newlength{\currentparskip}

% Designing the overview
% ---
% We define a new environment that take as its contents the text of the 
% overview, placing it with a chapter* heading 'Overview' all on the same
% page. 
\newlength{\overviewextra} %% extra column separator
\newenvironment{overview}[1][]%
  {\onecolumn\vtop to 0pt\bgroup\vspace{#1}\chapter*{Overview}\begin{multicols}{2}%
  \setlength{\parskip}{7pt plus 1pt minus 1pt}}%
  {\end{multicols}\vss\egroup\hfill\twocolumn}
  
\newenvironment{summary}%
  {\onecolumn\vtop to 0pt\bgroup\vspace{-25pt}\chapter*{Summary}\begin{multicols}{2}}%
  {\end{multicols}\vss\egroup\hfill\twocolumn}
  
\newenvironment{onepager}[1]%  
  {\onecolumn\vtop to 0pt\bgroup\vspace{-25pt}\chapter*{#1}\begin{multicols}{2}}%
  {\end{multicols}\vss\egroup\hfill\twocolumn}


% Bibliography
\RequirePackage[english]{babel}
\RequirePackage{csquotes}
\RequirePackage[backend=biber,style=authoryear-ibid,ibidtracker=strict,
autocite=footnote]{biblatex}
\renewcommand*{\bibfont}{\raggedright}
\DeclareLanguageMapping{english}{british-apa}


%% Bibliography formatting
% separating entries
\setlength\bibitemsep{1.5\itemsep}
% space between p. 8 in postnote
\renewcommand*{\ppspace}{}
% format bibliography
\renewcommand*{\bibfont}{\small\raggedright}
\DeclareFieldFormat{url}{\url{#1}}

%% Bibliography formatting
% separating entries
\setlength\bibitemsep{1.5\itemsep}
% format bibliography
\renewcommand*{\bibfont}{\small}
\DeclareFieldFormat{url}{\url{#1}}

%% Citation tweaking
\DeclareFieldFormat{titlecase}{#1}
\setlength\bibhang{.5in}
\renewcommand*{\bibnamedash}{%
  \ifdimless{\leftmargin}{0.75em}
    {\mbox{\textemdash\space}}
    {\makebox[\leftmargin][l]{%
       \ifdimless{\leftmargin}{1.25em}
         {\textendash}
         {\rule{0.8\bibhang}{.2pt}}}}}
% Hyperlinks entire citation label for most citaiton commands 
% http://tex.stackexchange.com/questions/15951/hyperlink-name-with-biblatex-authoryear-biblatex-1-4b

\savebibmacro{cite}
\savebibmacro{textcite}

\renewbibmacro*{cite}{%
  \printtext[citehyperref]{%
    \restorebibmacro{cite}%
    \usebibmacro{cite}}}
    
\DeclareFieldFormat{textcitehyperref}{%
  \DeclareFieldAlias{bibhyperref}{noformat}% Avoid nested links
  \bibhyperref{%
    #1%
    \ifbool{cbx:parens}
      {\bibcloseparen\global\boolfalse{cbx:parens}}
      {}}}

%\DeclareFieldFormat{parens}{\mkbibparens{#1}}
%\renewbibmacro*{date}{\printtext[parens]{\printdate}}

\DeclareFieldFormat{citehyperref}{%
  \DeclareFieldAlias{bibhyperref}{noformat}% Avoid nested links
  \bibhyperref{#1}}

\DeclareFieldFormat{textcitehyperref}{%
  \DeclareFieldAlias{bibhyperref}{noformat}% Avoid nested links
  \bibhyperref{%
    #1%
    \ifbool{cbx:parens}
      {\bibcloseparen\global\boolfalse{cbx:parens}}
      {}}}
    
\renewbibmacro*{cite}{\printtext[citehyperref]{%
  \global\boolfalse{cbx:loccit}%
  \iffieldundef{shorthand}
    {\ifthenelse{\ifciteibid\AND\NOT\iffirstonpage}
       {\usebibmacro{cite:ibid}}
       {\ifthenelse{\ifnameundef{labelname}\OR\iffieldundef{labelyear}}
          {\usebibmacro{cite:label}%
           \setunit{\addspace}}
          {\printnames{labelname}%
           \setunit{\nameyeardelim}}%
        \usebibmacro{cite:paren:labelyear+extrayear}}}
    {\usebibmacro{cite:shorthand}}}}

\newbibmacro*{cite:paren:labelyear+extrayear}{%
  \iffieldundef{labelyear}
    {}
    {\printtext[parens]{%
       \printfield{labelyear}%
       \printfield{extrayear}}}}
       
\renewbibmacro*{textcite:postnote}{%
  \ifbool{cbx:parens}%
    {\bibcloseparen\global\boolfalse{cbx:parens}}%
    {}%
  \iffieldundef{postnote}%
    {}%
    {\savefield{namehash}{\cbx@lastyear}%
     \setunit{\postnotedelim}%
     \printfield{postnote}}%
  \ifthenelse{\value{multicitecount}=\value{multicitetotal}}%
    {}%
    {\textcitedelim}}% Not \multicitedelim ???

\renewbibmacro*{cite}{%
  \printtext[citehyperref]{%
    \restorebibmacro{cite}%
    \usebibmacro{cite}}}

\renewbibmacro*{textcite}{%
  \ifboolexpr{
    ( not test {\iffieldundef{prenote}} and
      test {\ifnumequal{\value{citecount}}{1}} )
    or
    ( not test {\iffieldundef{postnote}} and
      test {\ifnumequal{\value{citecount}}{\value{citetotal}}} )
  }
    {\DeclareFieldAlias{textcitehyperref}{noformat}}
    {}%
  \printtext[textcitehyperref]{%
    \restorebibmacro{textcite}%
    \usebibmacro{textcite}}}

% The following lines give the correct footcite Author (Year) but make the ibid erroneous
% Author (ibid) % use ifciteibid
\DeclareCiteCommand{\footcite}[\mkbibfootnote]
  {\boolfalse{cbx:parens}}
  {\usebibmacro{citeindex}%
  \ifciteibid{Ibid.}{%  % for ibidem
   \iffirstcitekey
     {\setcounter{textcitetotal}{1}}
     {\stepcounter{textcitetotal}%
      \textcitedelim}%
   \usebibmacro{textcite}}%
   }
  {\ifbool{cbx:parens}
     {\bibcloseparen\global\boolfalse{cbx:parens}}
     {}}
  {\usebibmacro{textcite:postnote}}
\newcommand{\gcite}[1]{{\citeauthor{#1} (\citedate{#1})}}


\RequirePackage{tocloft}
\renewcommand{\cftchapfont}{\normalsize}
\renewcommand{\cftchapdotsep}{.}
\renewcommand{\cftchappagefont}{\mdseries}
\AtBeginDocument{\renewcommand{\contentsname}{Table of contents}}
\newcommand{\contentspage}{%
\onecolumn
%\setcounter{tocdepth}{0}
\setcounter{tocdepth}{2}
\begin{multicols}{2}
%\phantom{.}
%\vfill
%\columnbreak
\tableofcontents
\end{multicols}
\clearpage
%\renewcommand\cftfigfont{\small}
%\renewcommand\cftfigpagefont{\small}
\renewcommand\cftfigafterpnum{\vskip-1.5pt\par}
\vspace*{-60pt}
\listoffigures
\twocolumn%
}

% continuous footnote numbering
\RequirePackage{chngcntr}
\counterwithout{footnote}{chapter}

% normal font size for footnote numbers
\usepackage{scrextend}
\deffootnote{1.5em}{1.6em}{\thefootnotemark.\enskip}