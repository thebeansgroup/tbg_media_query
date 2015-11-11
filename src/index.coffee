# React Globals
React          = require('react')
Yaks           = require('yaks')

# Helpers
ResizeMonitor  = require('./resize')
canUseDOM      = Yaks.UTILS.canUseDOM


# Media Query
#
# @mixin
#
MediaQuery = 

  # --------------------------------------------
  # Defaults
  # --------------------------------------------

  propTypes:
    breakpoints: React.PropTypes.object.isRequired
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
    breakpoints: {}

  # One of the breakpoints is at the current size
  #
  # @return [Boolean] size is present
  #
  hasCurrentBreakpoint: ->
    @_getBreakpointRenderMethod()?


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
    window.getComputedStyle(document.body,':after').getPropertyValue('content').replace('-','').replace(/'/g, '').replace(/"/g, '') || ''

  _getBreakpointRenderMethod: -> 
    @props.breakpoints[@state.breakpoint || @props.defaultBreakpoint]

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
    React.createElement(@props.component, @props.componentProps, @_getBreakpointRenderMethod())


module.exports =  React.createClass(MediaQuery)
