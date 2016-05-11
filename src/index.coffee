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
class MediaQuery extends React.Component

  @displayName = 'MediaQuery'
  @defaultProps = {
    component: 'div'
    componentProps: {}
    defaultBreakpoint: 'mother'
    breakpoints: {}
  }

  constructor: (props) ->
    super props
    @state = breakpoint: null

  # One of the breakpoints is at the current size
  #
  # @return [Boolean] size is present
  #
  hasCurrentBreakpoint: ->
    @_getBreakpointRenderMethod()?


  # --------------------------------------------
  # Lifecycle Methods
  # --------------------------------------------

  componentDidMount: ->
    @componentMounted = true
    @_onChange() if canUseDOM
    ResizeMonitor.addChangeListener(@_onChange.bind @)

  componentWillUnmount: ->
    @componentMounted = false
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
  _onChange: () ->
    if @componentMounted
      @setState breakpoint: @_getBreakpointFromBody()


  # --------------------------------------------
  # Render methods
  # --------------------------------------------

  render: ->
    return null unless @hasCurrentBreakpoint()
    React.createElement(@props.component, @props.componentProps, @_getBreakpointRenderMethod())


module.exports = MediaQuery
