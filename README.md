# Redmine Worktime Log Plugin
Release Candidate: 0.0.1

### Inception
Hey folks.

If one work Worktime Log is just a Stopwatch plugin with extended projects / users / issues summary. I'm pretty sure that plugin will help you track your team load without any additional inconvenience editing issue details and billion clicks.

Worktime Log built about 3 month ago and today I completely added missing things to prepare first RC. 

Plugin built for internal use for Redmine and PostgreSQL, by this reason some queries should be reviewed before push to production with MySQL database.

Feel free to make forks and touch me in case if you have some fixes and suggestions.

### How it works?
Push START button and continue working and don't forget to press STOP when you going on lunch :)

### Installation
1. Copy plugin files to ```/redmine/plugins``` and you will get something like that: ```redmine/plugins/redmine_worktime_log/init.rb```
2. Run ```rake redmine:plugins NAME=redmine_worktime_log RAILS_ENV=production```

### Additional thanks to:
* Stopwatch timer originally from CakePHP app called [project-manager] by [websightdesigns]</li>
* [jQuery.Chosen] - by [Harvest]

### License
This plugin is available under [CC-BY 3.0]

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.

### Project locations
* [Project page on GitHub]
* [Project page]
* [Bring me a coffee]

In case ff you found something unappropriate or I forgot mention someone please touch me and we fix it.

Developed by [Jared Denison] in 2014. 

[Project page on GitHub]:https://github.com/themondays/redmine_worktime_log
[Project page]:http://themondays.ca/redmine/plugins/worktimelog/
[Bring me a coffee]:http://themondays.ca/coffee/
[Jared Denison]:http://themondays.ca
[project-manager]:https://github.com/websightdesigns/project-manager/blob/master/README.md
[websightdesigns]:https://github.com/websightdesigns/project-manager/blob/master/README.md
[jQuery.Chosen]:http://harvesthq.github.io/chosen/
[Harvest]:http://www.getharvest.com/
[CC-BY 3.0]:http://creativecommons.org/licenses/by/3.0/