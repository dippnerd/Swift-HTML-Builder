# Swift HTML Builder
Lightweight, very basic Swift library for quickly building HTML nodes

There are plenty of better, more full-featured options out there for building HTML in Swift, so if you need this for any serious web development, this is not your best bet.

I built this for some various command line tools I made that often require outputting logs to HTML for easy digestion and color coding. It's easy to drop into any project, without extra dependencies outside of Foundation, and will give you a quick and easy way to build basic HTML docs in no time. 

## Usage
You can build HTML nodes quickly, like so:
```
let table = HTML.Node(element: .table)
```

The basic idea is that a Node can take any type of element that is in the supported enum. Feel free to extend this for your needs, but I just needed the basics from it. 

You can then attach child Nodes to it like so:
```
let cell1 = HTML.Node(element: .td, value: "I'm a regular string!")
let cell2 = HTML.Node(element: .td, value: "I'm a another regular string!")
let row = HTML.Node(element: .tr, children: [cell, cell2])
table.children.append(row)
```

This will build a basic table with a single row and two cells. Easy right? Kinda boring though too, right?

You can extend a given Node by adding attributes like so:
```
let cell = HTML.Node(element: .td, value: "I'm a red string!", attributes: ["class":"red"])
```

This will give your cell the attribute `class="red"` but you can add as many attributes as needed.

Once you're ready to build your nodes into an HTML string, you can simply parse like so:
```
let html = HTML.parse(using: [table])
print(html) //your resulting string of HTML!
```

If you want a full HTML doc but don't feel like building all of the nodes yourself, there's a handy helper:
```
let stylesheet = """
.red {
  color:red;
}
"""
let html = HTML.doc(using: [table], style: stylesheet)
```

This will build your basic HTML structure and include your stylesheet string in the head. Your nodes will be places in the body, resulting in something like:
```
<!DOCTYPE html>
<html>
  <head>
    <style>
      .red {
        color:red;
      }
    </style>
  </head>
  <body>
    <table>
      <tr>
        <td class="red">I'm a red string!</td>
        <td>I'm a another regular string!</td>
      </tr>
    </table>
  </body>
</html>
```

Again, there are plenty of better tools for the job, but if you just need an easy, single file solution to drop into your project, this is perfect for you. 
