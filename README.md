# Media Query Component

## How to use

```
  MediaQuery  = React.createFactory(require('tbg_media_query'))
  
  ...

  render: ->
    DOM.div( null,
    [
      DOM.h1({}, 'The title'),
      MediaQuery({breakpoints: ["brother", "mother"]}, [
        DOM.p({}, 'Large Screen Text only'),
      ])
      
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
    DOM.div( null,
    [
      DOM.h1({}, 'The title'),
      MediaQuery({breakpoints: ["baby", "sister"], defaultBreakpoint: "baby", component: 'aside', componentProps: {className: "sidebar"} }, [
        DOM.p({}, 'Small text only'),
      ])
      
    ])
```

