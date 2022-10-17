
# pattern89.s

# Read only data
.section  .rodata
     msg_char:
     .string "%c\t"

     msg_space:
     .string "\t"
    
     msg_newline:
     .string "\n"

# Block started with symbol
.section  .bss
     .comm     column, 4, 4
     .comm     row   , 4, 4

# Data section
.section   .data
     .globl    asciiA
     .align    4
     .type     asciiA , @object
     .size     asciiA , 4
asciiA:
     .long     65
     .globl    space
     .align    4
     .type     space , @object
     .size     space , 4
space:
     .long     1
     .globl    space2
     .align    4
     .type     space2, @object
     .size     space2, 4
space2:
     .long     9

# Text section
.section   .text


# Entry point : _start
     .globl    _start
     .type     _start , @function
_start:

     #PROLOGUE
     pushl    %ebp
     movl     %esp , %ebp
    
     # MAIN CODE

     # 1. Initialization     (outer loop)
     movl     $1   , column

     # 2. Terminating condition   (outer loop)
.loop:
     movl     column, %eax
     movl     $5    , %ebx
     cmpl     %ebx  , %eax
     jg       .epilogue

     # 3. Loop body      (outer loop)
     
     # initialization    (inner loop)
     movl     $1    , row

     # Terminating  condition     (inner loop)
.inner_loop:
     movl     row   , %eax
     movl     $9    , %ebx
     cmpl     %ebx  , %eax
     jg       .outer

     movl     row   , %eax
     movl     space , %ebx
     cmpl     %ebx  , %eax
     je       .true_block

     movl     row   , %eax
     movl     space2, %ebx
     cmpl     %ebx  , %eax
     je       .true_block
     jmp      .false_block

.false_block:
     # Printing message
     pushl    $msg_space
     call     printf
     addl     $8    , %esp
     jmp      .continue

.true_block:
     # Printing message
     pushl    asciiA
     pushl    $msg_char
     call     printf
     addl     $8    , %esp
     jmp      .continue

.continue:
     # incrementing steps   (inner loop)
     # row++
     movl     row  , %eax
     addl      $1  , %eax
     movl     %eax , row
     jmp      .inner_loop

.outer:
     # row=1
     movl     $1  , row
     
     # asciiA++
     movl    asciiA, %eax
     addl     $1   , %eax
     movl    %eax , asciiA

     # space2--
     movl    space2, %eax
     subl     $1   , %eax
     movl    %eax  , space2

     # space++
     movl    space , %eax
     addl     $1   , %eax
     movl    %eax  , space

     # Printing message
     pushl   $msg_newline
     call    printf
     addl    $8    , %esp

     # 4. incrementing steps   (outer loop)
     # column++
     movl    column, %eax
     addl     $1   , %eax
     movl    %eax  , column
     jmp     .loop

.epilogue:
     pushl    $0
     call     exit
