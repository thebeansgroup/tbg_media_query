# React Globals
React          = require('react/addons')

# Helpers
ResizeMonitor  = require('./resize')
canUseDOM      = require('react/lib/ExecutionEnvironment').canUseDOM


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
    component: React.PropTypes.string


  # --------------------------------------------
  # Getters & Checkers - get/has/can/is
  # --------------------------------------------

  getInitialState: ->
    breakpoint: null

  getDefaultProps: ->
    component: 'div'
    componentProps: {}
    defaultBreakpoint: 'mother'
    breakpoints: []

  # One of the breakpoints is at the current size
  #
  # @return [Boolean] size is present
  #
  hasCurrentBreakpoint: ->
    @props.breakpoints.indexOf(@state.breakpoint || @props.defaultBreakpoint) isnt -1


  # --------------------------------------------
  # Lifecycle Methods
  # --------------------------------------------

  componentWillMount: ->
    @_onChange() if canUseDOM

  componentDidMount: ->
    ResizeMonitor.addChangeListener(@_onChange)

  componentWillUnmount: ->
    ResizeMonitor.removeChangeListener(@_onChange)


  # --------------------------------------------
  # Private methods
  # -------------------------------------------- 

  _getBreakpointFromBody: ->
    return '' unless window.getComputedStyle?
    window.getComputedStyle(document.body,':after').getPropertyValue('content').replace('-','').replace(/'/g, '') || ''


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
    return null unless @hasCurrentBreakpoint()
    React.createElement(@props.component, @props.componentProps, @props.children)


module.exports =  React.createClass(MediaQuery)
