# Steam Key Parser

A simple set of scripts to parse key lists as provided by various bundle services.

## Key Formatter

`key_formatter.sh <OPTION> <FILE>`

Will output all keys in the format:

```
<KEY>   <NAME>
```

Example:

```
00000-00000-00000   Foo
00000-00000-00000   Foo: The bar
```

FILE is a file that holds the raw input.

Output is to terminal, pipe if you need it in a file.

OPTION is one of:

### Tab separated (Otaku Bundle / GoGoBundle)

`-t` for `<KEY><TAB><Name>`

Example:
```
00000-00000-00000	Foo
00000-00000-00000	Foo: The bar
```

### Colon separated

`-c` for `<Name>: <KEY>`

Example:

```
Foo: 00000-00000-00000
Foo: The bar: 00000-00000-00000
```

### Bundle Stars

`-bs` for Bundle Stars weirdness, as encountered when copying from their web page. That is:

```
<KEY>
Copy
<NAME><TAB><NAME>

```

Example:

```
00000-00000-00000
Copy
Foo	Foo

00000-00000-00000
Copy
Foo: The bar	Foo: The bar

```

### Humble Bundle

`-h` for Humble Bundle weirdness, as encountered when copying from their web page. That is:

```
<NAME>
<BUNDLE>

<KEY>
```

Example:

```
Foo
Tux Bundle

00000-00000-00000
Foo: The bar
Tux Bundle

00000-00000-00000
```

### Bunch Keys

`-bk` for Bunch Keys, as emailed. That is:

```
<NAME> : <KEY>

```

Example:

```
Foo : 00000-00000-00000

Foo: The bar : 00000-00000-00000

```

## Key Lister

So you tell your friends what you've got to offer.

`key_lister.sh <FILE> -q`

Where FILE holds keys like so:

```
<KEY>   <NAME>
```

Example:

```
00000-00000-00000   Foo
00000-00000-00000   Foo: The bar
```

Output in all cases will be like so:

```
<QUANTITY> x <NAME>
```

Where QUANTITY is zero padded according to the largest number of duplicate keys listed.

Output with `-q` is sorted by quantity, like so:

```
15 x Foo: The bar
01 x Foo
```

Without `-q` is sorted by name, like so:

```
01 x Foo
15 x Foo: The bar
```
