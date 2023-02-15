#!/usr/bin/env sh
# Author: uucoin@163.com
#  2022/11/28
# report bugs at email
#fork from dns_yandax.sh of acme.sh/dnsapi/
#in yandax.sh PDD_Token is in http_header. here , we move it to data, as machineid.
#

# Values to export:
# export PDD_Token="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Sometimes cloudflare / google doesn't pick new dns records fast enough.
# You can add --dnssleep XX to params as workaround.

########  Public functions #####################

#Usage: dns_myapi_add   _acme-challenge.www.domain.com   "XKrxpRBosdIKFzxW_CT3KLZNf6q0HG9i01zxXp5CPBs"
dns_funhometv_add() {
  fulldomain="${1}"
  txtvalue="${2}"
  _debug "Calling: dns_funhometv_add() '${fulldomain}' '${txtvalue}'"

  _PDD_credentials || return 1

  #data="domain=${domain}&type=TXT&subdomain=${subdomain}&ttl=300&content=${txtvalue}"
  data="machineid=${PDD_Token}&c=a&tx=${fulldomain}&txv=${txtvalue}"
  #uri="https://pddimp.yandex.ru/api2/admin/dns/add"
  uri="https://dtx.com.funhome.tv/dtx"
  result="$(_post "${data}" "${uri}" | _normalizeJson)"
  _debug "Result: $result"

  if ! _contains "$result" '"success":"ok"'; then
 
      _err "Can't add TXT:${txtvalue} to ${fulldomain}."
      return 1

  fi
}

#Usage: dns_myapi_rm   _acme-challenge.www.domain.com
dns_funhometv_rm() {
  fulldomain="${1}"
  _debug "Calling: dns_funhometv_rm() '${fulldomain}'"
  txtvalue="FAKE"

  _PDD_credentials || return 1

  #_PDD_get_domain "$fulldomain" || return 1
  #_debug "Found suitable domain: $domain"

  #_PDD_get_record_ids "${domain}" "${subdomain}" || return 1
  #_debug "Record_ids: $record_ids"

  #for record_id in $record_ids; do
    #data="domain=${domain}&record_id=${record_id}"
    data="machineid=${PDD_Token}&c=r&tx=${fulldomain}&txv=${txtvalue}"
    #uri="https://pddimp.yandex.ru/api2/admin/dns/del"
    uri="https://dtx.com.funhome.tv/dtx"
    result="$(_post "${data}" "${uri}" | _normalizeJson)"
    _debug "Result: $result"

    if ! _contains "$result" '"success":"ok"'; then
      _info "Can't remove TXT of ${fulldomain}."
    fi
  #done
}

####################  Private functions below ##################################


_PDD_credentials() {
  if [ -z "${PDD_Token}" ]; then
    PDD_Token=""
    _err "You need to export PDD_Token=xxxxxxxxxxxxxxxxx."
    _err "You should get it at device start"
    return 1
  else
    _saveaccountconf PDD_Token "${PDD_Token}"
  fi
  export _H1="PddToken: $PDD_Token"
}

