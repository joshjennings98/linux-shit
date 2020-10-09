/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int gappx     = 12;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixels */
static const int user_bh            = 52;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int vertpad            = 12;       /* vertical padding of bar */
static const int sidepad            = 12;       /* horizontal padding of bar */
static const char *fonts[]          = { "FontAwesome:size=24", "Iosevka:size=24" };
static const char dmenufont[]       = "Iosevka:size=35";
static const char col_gray1[]       = "#111111";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#888888";
static const char col_gray4[]       = "#dddddd";
static const char col_black[]       = "#000000";
static const char col_red[]         = "#cc0000";
static const char col_border[]      = "#888888"; // "#bb00bb";
static const char col_yellow[]      = "#ffff00";
static const char width[]           = "1000";
static const char xoff[]            = "868";
static const char yoff[]            = "564";
static const char lines[] 	    = "10";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray1 },
	[SchemeSel]  = { col_gray4, col_gray1,  col_border  }, // gray2
	[SchemeStatus]={ col_gray4, col_gray1, col_gray2 },
};

/* tagging */
static const char *tags[] = { "" , "", "", "", };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Code",     NULL,       NULL,       1 << 2,       0,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 1,       0,           -1 },
	{ "Steam",    NULL,       NULL,       1 << 3,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "",      tile },    /* first entry is default */
	{ "",      NULL },    /* no layout function means floating behavior */
	{ "   (0)",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenudesktop[] = { "/home/josh/dmenu/dmenu-desktop", NULL }; // "-dmenu='dmenu", "-p", "Search:", "-l", lines, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_gray1, "-sf", col_gray4, "-w", width, "-x", xoff, "-y", yoff, "'", NULL };
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-p", "Search:", "-l", lines, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_gray1, "-sf", col_gray4, "-w", width, "-x", xoff, "-y", yoff, NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *statusmenu[] = { "/bin/bash", "/home/josh/dwm/statusMenu.sh", NULL };
static const char *powermenu[] = { "/bin/bash", "/home/josh/dwm/powerMenu.sh", NULL };
static const char *lock[] = { "slock", NULL };
static const char *togglesound[] = { "/bin/bash", "/home/josh/dwm/toggleVolume.sh", NULL };
static const char *volup[] = { "amixer", "set", "Master", "1%+", NULL };
static const char *voldown[] = { "amixer", "set", "Master", "1%-", NULL };

static const char *compositorOff[] = { "killall", "picom", NULL };
static const char *compositorOn[] = { "picom", "--corner-radius", "14", "--round-borders", "14", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenudesktop } },
	{ MODKEY,                       XK_q,      spawn,          {.v = statusmenu } },
	{ MODKEY|ShiftMask,             XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_l,      spawn,          {.v = lock } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_Right,  focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_Left,   focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_Down,   focusstack,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_Up,     spawn,          {.v = volup } },
	{ MODKEY|ShiftMask,             XK_Down,   spawn,          {.v = voldown } },
	{ MODKEY|ShiftMask,             XK_g,      togglegaps,     {0} },
	{ MODKEY,                       XK_Up,     focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_p,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[0]} },
    { MODKEY|ShiftMask,             XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_f,      togglefullscr,  {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_m,      spawn,          {.v = togglesound } },
	//{ MODKEY,                       XK_space,  setlayout,      {0} },
	//{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	{ MODKEY|ShiftMask,             XK_e,      spawn,           { .v = powermenu } },	
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        toggletilefloat,{0} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        spawn,          {.v = statusmenu } },
	{ ClkStatusText,        0,              Button3,        spawn,          {.v = togglesound } },
	{ ClkStatusText,        0,              Button4,        spawn,          {.v = volup } },
	{ ClkStatusText,        0,              Button5,        spawn,          {.v = voldown } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	//{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

