Zerotier API Scripts
==================

This is a collection of bash scripts using curl I created to automate things with the [Zerotier API](https://docs.zerotier.com/central/v1/).

* [Installation](#installation)
* [Options](#options)
* [Usage](#usage)

Installation
------------

Requirements:

* bash (recommend version 4+)
* [curl](https://curl.haxx.se)
* [jq](https://stedolan.github.io/jq)

Clone the repo, download a source zip or copy the shell scripts as needed.

Options
------------
```
Required enviroment variables:
ZEROTIER_TOKEN - set with your zerotier api token
NETWORK_ID - set with your network id
Available commands:
list-networks (ln): List zerotier networks
list-members (lm): List zerotier network members
update-member (um): Update zerotier member
quit: Exit from this menu
```

Usage
------------

### List networks
```BASH
./zerotier.sh ln
network_name      aaaabbbbccccdddd
```
### List network members
```BASH
./zerotier.sh lm
network_member_1                 aaaabbbccc      true      10.1.1.10
                                 ddddeeefff      false     null
```
### Update network member
When running this command it will automatically authorize the network member
```BASH
./zerotier.sh um ddddeeefff network_member_2
```
