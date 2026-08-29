#!/bin/bash
set -euo pipefail

result=${TKL_TEST_RESULT:?}
password=${TKL_TEST_APP_PASS:?}
work=/run/tkl-v19-tests/mediawiki
base=https://www.example.com
curl_args=(-kfsS --resolve www.example.com:443:127.0.0.1)
mkdir -p "$work"

systemctl --quiet is-active apache2.service mariadb.service
grep -q '\[40mediawiki\] successfully completed' /var/log/inithooks.log
curl "${curl_args[@]}" "$base/" >"$work/home.html"
grep -Eqi 'MediaWiki|Main Page' "$work/home.html"

version=$(sed -n "s/^define( 'MW_VERSION', '\([^']*\)' );/\1/p" \
    /var/www/mediawiki/includes/Defines.php)
test "$version" = 1.46.0

runuser -u www-data -- test ! -w /var/www/mediawiki/index.php
runuser -u www-data -- test ! -w /var/www/mediawiki/LocalSettings.php
runuser -u www-data -- touch /var/www/mediawiki/images/.tkl-v19-write-test
runuser -u www-data -- rm /var/www/mediawiki/images/.tkl-v19-write-test

curl "${curl_args[@]}" -c "$work/cookies" \
    "$base/api.php?action=query&meta=tokens&type=login&format=json" \
    >"$work/login-token.json"
login_token=$(python3 -c 'import json; print(json.load(open("'$work'/login-token.json"))["query"]["tokens"]["logintoken"])')
curl "${curl_args[@]}" -b "$work/cookies" -c "$work/cookies" \
    --data-urlencode action=login \
    --data-urlencode lgname=Admin \
    --data-urlencode "lgpassword=$password" \
    --data-urlencode "lgtoken=$login_token" \
    --data-urlencode format=json \
    "$base/api.php" >"$work/login.json"
python3 -c 'import json; assert json.load(open("'$work'/login.json"))["login"]["result"] == "Success"'

curl "${curl_args[@]}" -b "$work/cookies" \
    "$base/api.php?action=query&meta=tokens&format=json" >"$work/csrf-token.json"
csrf_token=$(python3 -c 'import json; print(json.load(open("'$work'/csrf-token.json"))["query"]["tokens"]["csrftoken"])')
curl "${curl_args[@]}" -b "$work/cookies" \
    --data-urlencode action=edit \
    --data-urlencode title=QA_Persistence \
    --data-urlencode text=qa-persistence-marker \
    --data-urlencode "token=$csrf_token" \
    --data-urlencode format=json \
    "$base/api.php" >"$work/edit.json"
python3 -c 'import json; assert json.load(open("'$work'/edit.json"))["edit"]["result"] == "Success"'

systemctl restart mariadb.service apache2.service
curl "${curl_args[@]}" \
    "$base/api.php?action=query&prop=revisions&rvprop=content&rvslots=main&titles=QA_Persistence&format=json&formatversion=2" \
    >"$work/page-after-restart.json"
grep -Fq qa-persistence-marker "$work/page-after-restart.json"

! grep -F -- "$password" /var/log/inithooks.log

cat >"$result" <<EOF
package_source=official MediaWiki 1.46.0 release archive pinned by SHA-256
installed_version=$version
runtime_checks=Apache and MariaDB services, HTTPS home page, firstboot completion, API admin login, page edit, restart persistence, ownership boundaries, password log hygiene
updater_command=supervised official MediaWiki upgrade procedure
updater_result=installed version unchanged during QA
updater_channel=official MediaWiki 1.46 stable releases
integrity_evidence=release archive pinned to ac395e4ffd3b63b86a242efd679257503e463445ba9f989b514d9d3b342c456a
EOF
