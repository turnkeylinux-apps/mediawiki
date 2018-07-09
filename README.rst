MediaWiki - Wikipedia's Wiki Engine
===================================

`MediaWiki`_ is a powerful wiki engine that was originally developed to
serve the needs of Wikipedia - the free encyclopedia.  Today, MediaWiki
is used publicly by many of the largest and most popular wikis online,
while privately it is being increasingly deployed inside company
Intranets as a knowledge and content management system.

This appliance includes all the standard features in `TurnKey Core`_,
and on top of that:

- MediaWiki configurations:
   
   - Installed from package management. See /var/www for links to file
     paths.
   - Ensure clean and compliant HTML ($wgUseTidy)
   - Out of the box file uploading and image resizing (GD library)
      
      - Maximum filesize: 2MB
      - Supported file types: png, gif, jpg, jpeg

   - MediaWiki extensions are installed via selected Debian packages.
     Includes a custom script ``mwlsext`` to display enabled/available
     extensions:

        - mediawiki-extensions-base
        - mediawiki-extensions-collection
        - mediawiki-extensions-geshi
        - mediawiki-extensions-openid

- SSL support out of the box.
- `Adminer`_ administration frontend for MySQL (listening on port
  12322 - uses SSL).
- Postfix MTA (bound to localhost) to allow sending of email (e.g.,
  password recovery, user registration)
- Webmin modules for configuring Apache2, PHP and MySQL.

Customization details:

- Site logo is located at */var/lib/mediawiki/images/logo.png*
  (recommended size: 135x135px).
- Site name and administrative emails (set in
  */etc/mediawiki/LocalSettings.php*)::

    $wgSitename = "";
    $wgEmergencyContact = webmaster@localhost;
    $wgPasswordSender = webmaster@localhost;

See the `MediaWiki docs`_ for further details.

Credentials *(passwords set at first boot)*
-------------------------------------------

-  Webmin, SSH, MySQL: username **root**
-  Adminer: username **adminer**
-  MediaWiki: username **admin**

.. _MediaWiki: http://www.mediawiki.org/wiki/MediaWiki
.. _TurnKey Core: https://www.turnkeylinux.org/core
.. _ParserFunctions: http://www.mediawiki.org/wiki/Extension:ParserFunctions
.. _StringFunctions: http://www.mediawiki.org/wiki/Extension:StringFunctions
.. _CategoryTree: http://www.mediawiki.org/wiki/Extension:CategoryTree
.. _Renameuser: http://www.mediawiki.org/wiki/Extension:Renameuser
.. _Preloader: http://www.mediawiki.org/wiki/Extension:Preloader
.. _CharInsert: http://www.mediawiki.org/wiki/Extension:CharInsert
.. _ConfirmEdit: http://www.mediawiki.org/wiki/Extension:ConfirmEdit
.. _Gadgets: http://www.mediawiki.org/wiki/Extension:Gadgets
.. _SyntaxHighlight\_GeSHi: http://www.mediawiki.org/wiki/Extension:SyntaxHighlight_GeSHi
.. _Cite: http://www.mediawiki.org/wiki/Extension:Cite
.. _AWC's Forum: http://www.mediawiki.org/wiki/Extension:AWC's_Forum
.. _Adminer: http://www.adminer.org/
.. _MediaWiki docs: /docs/mediawiki
