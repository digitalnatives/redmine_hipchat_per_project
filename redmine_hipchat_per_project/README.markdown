HipChat Per Project Plugin for Redmine
======================================

Based on [HipChat Plugin for Redmine](https://github.com/hipchat/redmine_hipchat).
This plugin sends messages to your HipChat rooms when issues are created or updated.
The message contains information about issue status/priority change if there's any.


Setup
-----

1. Install this plugin following the standard Redmine [plugin installation guide](http://www.redmine.org/wiki/redmine/Plugins).
1. In Redmine, go to Administration/Roles and Permissions, there you can set the plugin permissions (view/set) for various roles.
1. In Redmine, go to your Project/Settings/Modules, there you can enable the plugin for the project.
1. In Redmine, go to your Project/HipChat settings, there you can set the notifications by providing an auth token, a room ID, and you can specify the message color. You can turn off the messages by leaving at least one of the two fields blank.


Tested with Redmine 1.4 stable.