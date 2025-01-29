\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reyesThesis}

%Conditionals

\newif\if@spanish\@spanishtrue
\newif\if@draft\@draftfalse



%Options

\DeclareOption{spanish}{
	\PassOptionsToPackage{USenglish, \CurrentOption, es-tabla}{babel}
}
\DeclareOption{english}{
	\PassOptionsToPackage{USenglish}{babel}
	\@spanishfalse
}
\newcommand{\classSelected}{report}
\DeclareOption{article}{\renewcommand{\classSelected}{article}
}
\DeclareOption{draft}{\@drafttrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\classSelected}}

\ExecuteOptions{spanish}
\ProcessOptions\relax
\LoadClass{\classSelected}



%Language packages
\RequirePackage{babel}
\RequirePackage[latin1, utf8]{inputenc}

%Other packages
\RequirePackage{amsmath, amssymb}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{physics}
\RequirePackage{tikz}
\usetikzlibrary{calc,intersections,through,backgrounds}
\RequirePackage[explicit]{titlesec}

\RequirePackage[]{appendix}

\RequirePackage{geometry}
\geometry{
 left=20mm,
 right=20mm,
 bottom=33mm,
 top=40mm,
 }

%headers and footers

\RequirePackage{fancyhdr}
\RequirePackage{color}

\pagestyle{fancy}
\fancyhf{}
%\rhead{\textcolor{UVpink}{\rightmark}}
\lhead{\textcolor{UVpink}{\leftmark}}
\rfoot{\textcolor{UVpink}{\insertauthor}}
\cfoot{\thepage}

\renewcommand{\headrulewidth}{0pt}

\renewcommand{\footrulewidth}{2pt}
\futurelet\TMPfootrule\def\footrule{{\color{UVred}\TMPfootrule}}
%%

%fields
\def\author#1{\gdef\insertauthor{#1}\gdef\@author{#1}}
\def\title#1{\gdef\inserttitle{#1}\gdef\@title{#1}}
\def\titleen#1{\gdef\inserttitleen{#1}\gdef\@titleen{#1}}
\def\supervisor#1{\gdef\insertsupervisor{#1}}
\def\institution#1{\gdef\insertinstitution{#1}}
\def\degree#1{\gdef\insertdegree{#1}}
\def\faculty#1{\gdef\insertfaculty{#1}}
\def\department#1{\gdef\insertdepartment{#1}}
\def\submitdate#1{\gdef\insertsubmitdate{#1}}

%New commands
\newcommand\titlepagedecoration{
\begin{tikzpicture}[remember picture,overlay,shorten >= -10pt]

\coordinate (NW) at (current page.north west);
\coordinate (NE) at (current page.north east);
\coordinate (SE) at (current page.south east);
\coordinate (SW) at (current page.south west);

\coordinate (midL) at ([yshift=-220]current page.north west);
\coordinate (midR) at ([yshift=-220]current page.north east);
 
\path [fill=UVpink] (midR) -- coordinate (A) ($ (midL) + (0,3.6)$) -- (NW) -- (NE) -- (midR);
\path [fill=UVred] (midL) -- coordinate (B) ($ (midR) + (0,3.6)$) -- (NE) -- (NW) -- (midL);


\node[inner sep=0pt] (logo) at ($0.5*(NW)+0.5*(NE)+(0,-2.8)$) {\includegraphics[scale=0.03]{logo.png}};


\end{tikzpicture}
}

\titleformat{\chapter}[display]
  {\usefont{T1}{qcs}{b}{n}\selectfont}
  {%
  \begin{tikzpicture}[remember picture, overlay]
 	\path [fill=UVred] (midL) -- ($ (midR) + (0,3.6)$) -- (NE) -- (NW) -- (midL);
	\draw[color=UVpink] (15.5cm,1cm) node {\textit{{\fontsize{150}{60}\selectfont\thechapter}}};
  \end{tikzpicture}%
}
  {20pt}
  {\filleft\Huge\rmfamily{\textcolor{UVred}{\scshape{#1}}}}[]

\titleformat{\section}[hang]{\rmfamily\color{UVred}\bfseries\scshape}{}{5pt}{\Large \thesection \quad #1}[]
\titleformat{\subsection}[hang]{\rmfamily\color{UVred}\bfseries\scshape}{}{5pt}{\large \textcolor{UVpink}{\thesubsection} \quad #1}[]


\newcommand{\beq}{\begin{equation}}
\newcommand{\eeq}{\end{equation}}
\newcommand{\beqa}{\begin{eqnarray}}
\newcommand{\eeqa}{\end{eqnarray}}
\newcommand{\nn}{\nonumber}
\newcommand{\mb}{\mathbf}
\newcommand{\rred}{\textcolor{red}}
\newcommand{\bblue}{\textcolor{blue}}
\newcommand{\purp}{\textcolor{violet}}

\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\hc}{h.c.}

\newenvironment{abstractpage}
  {\cleardoublepage\vspace*{\fill}\thispagestyle{empty}}
  {\vfill\cleardoublepage}
\renewenvironment{abstract}[1]
  {\bigskip\selectlanguage{#1}%
   \begin{center}\bfseries\large \textcolor{UVred}{\abstractname}\end{center}}
  {\par\bigskip}

\newenvironment{acknowledgements}[1]
  {\bigskip\selectlanguage{#1}%
   {\bfseries\large \textcolor{UVred}{Agradecimientos}} \\ \\}
  {\par\bigskip}

\newenvironment{publications}[1]
  {\bigskip\selectlanguage{#1}%
   {\bfseries\large \textcolor{UVred}{Publications} \\ \\}}
  {\par\bigskip}



%% title page building blocks
\renewenvironment{titlepage}%
	{\let\ez@blockfill\relax
	 \thispagestyle{empty}\centering\null\vskip1in}
	{\vskip.5in\newpage}

\newcommand{\TitleBlock}[2][\ez@blockfill]{#1{#2\par}\let\ez@blockfill\vfill}


%colors

\if@draft
	\definecolor{UVred}{RGB}{74, 74, 74}
	\definecolor{UVpink}{RGB}{130, 130, 130}
\else
	\definecolor{UVred}{RGB}{188, 13, 21}
	\definecolor{UVpink}{RGB}{239, 102, 109}
\fi

%links

\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true,
	citecolor=UVpink,
    linkcolor=UVred,
	urlcolor = UVred,
	bookmarks = true
}









