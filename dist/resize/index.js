// Generated by CoffeeScript 1.9.2
var CHANGE_EVENT, EventEmitter, ResizeMonitor, assign;

EventEmitter = require('events').EventEmitter;

assign = require('object-assign');

CHANGE_EVENT = 'screen_size_change';

ResizeMonitor = assign({}, EventEmitter.prototype, {
  emitChange: function() {
    return this.emit(CHANGE_EVENT);
  },
  addChangeListener: function(callback) {
    return this.on(CHANGE_EVENT, callback);
  },
  removeChangeListener: function(callback) {
    return this.removeListener(CHANGE_EVENT, callback);
  },
  resize: function() {
    if (this.resizeTimer) {
      clearTimeout(this.resizeTimer);
    }
    return this.resizeTimer = setTimeout(ResizeMonitor.emitChange.bind(ResizeMonitor), 100);
  },
  resizeTimer: null
});

if (typeof window !== "undefined" && window !== null) {
  if (typeof window.addEventListener === "function") {
    window.addEventListener("resize", ResizeMonitor.resize);
  }
}

ResizeMonitor.setMaxListeners(0);

module.exports = ResizeMonitor;
