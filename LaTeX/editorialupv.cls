\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{editorialupv}[2013/01/21 Editorial de la Universitat Politècnica de València]
\LoadClass[10pt]{book}

% ------------------------------------------------------

\RequirePackage{ifthen}

% ------------------------------------------------------

\newcommand{\tipusPublicacio}{1} % 0: EPUB, 1: Llibre, 2: Tesi, 3: a4, 4: ebookpdf
\newcommand{\marquesTall}{0} % 0: none, 1: cross
\newcommand{\distanciesEquacions}{1}
\newcommand{\tipusLletra}{1} % 1: rm, 2: sf

\newboolean{valencia}\setboolean{valencia}{false}
\newboolean{castellano}\setboolean{castellano}{false}
\newboolean{english}\setboolean{english}{false}

\newcommand{\keywordsname}{Palabras clave}

\newcommand{\keywords}

% \newcommand{\keywords}[3]{%
%    \addto\captionscatalan{\def\keywords{#1}}
%    \addto\captionsspanish{\def\keywords{#2}}
%    \addto\captionsenglish{\def\keywords{#3}}}

\newenvironment{abstract}[1][castellano]{%
  \begingroup
    % \selectlanguage{#1}\addvspace{\baselineskip}\par\hfill
    \addvspace{\baselineskip}\par\hfill
    {\sffamily\bfseries\Huge\abstractname}\smallskip\par}{%
    \par\nopagebreak\noindent\textbf{\keywordsname:} \keywords\vspace*{3pt}{\color{gray}\hrule}
    \iflanguage{english}{\endgroup\makeindexes}{\endgroup\par\vspace{\stretch{1}}}}


% ------------------------------------------------------

\DeclareOption{EPUB}{\renewcommand{\tipusPublicacio}{0}}
\DeclareOption{llibre}{\renewcommand{\tipusPublicacio}{1}}
\DeclareOption{tesi}{\renewcommand{\tipusPublicacio}{2}}
\DeclareOption{a4}{\renewcommand{\tipusPublicacio}{3}}
\DeclareOption{ebookpdf}{\renewcommand{\tipusPublicacio}{4}}

\DeclareOption{no-crop}{\renewcommand{\marquesTall}{0}}
\DeclareOption{crop}{\renewcommand{\marquesTall}{1}}
% Per compatibilitat
\DeclareOption{croscrop}{\renewcommand{\marquesTall}{1}}
\DeclareOption{nocrop}{\renewcommand{\marquesTall}{0}}

\DeclareOption{rm}{\renewcommand{\tipusLletra}{1}}
\DeclareOption{sf}{\renewcommand{\tipusLletra}{2}}

\DeclareOption{nomathskip}{\renewcommand{\distanciesEquacions}{0}}

\DeclareOption{ebookpdf}{\renewcommand{\tipusPublicacio}{4}}

\DeclareOption{valencia}{%
	\setboolean{valencia}{true}
	\setboolean{castellano}{false}
	\setboolean{english}{false}
	}
\DeclareOption{castellano}{%
	\setboolean{valencia}{false}
	\setboolean{castellano}{true}
	\setboolean{english}{false}
	}
\DeclareOption{english}{%
	\setboolean{valencia}{false}
	\setboolean{castellano}{false}
	\setboolean{english}{true}
	}


% ------------------------------------------------------

\DeclareOption*{\ClassWarning{editorialupv}{No podem processar l'opci\'{o}: ?\CurrentOption?}}

% ------------------------------------------------------

\ExecuteOptions{llibre,rm,nocrop,castellano}
\ProcessOptions\relax


% ------------------------------------------------------
% Comprovem si s'està executant htlatex

\newboolean{EPUB}
\newboolean{EBOOKPDF}
\newboolean{Aquatre}
\newboolean{LLIBRE}
\newboolean{TESI}

\ifdefined\HCode % S'ha executat htlatex
	\renewcommand{\tipusPublicacio}{0}
	\setboolean{EPUB}{true}
\else % S'ha executat pdflatex o latex
	\setboolean{EPUB}{false}
	\ifnum\tipusPublicacio = 0 % Es canvia a llibre si està seleccionat EPUB
		\renewcommand{\tipusPublicacio}{1}
	\fi
\fi

\ifnum\tipusPublicacio = 1
	\setboolean{LLIBRE}{true}
\else
	\setboolean{LLIBRE}{false}
\fi	

\ifnum\tipusPublicacio = 2
	\setboolean{TESI}{true}
\else
	\setboolean{TESI}{false}
\fi	

\ifnum\tipusPublicacio = 3
	\setboolean{Aquatre}{true}
\else
	\setboolean{Aquatre}{false}
\fi	

\ifnum\tipusPublicacio = 4
	\setboolean{EBOOKPDF}{true}
\else
	\setboolean{EBOOKPDF}{false}
\fi	

% ------------------------------------------------------

\RequirePackage{graphicx}
\RequirePackage{calc}
%\RequirePackage{hyperref}

% ------------------------------------------------------

% \DeclareOption{catalan}{\PassOptionsToPackage{english,spanish,main=catalan}{babel}}
% \DeclareOption{spanish}{\PassOptionsToPackage{english,catalan,main=spanish}{babel}}
% \DeclareOption{english}{\PassOptionsToPackage{spanish,catalan,main=english}{babel}}
% 
% \newenvironment{abstract}[1][spanish]{%
%   \begingroup
%   \selectlanguage{#1}\addvspace{\baselineskip}\par\hfill
%   {\sffamily\bfseries\Huge\abstractname}\smallskip\par}{%
%   \par\nopagebreak\noindent\textbf{\keywordsname:} \keywords\vspace*{3pt}\hrule
%   \iflanguage{english}{\endgroup\makeindexes}{\endgroup\par\vspace{\stretch{1}}}}

\newcommand{\tutor}[1]{\newcommand{\t@tor}{#1}}
\newcommand{\curs}[1]{\newcommand{\c@rs}{#1}}

\newcommand{\titulacioname}{Grado en Ingeniería Informática}
\newcommand{\tfgname}{Trabajo Fin de Grado}

\newcommand{\authorname}{Autor}
\newcommand{\tutorname}{Tutor}
\newcommand{\coursename}{Curso}


\ifnum\tipusPublicacio = 1 % Llibre
  \renewcommand\maketitle{
  \begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \begin{center}%
  \vskip 400\p@
  {EDITORIAL\\UNIVERSITAT POLIT\`ECNICA DE VAL\`ENCIA}
  \vskip -500\p@
	\rule{\textwidth}{1pt}\par
    \vskip 1.5em%
    {\Huge\bfseries \@title \par}%
    \vskip 1.5em%
	\rule{\textwidth}{1pt}\par    
    {\large
     \lineskip .75em%
	  \vskip 60\p@     
      \begin{tabular}[t]{c}%
        \@author\par
      \end{tabular}\par}%
	  \vskip 60\p@     
%    {\large \@date \par}%       % Set date in \large size.
%  \@thanks
  \vfil\null
  \end{center}\par
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\fi

\RequirePackage{xcolor}
\definecolor{grisclar}{gray}{0.5}
\definecolor{grisfosc}{gray}{0.25}

\ifnum\tipusPublicacio = 2 % Tesi
  \renewcommand\maketitle{
  \begin{titlepage}

  \AddToShipoutPicture*{\AtPageUpperLeft{%
    % Marges: dalt=esquerra=dreta=2cm 
    \raisebox{-4cm}{\hspace{2cm}\includegraphics[height=1.85cm]{./logos/logo-upv}% grandÃ ria 116mmx37mm escalada a 62.7mmx20mm
    % \hspace{5.54cm}% 21cm-(2+6.27+5.19+2)cm
    \hspace{2.7cm}% 21cm-(2+6.27+5.19+2)cm
      \includegraphics[height=1.85cm]{logo-etsinf}% grandària 109mmx42mm escalada a 51.9mmx20mm
     }}}

  \AddToShipoutPicture*{\includegraphics[width=21cm,height=12.89cm]{./logos/baseportada}}
  \centering
  \vspace*{2cm}
  \begin{color}{grisfosc}
  \large
  Escola Tècnica Superior d'Enginyeria Informàtica
  
  Universitat Politècnica de Valencia
  \end{color}
  \vspace{\stretch{1}}
  
  \LARGE\bfseries\@title
  
  \normalsize\scshape\textcolor{grisfosc} \tfgname

  \par\vspace{0.2cm}\par
  \normalfont\textcolor{grisclar}{\titulacioname}
  
  \vspace{\stretch{2}}
  
  % Autor, tutor y fecha
  \begin{flushright} 
  \begin{tabular}{l}
     \textit{\authorname:} \begin{tabular}[t]{l}\@author\end{tabular}\\[0.2cm]
     \textit{\tutorname:} \begin{tabular}[t]{l}\t@tor\end{tabular}
  \end{tabular}
  \medskip
  
  \coursename\space\c@rs
  \end{flushright}
  \end{titlepage}}

%%   \begin{titlepage}%
%%   \let\footnotesize\small
%%   \let\footnoterule\relax
%%   \let \footnote \thanks
%%   \null\vfil
%%   \begin{center}%
%%   \vskip -100\p@
%%   {\includegraphics[width=6.0cm]{./logos/UPV_horitzontal}}
%%   \vskip 100\p@
%% 	\rule{\textwidth}{1pt}\par
%%     \vskip 1.5em%
%%     {\Huge\bfseries \@title \par}%
%%     \vskip 1.5em%
%% 	\rule{\textwidth}{1pt}\par    
%%     {\large
%%      \lineskip .75em%
%% 	  \vskip 60\p@     
%%       \begin{tabular}[t]{c}%
%%         \@author
%%       \end{tabular}\par}%
%% 	  \vskip 60\p@     
%% %    {\large \@date \par}%       % Set date in \large size.
%% %  \@thanks
%%   \vfil\null
%%   \end{center}\par
%%   \end{titlepage}%
%%   \setcounter{footnote}{0}%
%%   \global\let\thanks\relax
%%   \global\let\maketitle\relax
%%   \global\let\@thanks\@empty
%%   \global\let\@author\@empty
%%   \global\let\@date\@empty
%%   \global\let\@title\@empty
%%   \global\let\title\relax
%%   \global\let\author\relax
%%   \global\let\date\relax
%%   \global\let\and\relax
%% }
\fi

\ifnum\tipusPublicacio = 4 % ebookpdf
  \renewcommand\maketitle{
%  \begin{titlepage}% Si la comentem compta com a pàgina del PDF
  \thispagestyle{plain}
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks
  \null\vfil
  \begin{center}%
  \vskip 355\p@
  \includegraphics[width=4.0cm]{./logos/UPV_horitzontal}\\[-.25cm]
  \rule{4cm}{0.25pt}\\
  {\sffamily\scriptsize\bfseries EDITORIAL}
  \vskip -415\p@
	\rule{\textwidth}{1pt}\par
    \vskip 1.5em%
    {\Huge\bfseries \@title \par}%
    \vskip 1.5em%
	\rule{\textwidth}{1pt}\par    
    {\large
     \lineskip .75em%
	  \vskip 40\p@     
      \begin{tabular}[t]{c}%
        \@author\par
      \end{tabular}\par}%
	  \vskip 60\p@     
%    {\large \@date \par}%       % Set date in \large size.
%  \@thanks
  \vfil\null
  \end{center}\par
%  \end{titlepage}%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
  \clearpage
}
\fi


% ---------------------------------------------------------------------
% Tipo de letra

\ifnum\tipusPublicacio = 4 % ebookpdf

	\renewcommand{\familydefault}{\rmdefault}
	\renewcommand{\normalsize}{\fontsize{12pt}{14pt}\selectfont}

\else\ifnum\tipusPublicacio = 3 % a4

	\renewcommand{\normalsize}{\fontsize{11pt}{13pt}\selectfont}
	
\else\ifnum\tipusPublicacio = 1 % llibre

	\renewcommand{\normalsize}{\fontsize{10pt}{12pt}\selectfont}
	
\fi\fi\fi

\ifnum\tipusLletra = 2 % sf
	\renewcommand{\familydefault}{\sfdefault}
\else % 1 rm
	\renewcommand{\familydefault}{\rmdefault}
\fi
	

% ---------------------------------------------------------------------
% Formato de página

\RequirePackage{geometry}

\ifnum\tipusPublicacio = 4 % ebookpdf
	
	\geometry{
		twoside = false,
		body={4.75in,6.6in},
		hmarginratio=1:1,
		includeheadfoot,
%		paperwidth = 5.5in,
%		paperheight = 7.5in,
		paperheight=7.60606060in,
   		paperwidth=5.8181818in,
   		vmargin={0cm},
   		headsep = 1.25cm,	
		}

\else\ifnum\tipusPublicacio = 3 % a4
	
	\geometry{ 
		a4paper, twoside,         	% A4 a doble cara
		hmargin = {3.0cm, 2.25cm}, 	% {Izquierdo, Derecho}
		vmargin = {1.25cm, 1.25cm}, % {Superior, Inferior} 
		includehead, includefoot, 	% Incluyendo encabezado y pie
		headsep = 1.5cm,          	% Separación entre el encabezado y el texto
		footskip = 2.0cm,        	% Separación entre el texto y el pie
		}

\else\ifnum\tipusPublicacio = 0 % EPUB

% No res

\else % llibre o tesi

	\newlength{\sangratMarques}

	\ifnum\marquesTall = 1
 		\setlength{\sangratMarques}{3mm}
	\else
 		\setlength{\sangratMarques}{0mm}
	\fi	
		
	\newlength{\amplePublicacio}
	\setlength{\amplePublicacio}{17cm + 2\sangratMarques}
	
	\newlength{\alcadaPublicacio}
	\setlength{\alcadaPublicacio}{24cm + 2\sangratMarques}
	
	\newlength{\margeVerticalSuperior}
	\setlength{\margeVerticalSuperior}{2cm + \sangratMarques}

	\newlength{\margeVerticalInferior}
	\setlength{\margeVerticalInferior}{2cm + 12pt + \sangratMarques}
	
	\newlength{\margeInterior}
	\setlength{\margeInterior}{2.5cm + \sangratMarques}

	\geometry{ 
		twoside,
		vmargin = {\margeVerticalSuperior, \margeVerticalInferior}, 
		includehead,
		left = \margeInterior,
		headheight = 0.5cm,	
		headsep = 0.5cm,
		footskip = 12pt,
		textwidth = 12.5cm, %totalheight = 20cm, % Caja de texto 13cm x 21 cm
		paperwidth = \amplePublicacio, paperheight = \alcadaPublicacio,
		}

	% --------------------------------------------
	% Marques de tall
	
	\ifnum\marquesTall = 1
		\usepackage[cross, a4, center, odd, noinfo]{crop}
	\fi

\fi\fi\fi


% ---------------------------------------------------------------------
% Encabezados y pies de página

\RequirePackage{fancyhdr}
\pagestyle{fancy}

\renewcommand{\chaptermark}[1]{\markboth{\@chapapp\ \thechapter.\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}{}}

\fancyhead{} % Esborra la configuració de la capçalera
\fancyfoot{} % Esborra la configuració del peu


\ifnum\tipusPublicacio = 3 % a4

	\fancyhead{} 
	\fancyhead[LE]{\small\itshape\nouppercase\leftmark}
	\fancyhead[RO]{\small\itshape\nouppercase\rightmark}

	\fancyfoot{} 
	\fancyfoot[LE,RO]{\thepage}

	\renewcommand{\headrulewidth}{0.25pt}
	\renewcommand{\footrulewidth}{0.25pt}

\fi

\ifnum\tipusPublicacio = 1 % llibre

	\newlength{\myevenheadlinehoffset}\setlength{\myevenheadlinehoffset}{-2.0cm-\sangratMarques}
	\newlength{\myevenheadtexthoffset}\setlength{\myevenheadtexthoffset}{2.0cm+\sangratMarques}
	\newlength{\myoddheadlinehoffset}\setlength{\myoddheadlinehoffset}{13.5cm+\sangratMarques}
	\newlength{\myoddheadlinewidth}\setlength{\myoddheadlinewidth}{14.5cm+\sangratMarques}
	\newlength{\myevenheadlinewidth}\setlength{\myevenheadlinewidth}{14.5cm+0.1cm+\sangratMarques}

	\fancyhead[LE]{%
		\hspace*{\myevenheadlinehoffset}\makebox[0cm][l]{\rule[-2mm]{\myevenheadlinewidth}{.25pt}}%
		\hspace*{\myevenheadtexthoffset}{\footnotesize\itshape\nouppercase\leftmark}%
		}
	\fancyhead[LO]{%
		\makebox[0cm][l]{\rule[-2mm]{\myoddheadlinewidth}{.25pt}}%
		\makebox[12.5cm][r]{\footnotesize\itshape\nouppercase\rightmark}%
		}
	
	\newlength{\myevenfootlinehoffset}\setlength{\myevenfootlinehoffset}{-2.0cm-\sangratMarques}
	\newlength{\myoddfootlinehoffset}\setlength{\myoddfootlinehoffset}{13.5cm}
	\newlength{\myfootlinewidth}\setlength{\myfootlinewidth}{1cm+\sangratMarques}
	
	\fancyfoot[LE]{\hspace*{\myevenfootlinehoffset}\makebox[0cm][l]{\rule[2.5ex]{\myfootlinewidth}{.25pt}}%
	%	\setlength{\fboxsep}{0pt}\fbox
		{\makebox[\myfootlinewidth][r]{\thepage}}}
	\fancyfoot[LO]{\hspace*{\myoddfootlinehoffset}\makebox[0cm][l]{\rule[2.5ex]{\myfootlinewidth}{.25pt}}%
	%	\setlength{\fboxsep}{0pt}\fbox
		{\makebox[\myfootlinewidth][l]{\thepage}}}


	% Pie de página de la primera página del capítulo
	
	\fancypagestyle{plain}{% 
	    \fancyhf{} % clear all header and footer fields 
		\fancyfoot[LO]{\hspace*{\myoddfootlinehoffset}\makebox[0cm][l]{\rule[2.5ex]{\myfootlinewidth}{.25pt}}%
	%		\setlength{\fboxsep}{0pt}\fbox
			{\makebox[\myfootlinewidth][l]{\thepage}}}
%	    \renewcommand{\headrulewidth}{0pt} 
%	    \renewcommand{\footrulewidth}{0pt}
	}

	\renewcommand{\headrulewidth}{0.0pt}
	\renewcommand{\footrulewidth}{0.0pt}

\fi

\ifnum\tipusPublicacio = 2 % tesi

	\setlength{\sangratMarques}{0pt} % Per a que no arribe fins al final del full

	\newlength{\myevenheadlinehoffset}\setlength{\myevenheadlinehoffset}{-2.0cm-\sangratMarques}
	\newlength{\myevenheadtexthoffset}\setlength{\myevenheadtexthoffset}{2.0cm+\sangratMarques}
	\newlength{\myoddheadlinehoffset}\setlength{\myoddheadlinehoffset}{13.5cm+\sangratMarques}
	\newlength{\myoddheadlinewidth}\setlength{\myoddheadlinewidth}{14.5cm+\sangratMarques}
	\newlength{\myevenheadlinewidth}\setlength{\myevenheadlinewidth}{14.5cm+0.1cm+\sangratMarques}

	\fancyhead[LE]{%
		\hspace*{\myevenheadlinehoffset}\makebox[0cm][l]{\rule[-2mm]{\myevenheadlinewidth}{.25pt}}%
		\hspace*{\myevenheadtexthoffset}{\footnotesize\itshape\nouppercase\leftmark}%
		}
	\fancyhead[LO]{%
		\makebox[0cm][l]{\rule[-2mm]{\myoddheadlinewidth}{.25pt}}%
		\makebox[12.5cm][r]{\footnotesize\itshape\nouppercase\rightmark}%
		}
	
	\newlength{\myevenfootlinehoffset}\setlength{\myevenfootlinehoffset}{-2.0cm-\sangratMarques}
	\newlength{\myoddfootlinehoffset}\setlength{\myoddfootlinehoffset}{13.5cm}
	\newlength{\myfootlinewidth}\setlength{\myfootlinewidth}{1cm+\sangratMarques}
	
	\fancyfoot[LE]{\hspace*{\myevenfootlinehoffset}\makebox[0cm][l]{\rule[2.5ex]{\myfootlinewidth}{.25pt}}%
	%	\setlength{\fboxsep}{0pt}\fbox
		{\makebox[\myfootlinewidth][r]{\thepage}}}
	\fancyfoot[LO]{\hspace*{\myoddfootlinehoffset}\makebox[0cm][l]{\rule[2.5ex]{\myfootlinewidth}{.25pt}}%
	%	\setlength{\fboxsep}{0pt}\fbox
		{\makebox[\myfootlinewidth][l]{\thepage}}}


	% Pie de página de la primera página del capítulo
	
	\fancypagestyle{plain}{% 
	    \fancyhf{} % clear all header and footer fields 
		\fancyfoot[LO]{\hspace*{\myoddfootlinehoffset}\makebox[0cm][l]{\rule[2.5ex]{\myfootlinewidth}{.25pt}}%
	%		\setlength{\fboxsep}{0pt}\fbox
			{\makebox[\myfootlinewidth][l]{\thepage}}}
%	    \renewcommand{\headrulewidth}{0pt} 
%	    \renewcommand{\footrulewidth}{0pt}
	}

	\renewcommand{\headrulewidth}{0.0pt}
	\renewcommand{\footrulewidth}{0.0pt}

\fi


\ifnum\tipusPublicacio = 4 % ebookpdf

	\newlength{\hMargins}
	\setlength{\hMargins}{\paperwidth-\textwidth}
	\newlength{\hMargin}
	\setlength{\hMargin}{0.5\hMargins}
	\newlength{\posPagina}
	\setlength{\posPagina}{\textwidth + 0.5\hMargin}

	\RequirePackage{lastpage}
	\RequirePackage{xcolor}
	\RequirePackage{tikz}
	
	\definecolor{grisUPV}{HTML}{313233}
	\definecolor{grisCLARET}{HTML}{EEEEEE}
	
	\renewcommand{\chaptermark}[1]{\markboth{\@chapapp\ \thechapter.\ #1}{}}

	\fancyhf{} % 
	\fancyhead[L]{%
		\begin{tikzpicture}[overlay]
			\draw[fill=grisUPV] (-\hMargin,2ex) rectangle ++(\paperwidth,-1.0cm);
			\node[right] (leftMark) at (-0.75\hMargin,0) {\color{grisCLARET}\sffamily\mdseries\scriptsize\leftmark};
			\node[right] (rightMark) at (-0.5\hMargin,-2ex) {\color{grisCLARET}\sffamily\mdseries\scriptsize\rightmark};
			\node[] (thePage) at (\posPagina,-1ex) {\color{grisCLARET}\sffamily\small\thepage/\pageref*{LastPage}};
		\end{tikzpicture}
		}

	\fancypagestyle{plain}{% 
	\fancyhf{} % clear all header and footer fields 
	\fancyhead[L]{%
		\begin{tikzpicture}[overlay]
			\draw[fill=grisUPV] (-\hMargin,2ex) rectangle ++(\paperwidth,-1.0cm);
			\node[] (thePage) at (\posPagina,-1ex) {\color{grisCLARET}\sffamily\small\thepage/\pageref*{LastPage}};
		\end{tikzpicture}
		}}
	
	\renewcommand{\headrulewidth}{0.0pt}
	\renewcommand{\footrulewidth}{0.0pt}
	
	\renewcommand{\frontmatter}{}
	\renewcommand{\mainmatter}{}
	
\fi


% ---------------------------------------------------------------------
% Formato de párrafo y maquetación

\if\tipusPublicacio = 3

	\setlength{\parskip}{3ex}
	\setlength{\parindent}{0pt}

\else

	\setlength{\parskip}{2ex}
	\setlength{\parindent}{0ex}

\fi

\linespread{1.0}

\setlength{\widowpenalty}{10000pt}
\setlength{\clubpenalty}{10000pt}

\raggedbottom


% ---------------------------------------------------------------------
% Mojora los títulos de las figuras y tablas

\RequirePackage{caption}
\renewcommand{\captionlabelfont}{\bfseries\small}
\renewcommand{\captionfont}{\small}

% ------------------------------------------------------------------------
% Formato de las secciones

\RequirePackage[
	raggedright,
	compact,
	nobottomtitles*, % Evita que queden títols solts al final de la pàgina
	clearempty, % Modifica \cleardoublepage per a que els fulls parells buides siguen blanques
	]{titlesec}

  \usepackage{etoolbox}

  \makeatletter
  \patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}
  \patchcmd{\ttlh@hang}{\noindent}{}{}{}
  \makeatother

% ------------------------------------------------------------------------

\titleformat{\part}
	[display]
	{\thispagestyle{empty}\normalfont\bfseries\filcenter
	\tolerance=10000\hyphenpenalty=10000}
	{\huge
	\partname\enspace\thepart
	}
	{1pc}
	{\Huge}


% ------------------------------------------------------------------------
%
%\titleformat{\chapter}
%	[display]
%	{\normalfont\Large\filcenter	}
%	{
%		\titlerule[1pt]
%		\vspace{1pt}
%		\titlerule
%		\vspace{1pc}
%		\LARGE\chaptertitlename\enspace\thechapter
%	}
%	{1pc}
%	{
%		\titlerule
%		\vspace{1pc}
%		\fontsize{24}{26}\bfseries%\usefont{T1}{cmss}{n}{n}\selectfont
%	}


\ifnum\tipusPublicacio = 3 % a4

	% ------------------------------------------------------------------------
	
	\titleformat{\section}
		[hang]
		{\vspace{2ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
		{\Large\bfseries\thesection}
		{1em}
		{\Large\bfseries}
	
	% ------------------------------------------------------------------------
	
	\titleformat{\subsection}
		[hang]
		{\vspace{1.5ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
		{\large\bfseries\thesubsection}
		{1em}
		{\large\bfseries}
		[\vspace{-1ex}]
	

\else\ifnum\tipusPublicacio = 4 % E-book en formato PDF

	% ------------------------------------------------------------------------
	
	\titleformat{\section}
		[hang]
		{\vspace{2ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
		{\fontsize{15}{17}\bfseries\thesection}
		{1em}
		{\fontsize{15}{17}\bfseries}
	
	% ------------------------------------------------------------------------
	
	\titleformat{\subsection}
		[hang]
		{\vspace{1.5ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
		{\fontsize{13}{15}\bfseries\thesubsection}
		{1em}
		{\fontsize{13}{15}\bfseries}
		[\vspace{-1ex}]


\else % Llibre o tesi

	% ------------------------------------------------------------------------
	
	\titleformat{\section}
		[hang]
		{\vspace{2ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
		{\fontsize{13}{15}\bfseries\thesection}
		{1em}
		{\fontsize{13}{15}\bfseries}
	
	% ------------------------------------------------------------------------
	
	\titleformat{\subsection}
		[hang]
		{\vspace{1.5ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
		{\fontsize{11}{13}\bfseries\thesubsection}
		{1em}
		{\fontsize{11}{13}\bfseries}
		[\vspace{-1ex}]
	
\fi\fi


% ------------------------------------------------------------------------

\titleformat{\subsubsection}
	[hang]
	{\vspace{2ex}\raggedright\tolerance=10000\hyphenpenalty=10000}
	{\normalsize\itshape\bfseries\thesubsubsection}
	{1em}
	{\normalsize\itshape\bfseries}
	[\vspace{-0.75ex}]

% -------------------------------------------------------
% Para controlar la numeración y formato de la tabla de contenidos

\RequirePackage{titletoc}

\titlecontents{part} 
	[0em] 
	{\addvspace{4ex}\Large} 
	{\partname\enspace\thecontentslabel\enspace} 
	{} 
	{\hfill\contentspage} 
	[\vspace{-1ex}]
	
\titlecontents{chapter} 
	[0em] 
	{\addvspace{3ex}\mdseries\large} 
	{\thecontentslabel\enspace} 
	{} 
	{\hfill\contentspage}
	[\vspace{-1ex}]
	
\titlecontents{section} 
	[1.5em] 
	{\addvspace{.5ex}\small} 
	{\thecontentslabel\enspace} 
	{} 
	{\titlerule*[0.5pc]{.}\contentspage} 
	[\vspace{-1.5ex}]	
	
\titlecontents{subsection} 
	[3.5em] 
	{\vspace{.25ex}\footnotesize}
	{\thecontentslabel\enspace} 
	{} 
	{\titlerule*[0.5pc]{.}\contentspage} 
	[\vspace{-1.5ex}]



% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------


\ifEPUB
	\setlength{\partopsep}{-1ex plus 1ex minus 0ex} % Configurat per enumitem
	
	% ------------------------------------------------------
	% Compatibilitat tex4ht - biblatex
	% Gener de 2013
	
	\makeatletter
	\ifdefined\blx@unitmark
	\else
		\newcommand\blx@unitmark{23sp}
	\fi
	\makeatother		

\else
	\RequirePackage{enumitem}
	\setlist[1]{partopsep=-1ex,parsep=\parskip,itemsep=0\parskip}
	\setlist[2]{partopsep=-1ex,parsep=\parskip,itemsep=0\parskip}
\fi


\makeatletter
\let\ifes@LaTeXe\iftrue % Per a la compatibilitat amb babel des de htlatex
\makeatother

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------

\RequirePackage{mathtools}

\ifnum\distanciesEquacions=1
\AtBeginDocument
	{
	% ---------------------------------------------------
	% Distàncies de les equacions al text
	
	% Per a les equacions normals
	\abovedisplayshortskip = -1.0ex plus 0ex minus 0.25ex
	\belowdisplayshortskip = 2.0ex plus 1ex minus 0.0ex
	
	% Per a les equacions en varies línies
	\abovedisplayskip = -1.0ex plus 0ex minus 0.25ex
	\belowdisplayskip = 2.0ex plus 1ex minus 0.0ex
	}
\fi

% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
% ------------------------------------------------------------------------
