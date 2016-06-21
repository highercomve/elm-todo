// inject bundled Elm app into div#main

var Elm = require( '../Todo.elm' );
var storedState = localStorage.getItem('todo');
var startingState = storedState ? JSON.parse(storedState) : null;
var app = Elm.Todo.fullscreen(startingState);
app.ports.setStorage.subscribe(function(state) {
  localStorage.setItem('todo', JSON.stringify(state));
});

    
