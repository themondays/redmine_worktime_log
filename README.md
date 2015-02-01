# Redmine Worktime Log Plugin
Release Candidate: 0.0.2

### Inception
Hey folks.

If describe this plugin in couple words - Worktime Log is just a Stopwatch plugin with extended projects / users / issues summary. I'm pretty sure that plugin will help you track your team load without any additional inconvenience editing issue details and billion clicks.

Worktime Log built about 3 month ago for internal use and today I decided to share firs public RC with you. 

In general plugin created and tested with Redmine 2.6 under PostgreSQL, by this reason some queries should be reviewed before push to production with MySQL database.

Feel free to make forks and touch me in case if you have some fixes and suggestions.

### How it works?
1. Enable Worktime Log module in your project
2. Add couple tickets assigned to you
3. Push START button and continue working
4. Don't forget press STOP when you going on lunch :)

![Worktime Log Issue Stopwatch Widget](http://www.redmine.org/attachments/download/13033/rwtl-stopwatch.png)

### Extra Issue Toolbar
To make life easier I have added additional toolbar to issue overview. In case if you don't need this tool you may change toolbar visibility inside plugin settings.

![Worktime Log Issue Extra Toolbar](http://www.redmine.org/attachments/download/13032/rwtl-issue-toolbar.png)

### Installation
1. Copy plugin files to ```/redmine/plugins``` and you will get something like that: ```redmine/plugins/redmine_worktime_log/init.rb```
2. Run ```rake redmine:plugins NAME=redmine_worktime_log RAILS_ENV=production```

### Settings
Inside plugin settings you may change widgets visibility as well.

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

### Changelog

#### Rev. 0.0.3
* Added time helper
* Fixed issue totals
* Fixed summary totals

#### Rev. 0.0.2
* Fixed toolbar stylesheet
* Fixed toolbar snap up button appearance
* Added 3 new languages
