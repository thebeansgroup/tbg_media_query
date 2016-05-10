# Global libraries
EventEmitter = require('events').EventEmitter
assign = require('object-assign')

# CONSTANTS
CHANGE_EVENT = 'screen_size_change'

# Resize Event Listener
#
# @mixin
#
ResizeMonitor = assign {}, EventEmitter.prototype,

  # --------------------------------------------
  # Default Event Methods
  # --------------------------------------------

  emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    if @resizeTimer then clearTimeout @resizeTimer
    @removeListener(CHANGE_EVENT, callback)


  # --------------------------------------------
  # Private methods
  # --------------------------------------------

  # Set a timeout to call resizeEvent after 100ms, clearing existing timeout if one set
  #
  resize: ->
    if @resizeTimer then clearTimeout @resizeTimer
    @resizeTimer = setTimeout ResizeMonitor.emitChange.bind(ResizeMonitor), 100
 
  # Timeout store
  #
  resizeTimer: null

window?.addEventListener?("resize", ResizeMonitor.resize)
ResizeMonitor.setMaxListeners(0)
module.exports = ResizeMonitor
