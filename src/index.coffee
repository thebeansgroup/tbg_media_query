# React Globals
React          = require('react/addons')

# Helpers
ResizeMonitor  = require('./resize')


# Media Query
#
# @mixin
#
MediaQuery = 

  # --------------------------------------------
  # Defaults
  # --------------------------------------------

  propTypes:
    breakpoints: React.PropTypes.array.isRequired


  # --------------------------------------------
  # Getters & Checkers - get/has/can/is
  # --------------------------------------------

  getInitialState: ->
    breakpoint: ''

  getDefaultProps: ->
    breakpoints: []

  # One of the breakpoints is at the current size
  #
  # @return [Boolean] size is present
  #
  hasCurrentBreakpoint: ->
    @props.breakpoints.indexOf(@state.breakpoint) isnt -1


  # --------------------------------------------
  # Lifecycle Methods
  # --------------------------------------------

  componentDidMount: ->
    ResizeMonitor.addChangeListener(@_onChange)

  componentWillUnmount: ->
    ResizeMonitor.removeChangeListener(@_onChange)


  # --------------------------------------------
  # Private methods
  # -------------------------------------------- 

  _getBreakpointFromBody: ->
    return '' unless not window.getComputedStyle?
    window.getComputedStyle(document.body,':after').getPropertyValue('content').replace('-','') || ''


  # --------------------------------------------
  # Event handlers
  # --------------------------------------------

  # Handle click from Clicker
  #
  _onChange: ()->
    @setState breakpoint: @_getBreakpointFromBody()


  # --------------------------------------------
  # Render methods
  # --------------------------------------------

  render: ->
    console.log @state.breakpoint
    return null unless @hasCurrentBreakpoint()


module.exports =  React.createClass(MediaQuery)
