<?php
# MediaWiki extensions

# FCKeditor: WYSIWYG editor for wiki pages
require_once("$IP/extensions/FCKeditor/FCKeditor.php");

# ParserFunctions: Enhances parser with logical functions
require_once("$IP/extensions/ParserFunctions/ParserFunctions.php");

# StringFunctions: Additional set of parser functions that operate on strings
require_once ("$IP/extensions/StringFunctions/StringFunctions.php");

# CategoryTree: Provides a dynamic view of the category structure as a tree
$wgUseAjax = true;
require_once("$IP/extensions/CategoryTree/CategoryTree.php");

# Renameuser: Special page allowing authorised users to rename user accounts
require_once("$IP/extensions/Renameuser/SpecialRenameuser.php");

# Cite: Create footnotes
require_once("$IP/extensions/Cite/Cite.php");
require_once("$IP/extensions/Cite/SpecialCite.php");

# CharInsert: JavaScript character insert boxes used on edit type pages
require_once("$IP/extensions/CharInsert/CharInsert.php");

# Gadgets: JS/CSS-based gadgets
require_once("$IP/extensions/Gadgets/Gadgets.php");

# SyntaxHighlight_GeSHi: adds <source> tag to present formatted source code
require_once("$IP/extensions/SyntaxHighlight_GeSHi/SyntaxHighlight_GeSHi.php");

# ConfirmEdit: Math captcha
require_once("$IP/extensions/ConfirmEdit/ConfirmEdit.php");
$wgCaptchaTriggers['edit']          = false; 
$wgCaptchaTriggers['create']        = false; 
$wgCaptchaTriggers['addurl']        = true; 
$wgCaptchaTriggers['createaccount'] = true;
$wgCaptchaTriggers['badlogin']      = true;

# Preloader: Populate new pages with template content depending on namespace
require_once("$IP/extensions/Preloader/Preloader.php");
$wgPreloaderSource[ NS_MEDIA ] = 'Template:Media';
$wgPreloaderSource[ NS_SPECIAL ] = 'Template:Special';
$wgPreloaderSource[ NS_MAIN ] = 'Template:Main';
$wgPreloaderSource[ NS_TALK ] = 'Template:Talk';
$wgPreloaderSource[ NS_USER ] = 'Template:User';
$wgPreloaderSource[ NS_USER_TALK ] = 'Template:User_Talk';
$wgPreloaderSource[ NS_IMAGE ] = 'Template:Image';
$wgPreloaderSource[ NS_IMAGE_TALK ] = 'Template:Image_Talk';
$wgPreloaderSource[ NS_MEDIAWIKI ] = 'Template:Mediawiki';
$wgPreloaderSource[ NS_MEDIAWIKI_TALK ] = 'Template:Mediawiki_Talk';
$wgPreloaderSource[ NS_TEMPLATE ] = 'Template:Template';
$wgPreloaderSource[ NS_TEMPLATE_TALK ] = 'Template:Template_Talk';
$wgPreloaderSource[ NS_HELP ] = 'Template:Help';
$wgPreloaderSource[ NS_HELP_TALK ] = 'Template:Help_Talk';
$wgPreloaderSource[ NS_CATEGORY ] = 'Template:Category';
$wgPreloaderSource[ NS_CATEGORY_TALK ] = 'Template:Category_Talk';

# AWC: Forum
require_once("$IP/extensions/awc/forums/awc_forum.php");

