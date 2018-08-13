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
   
   - Installed from upstream source code to /var/www/mediawiki
   - Ensure clean and compliant HTML ($wgUseTidy)
   - Out of the box file uploading and image resizing (GD library)
      
      - Maximum filesize: 2MB
      - Supported file types: png, gif, jpg, jpeg

     **Security note**: Updates to MediaWiki may require supervision so
     they **ARE NOT** configured to install automatically. See `MediaWiki
     documentation`_ for upgrading.

- SSL support out of the box.
- `Adminer`_ administration frontend for MySQL (listening on port
  12322 - uses SSL).
- Postfix MTA (bound to localhost) to allow sending of email (e.g.,
  password recovery, user registration)
- Webmin modules for configuring Apache2, PHP and MySQL.

Customization details:

- Site logo is located at */var/www/mediawiki/images/logo.png*
  (recommended size: 135x135px).
- Site name and administrative emails (set in
  */var/www/mediawiki/LocalSettings.php*)::

    $wgSitename = "";
    $wgEmergencyContact = webmaster@localhost;
    $wgPasswordSender = webmaster@localhost;


Credentials *(passwords set at first boot)*
-------------------------------------------

-  Webmin, SSH, MySQL: username **root**
-  Adminer: username **adminer**
-  MediaWiki: username **admin**

.. _MediaWiki: https://www.mediawiki.org/wiki/MediaWiki
.. _TurnKey Core: https://www.turnkeylinux.org/core
.. _MediaWiki documentation: https://www.mediawiki.org/wiki/Manual:Upgrading
.. _Adminer: https://www.adminer.org/
