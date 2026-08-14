#!/usr/bin/python3
"""Set MediaWiki admin password

Option:
    --pass=     unless provided, will ask interactively
    --domain=   unless provided, will ask interactively
                DEFAULT=www.example.com
"""

import re
import sys
import getopt
from libinithooks import inithooks_cache
import subprocess

from libinithooks.dialog_wrapper import Dialog


def usage(s=None):
    if s:
        print("Error:", s, file=sys.stderr)
    print("Syntax: %s [options]" % sys.argv[0], file=sys.stderr)
    print(__doc__, file=sys.stderr)
    sys.exit(1)


DEFAULT_DOMAIN="www.example.com"


def reset_password(password: str) -> str:
    """Set mediawiki password.

    Returns either "success" or process stderr.
    """
    change_password = subprocess.run(
        [
            "php",
            "maintenance/run.php",
            "changePassword",
            "--user=Admin",
            f"--password={password}"],
        capture_output=True,
        text=True,
        cwd="/var/www/mediawiki",
    )
    if (
        change_password.returncode == 0
        and change_password.stdout.startswith("Password set for Admin")
    ):
        return "success"
    return change_password.stderr


def main():
    try:
        opts, args = getopt.gnu_getopt(sys.argv[1:], "h", ['help', 'pass=', 'domain='])
    except getopt.GetoptError as e:
        usage(e)

    password = ""
    domain = ""
    for opt, val in opts:
        if opt in ('-h', '--help'):
            usage()
        elif opt == '--pass':
            password = val
        elif opt == '--domain':
            domain = val

    if not password:
        tries = 1
        while tries < 4:
            if 'd' not in locals():
                d = Dialog('TurnKey Linux - First boot configuration')
            password = d.get_password(
                "MediaWiki Password",
                "Enter new password for the MediaWiki 'admin' account.",
                pass_req=10, min_complexity=3)
            try_password = reset_password(password)
            if try_password == "success":
                break
            elif tries == 3:
                d.error(
                    "Repeated errors setting password. Giving up. Please"
                    " report to TurnKey.",
                )
                break
            d.error(
                f"Error setting password:\n{try_password}\nPlease try again",
            )

    if not domain:
        if 'd' not in locals():
            d = Dialog('TurnKey Linux - First boot configuration')

        domain = d.get_input(
            "MediaWiki Domain",
            "Enter the domain to serve MediaWiki",
            DEFAULT_DOMAIN)

    if domain == "DEFAULT":
        domain = DEFAULT_DOMAIN

    fqdn = re.compile(r"https?://")
    fqdn = fqdn.sub('', domain).strip('/')
    domain = "https://%s/" % fqdn

    inithooks_cache.write("APP_DOMAIN", domain)

    subprocess.call(['sed', '-i',
            '\|^\$wgServer|s|=.*|= "%s";|' % domain,
            '/var/www/mediawiki/LocalSettings.php'])
    subprocess.call(['sed', '-i',
            '\|RewriteRule|s|https://.*|%s/\$1 [R,L]|' % domain,
            '/etc/apache2/sites-available/mediawiki.conf'])
    subprocess.call(['service', 'apache2', 'restart'])


if __name__ == "__main__":
    main()
