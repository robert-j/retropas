;;
;; $Id: basic.asm 3399 2025-07-25 13:39:36Z robertj $
;;
;; We've tested tasm.grammar.json with real ASM files from core/crtl
;; and from TASM's examples directory, too.
;;

.MODEL LARGE
.DATA
EXTRN PrefixSeg:WORD
.CODE
.386

PUBLIC  Function

IFDEF FOO

Function PROC
  ret
Function ENDP

ENDIF

;
; we need '@'' for Pascal's 'TFoo@Method' convention
;
Class@Function PROC
  .8086           ; old school
  .8087           ; we've got a copro

  mov   eax, 17   ; we tag 32-bit regs

  ; numbers

  mov   bx, 0f0f0h    ; hex
  mov   bx, f0h       ; no match
  mov   bx, 01b       ; binary
  mov   bx, 012b      ; no match
  mov   bx, 7o        ; octal
  mov   bx, 8o        ; no match
  mov   bx, 10d       ; decimal
  mov   bx, 10ad      ; no match

  jmp   @foo
  repz  cmpsd

  lock  xchg  ax, ax

  segds mov bx, [bar]
  seges mov bx, [foo]

@foo:

  loop  @foo
  loopz @foo

  ret
  retn
  retf
  iret
Class@Function ENDP

;
; macros don't have a closing name, apparently
;
Foo MACRO
ENDM

END start_symbol
