#!/bin/bash
echo 'Give ProtonVPN username to login with'
read pvpn_username
protonvpn-cli login $pvpn_username
protonvpn-cli netshield --ads-malware
protonvpn-cli killswitch --on
protonvpn-cli connect --sc