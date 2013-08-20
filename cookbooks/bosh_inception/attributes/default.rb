# A String or Array of SSH public keys to populate the user"s .ssh/authorized_keys file.

default["disk"]["mounted"] = false
default["disk"]["device"] = "/dev/xvdf"
default["disk"]["fstype"] = "btrfs"
default["disk"]["dir"] = "/var/vcap/store"
default["user"]["username"] = `users | head -n 1`.strip
default["git"]["name"] = "Nobody"
default["git"]["email"] = "nobody@in-the-house.com"

default["chruby"]["rubies"]["1.9.3-p392"] = false
default["chruby"]["rubies"]["1.9.3-p429"] = true
default["chruby"]["default"] = "1.9.3-p429"

# Pass in credentials to be dropped into a ~/.fog file
# They will be automatically converted to symbolized keys
# to make fog happy
default["fog"] = {}
