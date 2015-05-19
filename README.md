# Media Query Component

## How to use

```
  MediaQuery  = React.createFactory(require('tbg_media_query'))
  
  ...

  renderTextLarge: ->
    DOM.p({}, 'Large Screen Text only'),

  renderTextSmall: ->
    DOM.p({}, 'Small Screen Text only'),

  render: ->
    textSmall = this.renderTextSmall()
    textLarge = this.renderTextLarge()

    DOM.div( null,
    [
      DOM.h1({}, 'The title'),
      MediaQuery({
        breakpoints: {
          baby:    textSmall
          sister:  textSmall
          brother: textLarge
          mother:  textLarge
        }
      })
      
    ])
```
## Configuration

The component takes the following optional properties:

* `defaultBreakpoint` - [default: 'mother'] - The size the server will render
* `component` - [default: 'div'] - The component that the child content will be rendered into.
* `componentProps` - [default: {}] - props to be based to parent component

```
  MediaQuery  = React.createFactory(require('tbg_media_query'))
  
  ...

  render: ->
    textSmall = this.renderTextSmall()
    textLarge = this.renderTextLarge()

    DOM.div( null,
    [
      DOM.h1({}, 'The title'),
      MediaQuery({
        defaultBreakpoint: "baby"
        component: 'aside'
        componentProps: {className: "sidebar"} 
        breakpoints: {
          baby:    textSmall
          sister:  textSmall
          brother: textLarge
          mother:  textLarge
        }
      })
    ])
```

