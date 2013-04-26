HipChat Per Project Plugin for Redmine
======================================

Based on [HipChat Plugin for Redmine](https://github.com/hipchat/redmine_hipchat).
This plugin sends messages to your HipChat rooms when issues are created or updated.
The message contains information about the issue status/priority change if there's any.


Setup
-----

1. Install this plugin following the standard Redmine [plugin installation guide](http://www.redmine.org/wiki/redmine/Plugins).
1. In Redmine, go to Administration/Roles and Permissions, there you can set the plugin permissions (view/set) for various roles.
1. In Redmine, go to your Project/Settings/Modules, there you can enable the plugin for the project.
1. In Redmine, go to your Project/HipChat settings, there you can set the notifications by providing an auth token, a room ID, and you can specify the message color.

You can turn off the messages by leaving at least one of the two text fields blank.

Plugin Info
-----------

This version of the plugin is compatible with Redmine 1.4 .
If you're using Redmine 2.x, check out the [redmine2 branch](https://github.com/digitalnatives/redmine_hipchat_per_project/tree/redmine2).


Authors
-------

The plugin was written by developers of [Digital Natives](http://www.digitalnatives.hu/english) team (primary Zsofia Balogh).

Licence
-------

This plugin is released under the MIT license.
