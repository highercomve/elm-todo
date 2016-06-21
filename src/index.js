// inject bundled Elm app into div#main

var Elm = require( '../Todo.elm' );

function init() {
  var startingState = storedState ? JSON.parse(storedState) : null;
  var app = Elm.Todo.fullscreen(startingState);
  app.ports.setStorage.subscribe(function(state) {
    localStorage.setItem('todo', JSON.stringify(state));
  });

}
try {
  init()
} catch (e) {
  localStorage.clear()
  init()
}


