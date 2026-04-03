# Retro Pascal Language Support

A Visual Studio Code extension providing syntax highlighting for retro
Borland Pascal projects — including Turbo Pascal, Delphi 1, TASM assembly,
inline assembler blocks, and NMAKE makefiles.

## Installation

Copy this folder into `~/.vscode/extensions/` and restart VS Code,
or install from source:

```sh
git clone https://github.com/robert-j/retropas.git ~/.vscode/extensions/retropas
```

## Languages

| ID | Description |
|----|-------------|
| [turbo](#turbo-pascal) | *Turbo Pascal* and *Delphi* language support |
| [tasm](#tasm-assembly) | *TASM*, *MASM*, *NASM* language support |
| [basm](#basm-injection) | BASM injection for *Pascal* |
| [nmake](#nmake-injection) | *NMAKE* injection for *Makefiles* |

### Turbo Pascal

Syntax highlighting for *Turbo Pascal* and *Delphi 1*, based on the standard
TextMate [grammar](https://github.com/textmate/pascal.tmbundle) but reduced
to match these specific dialects.

The grammar is modularized to support injection by the
[basm](#basm-injection) grammar. Code folding is supported via
`{#region}` / `{#endregion}` markers.

This extension does **not** claim any file extensions by default, so it
won't override the built-in Pascal language. To associate Pascal files with
this grammar, add the following to your VS Code `settings.json`:

```json
"files.associations": {
    "*.pas": "turbo",
    "*.inc": "turbo",
    "*.dpr": "turbo",
    "*.dpk": "turbo",
    "*.asm": "tasm"
}
```

### TASM Assembly

Assembler syntax for *TASM*, *MASM*, and *NASM* flavours, supporting both
16-bit and 32-bit modes in a single file. Designed to be injectable into
other languages. Code folding is supported for `PROC`/`ENDP`,
`STRUCT`/`ENDS`, `SEGMENT`/`ENDS`, and `MACRO`/`ENDM` blocks.

Modified from a grammar obtained from [textmate-grammars-themes](https://github.com/shikijs/textmate-grammars-themes).

Default extension: `.asm`.

### NMAKE Injection

Injects `nmake` preprocessor commands (`!ifdef`, `!include`, etc.) into the
built-in `makefile` language. The injection name `nmake` does not surface in
the VS Code UI (by design of VS Code grammar injections).

### BASM Injection

Injects support for inline assembler blocks (`asm...end`) into the
[turbo](#turbo-pascal) language, combining three grammars:

- **turbo** — the injection target
- **tasm** — instructions, registers, labels, and ASM-style numbers
- **basm** — data definitions, strings, and Pascal-style numbers

## License

[MIT](LICENSE)
