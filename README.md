Inception Server for Bosh development
=====================================

Create an inception server for Bosh-related development.

Includes a CLI for creating and preparing an inception server for deploying/developing a Bosh universe. The created or targeted VM is upgraded into an inception server via a Chef cookbook.

The CLI will explain how to share access to an inception server with others. Also with the power of tmux, make it easy for 2+ people to view the same terminal and to leave long running jobs whilst you are disconnected.

[![Build Status](https://travis-ci.org/drnic/inception-server.png?branch=master)](https://travis-ci.org/drnic/inception-server)[![Code Climate](https://codeclimate.com/github/drnic/inception-server.png)](https://codeclimate.com/github/drnic/inception-server)

Installation
------------

```
git clone https://github.com/cloudfoundry-community/inception-server.git
cd inception-server
bundle
```

### Warning: RubyGem not working

*Wherever you see `inception` below, use `bundle exec bin/inception` until the rubygem is fixed.*

**The tool WILL be distributed as a RubyGem, but its currently not working in this form sadly.**

```
$ gem install inception-server
```

Usage
-----

This project includes both a standalone CLI to create an inception server or transform an existing VM into an inception server; and the internal Chef cookbooks that can be used outside of the CLI.

### CLI usage - create a remote inception server

To create a remote inception server, normally in the IaaS/region that you will be working with BOSH:

```
$ inception deploy

Auto-detected infrastructure API credentials at ~/.fog (override with $FOG)
1. AWS (default)
2. AWS (starkandwayne)
3. Alternate credentials
Choose infrastructure:  3

1. AWS
2. OpenStack
Choose infrastructure:  1


Using provider aws:

1. *US East (Northern Virginia) Region (us-east-1)
2. US West (Oregon) Region (us-west-2)
3. US West (Northern California) Region (us-west-1)
4. EU (Ireland) Region (eu-west-1)
5. Asia Pacific (Singapore) Region (ap-southeast-1)
6. Asia Pacific (Sydney) Region (ap-southeast-2)
7. Asia Pacific (Tokyo) Region (ap-northeast-1)
8. South America (Sao Paulo) Region (sa-east-1)
Choose AWS region: 2

Access key: KEYGOESHERE
Secret key: SECRETGOESHERE

Confirming: Using aws/us-west-2

Preparing deployment settings

Using your git user.name (Dr Nic Williams)
Acquiring a public IP address... 54.245.246.122

Provision inception server

Created security group ssh
 -> opened ssh ports TCP 22..22 from IP range 0.0.0.0/0
Booting m3.medium Inception VM...
Provisioning 16Gb persistent disk for inception VM...

Prepare inception VM

knife solo bootstrap ubuntu@ec2-54-214-66-166.us-west-2.compute.amazonaws.com [...]
Bootstrapping Chef...
... lots of chef output...

```

### CLI usage - upgrade existing remote inception server

You can upgrade your remote inception server at any time by re-running the `deploy` command.

```
$ inception deploy
... lots of chef output ...
```

### SSH access

You have some options for accessing the inception server via SSH:

-	`inception ssh` - opens a simple terminal to the inception server
-	`inception tmux` - creates or attaches to a tmux session on the inception server
-	`inception share-ssh` - displays how anyone can setup their own ssh config to connect to the inception server without requiring this project to be installed (nor requiring Ruby installed)

### Chef cookbook usage - remote VM

This project includes a `bosh_inception` Chef cookbook.

You can apply the cookbook to a preexisting remote VM using [knife solo](http://matschaffer.github.io/knife-solo/):

```
$ bundle
$ bundle exec knife solo bootstrap ubuntu@HOST -r 'bosh_inception'
$ bundle exec knife solo bootstrap ubuntu@HOST -j '{"disk": {"mounted": true, "device": "/dev/xvdf"}}' -r 'bosh_inception'

# for more help information:
$ knife solo bootstrap -h
```

See `cookbooks/bosh_inception/attributes/default.rb` for available JSON overrides.

### Chef cookbook usage - local VM

You can also apply the cookbooks to the local VM (or a remote VM that you've shelled into) using your favourite Chef toolchain.

See `cookbooks/bosh_inception/attributes/default.rb` for available JSON overrides.

Development
-----------

One half of the functionality is in a Chef cookbook `bosh_inception`. To load this cookbook into a Vagrant VM and run a series of integration tests (via `test-kitchen`):

```
$ bundle
$ kitchen test virtualbox
$ kitchen test vmware # if you have vagrant vmware plugin
```

Contributing
------------

1.	Fork it
2.	Create your feature branch (`git checkout -b my-new-feature`)
3.	Commit your changes (`git commit -am 'Add some feature'`)
4.	Push to the branch (`git push origin my-new-feature`)
5.	Create new Pull Request
