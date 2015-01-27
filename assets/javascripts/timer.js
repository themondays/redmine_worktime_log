/**
 * Worktime Log Stopwatch
 * @version 0.1
 */
$(document).ready(function() {
	var RedmineWorktimeLog = {
		opts: {
			time: 0,
			active: false,
			elapsed: 0,
			running_issue: 0,
			formWidget: '',
			timer: null
		},
		query: function(url,settings) {
			$.ajax({
				url: url,
				type: "POST",
				data: settings,
				dataType: "json",
				beforeSend: function(){
				},

				complete: function(){
				},

				success: function( response ){
					return true;
				},
				error: function(){
					return false;
				}
			});
		},
		widget: function() {
			var _this = this,
				btn = $("button", _this.opts.formWidget),
				Timer = _this.opts.timer.stopwatch({
                        startTime: _this.opts.runtime,
                        format: '{HH}:{MM}:{SS}'
			});
			_this.opts.runtime = _this.opts.timer.data('runtime')*1;
			if (this.opts.runtime > 1) {
				Timer.stopwatch({active: true,startTime: _this.opts.runtime}).stopwatch('start');
				_this.opts.active = true;
				btn.text(btn.data("stop")).attr('value','stop');
			}
			$("#stopwatch-ui select.dropdown").chosen({width:"80%",no_results_text: "Not found: "});

			//.bind(callback,this)
		},
		events: (function() {
			var _this = this;
			$(".widget.worklog #stopwatch-ui .dropdown").on('change',function(event){
				var el = $(this),
					btn = $("button", el);
				// Fix it
				if ( _this.opts.running_issue > 0 && _this.opts.active === true && _this.opts.running_issue !== el.val() ) {
					btn.parent().text(btn.data("switch"));
				} else {
					btn.parent().text(btn.data("stop"));
				}
			});
		}),
		launch: function(){
			var _this = this;
			this.opts.formWidget.submit(function(event){
				event.preventDefault();
				var el = $(this),
					btn = $("button",el),
					params = {
						state: $('[name="state"]',el).val(),
						issue_id: $('[name="issue_id"]',el).val()
					};
				url='/worktime/stopwatch/' + params.issue_id;
				_this.query(url,params);
				//var stopwatch = timer.stopwatch({startTime: time});
				if ( _this.opts.active !== true ) {
					_this.opts.active = true;
					_this.opts.timer.
						stopwatch('start');
					btn.text(btn.data("stop")).attr('value','stop');
					_this.opts.running_issue = $(".dropdown",el).val();
				} else {
					_this.opts.elapsed = _this.opts.timer.stopwatch('getTime');
					_this.opts.timer.
						stopwatch('stop').stopwatch('reset');
					_this.opts.timer.data('suntime',1);
					_this.opts.active = false;
					_this.opts.running_issue = 0;
					btn.text(btn.data("start")).attr('value','start');
				}
				return false;
			});

		},
		init: function() {
			this.events();
			this.widget();
			this.launch();
		}

	};

	RedmineWorktimeLog.opts.formWidget = $(".widget.worklog #stopwatch-ui");
	RedmineWorktimeLog.opts.timer = $('#timer');
	RedmineWorktimeLog.opts.runtime = RedmineWorktimeLog.opts.timer.data('runtime')*1;

	RedmineWorktimeLog.init();

	RedmineWorktimeLog.opts.timer.stopwatch({
		startTime: RedmineWorktimeLog.opts.runtime,
		format: '{HH}:{MM}:{SS}'
	});
});

/**
 * To do:
 * - add bindings
 * - callback
 * - rewrite stopwatch
 * - cleanup
 */