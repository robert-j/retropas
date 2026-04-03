(*
 * Test file
 *)

program Test;

{#region Foo}

function Foo: Word; assembler;
asm
  mov eax, 1
end;

{#endregion}

{#region Bar}

{ comment with asm end and more }
procedure Bar(Param: Word);
begin
  asm
    { Comment }
    (* Also a comment *)
    {$ifopt G+}
    {$endif}

    {$error How do Pascal keywords, like or and typeof look like? They
      must not be highlighted.}

    test: db  'They must not be highlighted in strings, too: and or'

    foo:  dd  22
    bar:  dw  $0f0f
    str:  db  'Hello World'#0#$1

    mov   eax, 2  { huhu }
    movzx edi, 17

    inc   edx

    db    $66

    les   di, @Result
    mov   ax, Param
    mov   byte ptr es:[di], $42
    mov   word ptr es:[di], $4242

    call  Halt    { reserved words from Pascal must not be handled }

    rep   stosb
    segds mov ax, [Foo]

    jcxz  @label

    call  far [Foo]

    verr  ax

  @label: mov cx, ax
  @LaBel: { comment }

  {@foo:}

    jmp   {@bar}

    mov   bx, SEG @Data
    mov   bx, offset @Data
    mov   es, seg @Code
    mov   ax, Param.word[2]

    { Check '&' }
    mov   bx, &dw
    les   di, SEG @Data
    les   di, &Seg
    mov   ax, word ptr es:[di]
    mov   ax, &word

    { numbers }
    mov   bx, 0f0fh
    mov   bx, f0fh      { NO MATCH }

    mov   bx, 0101b
    mov   bx, 0102b     { NO MATCH }

    mov   bx, 67o
    mov   bx, 68o       { NO MATCH }

  end;

  { one liners }
  asm mov ax, 1 end; { okay! }
  asm mov @Result, ax end; { okay! }
end;

{#endregion}

{ Overrides }
procedure Overrides; far;
begin
  if SizeOf(A) and (TypeOf(B) or true) then Bar;

  if not Assigned(A) then Halt;
  if false then Fail;

  for I := Low(Foo) to High(Foo) do
    with Foo do
    begin
      Bar;
    end;

  P := 'Hello world' + #101 + #$Ab;

  Self.Foo;
  Result := nil;

  Foo([SSeg, CSeg, DSeg, SPtr]);

  RunError(200);

  Mem, MemW, MemL
  Mem[], MemW[], MemL[DSeg: B];

  Ofs(foo);
  Seg(bar);
  Blah.Seg(foo);
  Inc(I);
  Dec(I, 2);
  X.Dec(Foo);

  read Field    { for properties }
  Read()        { system routine }
  X.Read        { custom }
  write Field   { for properties }
  Write()       { system routine }
  X.Write       { custom }

  TProcedure, TDelegate, TMethod, Cardinal
  IsDelegate, MakeDelegate, InvokeDelegate_Void

  Randomize;
  Random()
  MaxAvail MemAvail
  .MaxAvail &MemAvail

  WriteLn(I);
  ReadLn(S);

  HaltBool(false);
  LongJmp(Env, 1);

  { Turbo Numbers }

  I := 10;
  I := -10;
  I := $0A;
  I := +$0A;
  X := a$ff;  { NO MATCH }
  I := $0aQ;  { NO MATCH }
  P := 1E10;
  P := 1e-10;
  P := +1e-10;

  { BASM numbers }

  asm
    mov   bx, 0f0fh
    mov   bx, $f0f
    mov   bx, f0fh      { NO MATCH }

    mov   bx, 0101b
    mov   bx, 0102b     { NO MATCH }

    mov   bx, 67o
    mov   bx, 68o       { NO MATCH }
  end;
end;

{ exports by index and name }

exports Lfn.LfnFindFirst index 100;
exports LfnFindFirst name 'hallo''welt';  { comment }
exports LfnFindFirst index $1a;

exports LfnFindFirst index wrong;         { NO MATCH }
exports LfnFindFirst name  1;             { NO MATCH }
