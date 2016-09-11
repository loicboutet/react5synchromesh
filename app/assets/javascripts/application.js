// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require 'components'
//= require 'react_ujs'
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require 'webpack/client_only'

// app/assets/javascripts/cable.js
//= require action_cable
//x = require_self
//x = require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();
}).call(this);
Opal.load('components');
//= require turbolinks
//= require_tree .
