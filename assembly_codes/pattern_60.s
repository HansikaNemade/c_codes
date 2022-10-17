
# pattern_60.s

# section: read only data
.section  .rodata
    msg_digit:
             .string "%d\t"
 
    msg_newline:
             .string "\n"

    msg_space:
             .string "\t"

# section: data
.section  .data
    .globl  num1
    .align  4
    .type   num1 , @object
    .size   num1 , 4
num1:
    .long  1
  
# section: Block started with symbol
.section   .bss
    .comm    column, 4, 4
    .comm    row   , 4, 4

# section: text
.section  .text
    .globl   _start
    .type    _start , @object
_start:

    # PROLOGUE
    pushl    %ebp
    movl     %esp , %ebp

    # 1. Initialization           (outer loop)
    movl    $1 , column

    # 2. Terminating condition         (outer loop)
.loop:
    movl   column , %eax
    cmpl   $5  , %eax
    jg      .epilogue

    # 3. Loop body           (outer loop)
    
    # Initialization               (inner loop)
    movl    $1  , row

    # Terminating  condition            (inner loop)
.inner_loop:
    movl    row , %eax
    cmpl    $5 , %eax
    jg      .outer

    # Loop body        (inner loop)

    movl    row , %eax
    movl    column , %ebx
    cmpl    %ebx , %eax
    jg      .space
    
    # printing message
    pushl   num1
    pushl   $msg_digit
    call    printf
    addl    $8  , %esp
    jmp     .out

.space:
    pushl   $msg_space
    call    printf
    addl    $8  , %esp
    jmp     .out

.out:
    # Incrementing steps        (inner loop)
    # row++
    incl    row
    jmp     .inner_loop

.outer:
    # row=1
    movl   $1 , row

    # num1++
    incl   num1

    # printing message
    pushl   $msg_newline
    call    printf
    addl    $8  , %esp
  
    # 4. Incrementing steps         (outer loop)
    # column++
    incl   column
    jmp     .loop

.epilogue:
    pushl   $0
    call    exit
