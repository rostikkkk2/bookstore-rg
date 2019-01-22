// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();
  // function plus() {
  //   alert('lol')
  // }
  // alert('lol')

  // document.getElementById("11").onClick = function(){
  //   alert('lol');
  // };

}).call(this);
