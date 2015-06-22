# nonono

A tool for undoing git actions.

![Example usage](/nonono.png)

nonono is an interactive, easy-to-use command line tool for
reversing git actions.

## Usage

```shell
# to print out the undo command
nonono

# to print out then perform the undo command
nonono undo
```

## How it works

- Analyzes you history to check the last git commands
- Prints a message describing what you just did and what command to run to undo it
- Same as above plus it runs the given command. Unless that command is deemed to harmful
to run without knowing extra information.

## Limitations

- is not intelligent enough to know what git commands were issued for
which project. In most cases I anticipate nonono will be called during
that 'oh shit' moment right after issuing a dubious git command so th.

## Contributing

### Licence

The MIT License (MIT)

Copyright (c) 2015 Connor Atherton

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
