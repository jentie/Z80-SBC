; Partial Z80 disassembler

; Constants for opcodes. In same order as table that follows.

OP_ADC:  equ    $00
OP_ADD:  equ    $01
OP_AND:  equ    $02
OP_BIT:  equ    $03
OP_CALL: equ    $04
OP_CCF:  equ    $05
OP_CP:   equ    $06
OP_CPD:  equ    $07
OP_CPDR: equ    $08
OP_CPI:  equ    $09
OP_CPIR: equ    $0A
OP_CPL:  equ    $0B
OP_DAA:  equ    $0C
OP_DEC:  equ    $0D
OP_DI:   equ    $0E
OP_DJNZ: equ    $0F
OP_EI:   equ    $10
OP_EX:   equ    $11
OP_EXX:  equ    $12
OP_HALT: equ    $13
OP_IM:   equ    $14
OP_IN:   equ    $15
OP_INC:  equ    $16
OP_IND:  equ    $17
OP_INDR: equ    $18
OP_INI:  equ    $19
OP_INIR: equ    $1A
OP_JP:   equ    $1B
OP_JR:   equ    $1C
OP_LD:   equ    $1D
OP_LDD:  equ    $1E
OP_LDDR: equ    $1F
OP_LDI:  equ    $20
OP_LDIR: equ    $21
OP_NEG:  equ    $22
OP_NOP:  equ    $23
OP_OR:   equ    $24
OP_OTDR: equ    $25
OP_OTIR: equ    $26
OP_OUT:  equ    $27
OP_OUTD: equ    $28
OP_OUTI: equ    $29
OP_POP:  equ    $2A
OP_PUSH: equ    $2B
OP_RES:  equ    $2C
OP_RET:  equ    $2D
OP_RETI: equ    $2E
OP_RETN: equ    $2F
OP_RL:   equ    $30
OP_RLA:  equ    $31
OP_RLC:  equ    $32
OP_RLCA: equ    $33
OP_RLD:  equ    $34
OP_RR:   equ    $35
OP_RRA:  equ    $36
OP_RRC:  equ    $37
OP_RRCA: equ    $38
OP_RRD:  equ    $39
OP_RST:  equ    $3A
OP_SBC:  equ    $3B
OP_SCF:  equ    $3C
OP_SET:  equ    $3D
OP_SLA:  equ    $3E
OP_SRA:  equ    $3F
OP_SRL:  equ    $40
OP_SUB:  equ    $41
OP_XOR:  equ    $42
OP_INV:  equ    $43

; Lookup table of opcode strings, 4 bytes each.

MNEMONICS:
        db      "ADC "          ; $00
        db      "ADD "          ; $01
        db      "AND "          ; $02
        db      "BIT "          ; $03
        db      "CALL"          ; $04
        db      "CCF "          ; $05
        db      "CP  "          ; $06
        db      "CPD "          ; $07
        db      "CPDR"          ; $08
        db      "CPI "          ; $09
        db      "CPIR"          ; $0A
        db      "CPL "          ; $0B
        db      "DAA "          ; $0C
        db      "DEC "          ; $0D
        db      "DI  "          ; $0E
        db      "DJNZ"          ; $0F
        db      "EI  "          ; $10
        db      "EX  "          ; $11
        db      "EXX "          ; $12
        db      "HALT"          ; $13
        db      "IM  "          ; $14
        db      "IN  "          ; $15
        db      "INC "          ; $16
        db      "IND "          ; $17
        db      "INDR"          ; $18
        db      "INI "          ; $19
        db      "INIR"          ; $1A
        db      "JP  "          ; $1B
        db      "JR  "          ; $1C
        db      "LD  "          ; $1D
        db      "LDD "          ; $1E
        db      "LDDR"          ; $1F
        db      "LDI "          ; $20
        db      "LDIR"          ; $21
        db      "NEG "          ; $22
        db      "NOP "          ; $23
        db      "OR  "          ; $24
        db      "OTDR"          ; $25
        db      "OTIR"          ; $26
        db      "OUT "          ; $27
        db      "OUTD"          ; $28
        db      "OUTI"          ; $29
        db      "POP "          ; $2A
        db      "PUSH"          ; $2B
        db      "RES "          ; $2C
        db      "RET "          ; $2D
        db      "RETI"          ; $2E
        db      "RETN"          ; $2F
        db      "RL  "          ; $30
        db      "RLA "          ; $31
        db      "RLC "          ; $32
        db      "RLCA"          ; $33
        db      "RLD "          ; $34
        db      "RR  "          ; $35
        db      "RRA "          ; $36
        db      "RRC "          ; $37
        db      "RRCA"          ; $38
        db      "RRD "          ; $39
        db      "RST "          ; $3A
        db      "SBC "          ; $3B
        db      "SCF "          ; $3C
        db      "SET "          ; $3D
        db      "SLA "          ; $3E
        db      "SRA "          ; $3F
        db      "SRL "          ; $40
        db      "SUB "          ; $41
        db      "XOR "          ; $42
        db      "??? "          ; $43

; Lookup table of opcodes and instruction lengths.

OPCODES:
        DB      OP_NOP,  1      ; $00
        DB      OP_LD,   3      ; $01
        DB      OP_LD,   1      ; $02
        DB      OP_INC,  1      ; $03
        DB      OP_INC,  1      ; $04
        db      OP_DEC,  1      ; $05
        db      OP_LD,   2      ; $06
        db      OP_RLCA, 1      ; $07
        db      OP_EX,   1      ; $08
        db      OP_ADD,  1      ; $09
        db      OP_LD,   1      ; $0A
        db      OP_DEC,  1      ; $0B
        db      OP_INC,  1      ; $0C
        db      OP_DEC,  1      ; $0D
        db      OP_LD,   2      ; $0E
        db      OP_RRCA, 1      ; $0F
        db      OP_DJNZ, 2      ; $10
        db      OP_LD,   3      ; $11
        db      OP_LD,   1      ; $12
        db      OP_INC,  1      ; $13
        db      OP_INC,  1      ; $14
        db      OP_DEC,  1      ; $15
        db      OP_LD,   2      ; $16
        db      OP_RLA,  1      ; $17
        db      OP_JR,   2      ; $18
        db      OP_ADD,  1      ; $19
        db      OP_LD,   1      ; $1A
        db      OP_DEC,  1      ; $1B
        db      OP_INC,  1      ; $1C
        db      OP_DEC,  1      ; $1D
        db      OP_LD,   2      ; $1E
        db      OP_RRA,  1      ; $1F
        db      OP_JR,   2      ; $20
        db      OP_LD,   3      ; $21
        db      OP_LD,   3      ; $22
        db      OP_INC,  1      ; $23
        db      OP_INC,  1      ; $24
        db      OP_DEC,  1      ; $25
        db      OP_LD,   2      ; $26
        db      OP_DAA,  1      ; $27
        db      OP_JR,   2      ; $28
        db      OP_ADD,  1      ; $29
        db      OP_LD,   3      ; $2A
        db      OP_DEC,  1      ; $2B
        db      OP_INC,  1      ; $2C
        db      OP_DEC,  1      ; $2D
        db      OP_LD,   2      ; $2E
        db      OP_CPL,  1      ; $2F
        db      OP_JR,   2      ; $30
        db      OP_LD,   3      ; $31
        db      OP_LD,   3      ; $32
        db      OP_INC,  1      ; $33
        db      OP_INC,  1      ; $34
        db      OP_DEC,  1      ; $35
        db      OP_LD,   2      ; $36
        db      OP_SCF,  1      ; $37
        db      OP_JR,   2      ; $38
        db      OP_ADD,  1      ; $39
        db      OP_LD,   3      ; $3A
        db      OP_DEC,  1      ; $3B
        db      OP_INC,  1      ; $3C
        db      OP_DEC,  1      ; $3D
        db      OP_LD,   2      ; $3E
        db      OP_CCF,  1      ; $3F
        db      OP_LD,   1      ; $40
        db      OP_LD,   1      ; $41
        db      OP_LD,   1      ; $42
        db      OP_LD,   1      ; $43
        db      OP_LD,   1      ; $44
        db      OP_LD,   1      ; $45
        db      OP_LD,   1      ; $46
        db      OP_LD,   1      ; $47
        db      OP_LD,   1      ; $48
        db      OP_LD,   1      ; $49
        db      OP_LD,   1      ; $4A
        db      OP_LD,   1      ; $4B
        db      OP_LD,   1      ; $4C
        db      OP_LD,   1      ; $4D
        db      OP_LD,   1      ; $4E
        db      OP_LD,   1      ; $4F
        db      OP_LD,   1      ; $50
        db      OP_LD,   1      ; $51
        db      OP_LD,   1      ; $52
        db      OP_LD,   1      ; $53
        db      OP_LD,   1      ; $54
        db      OP_LD,   1      ; $55
        db      OP_LD,   1      ; $56
        db      OP_LD,   1      ; $57
        db      OP_LD,   1      ; $58
        db      OP_LD,   1      ; $59
        db      OP_LD,   1      ; $5A
        db      OP_LD,   1      ; $5B
        db      OP_LD,   1      ; $5C
        db      OP_LD,   1      ; $5D
        db      OP_LD,   1      ; $5E
        db      OP_LD,   1      ; $5F
        db      OP_LD,   1      ; $60
        db      OP_LD,   1      ; $61
        db      OP_LD,   1      ; $62
        db      OP_LD,   1      ; $63
        db      OP_LD,   1      ; $64
        db      OP_LD,   1      ; $65
        db      OP_LD,   1      ; $66
        db      OP_LD,   1      ; $67
        db      OP_LD,   1      ; $68
        db      OP_LD,   1      ; $69
        db      OP_LD,   1      ; $6A
        db      OP_LD,   1      ; $6B
        db      OP_LD,   1      ; $6C
        db      OP_LD,   1      ; $6D
        db      OP_LD,   1      ; $6E
        db      OP_LD,   1      ; $6F
        db      OP_LD,   1      ; $70
        db      OP_LD,   1      ; $71
        db      OP_LD,   1      ; $72
        db      OP_LD,   1      ; $73
        db      OP_LD,   1      ; $74
        db      OP_LD,   1      ; $75
        db      OP_HALT, 1      ; $76
        db      OP_LD,   1      ; $77
        db      OP_LD,   1      ; $78
        db      OP_LD,   1      ; $79
        db      OP_LD,   1      ; $7A
        db      OP_LD,   1      ; $7B
        db      OP_LD,   1      ; $7C
        db      OP_LD,   1      ; $7D
        db      OP_LD,   1      ; $7E
        db      OP_LD,   1      ; $7F
        db      OP_ADD,  1      ; $80
        db      OP_ADD,  1      ; $81
        db      OP_ADD,  1      ; $82
        db      OP_ADD,  1      ; $83
        db      OP_ADD,  1      ; $84
        db      OP_ADD,  1      ; $85
        db      OP_ADD,  1      ; $86
        db      OP_ADD,  1      ; $87
        db      OP_ADC,  1      ; $88
        db      OP_ADC,  1      ; $89
        db      OP_ADC,  1      ; $8A
        db      OP_ADC,  1      ; $8B
        db      OP_ADC,  1      ; $8C
        db      OP_ADC,  1      ; $8D
        db      OP_ADC,  1      ; $8E
        db      OP_ADC,  1      ; $8F
        db      OP_SUB,  1      ; $90
        db      OP_SUB,  1      ; $91
        db      OP_SUB,  1      ; $92
        db      OP_SUB,  1      ; $93
        db      OP_SUB,  1      ; $94
        db      OP_SUB,  1      ; $95
        db      OP_SUB,  1      ; $96
        db      OP_SUB,  1      ; $97
        db      OP_SBC,  1      ; $98
        db      OP_SBC,  1      ; $99
        db      OP_SBC,  1      ; $9A
        db      OP_SBC,  1      ; $9B
        db      OP_SBC,  1      ; $9C
        db      OP_SBC,  1      ; $9D
        db      OP_SBC,  1      ; $9E
        db      OP_SBC,  1      ; $9F
        db      OP_AND,  1      ; $A0
        db      OP_AND,  1      ; $A1
        db      OP_AND,  1      ; $A2
        db      OP_AND,  1      ; $A3
        db      OP_AND,  1      ; $A4
        db      OP_AND,  1      ; $A5
        db      OP_AND,  1      ; $A6
        db      OP_AND,  1      ; $A7
        db      OP_XOR,  1      ; $A8
        db      OP_XOR,  1      ; $A9
        db      OP_XOR,  1      ; $AA
        db      OP_XOR,  1      ; $AB
        db      OP_XOR,  1      ; $AC
        db      OP_XOR,  1      ; $AD
        db      OP_XOR,  1      ; $AE
        db      OP_XOR,  1      ; $AF
        db      OP_OR,   1      ; $B0
        db      OP_OR,   1      ; $B1
        db      OP_OR,   1      ; $B2
        db      OP_OR,   1      ; $B3
        db      OP_OR,   1      ; $B4
        db      OP_OR,   1      ; $B5
        db      OP_OR,   1      ; $B6
        db      OP_OR,   1      ; $B7
        db      OP_CP,   1      ; $B8
        db      OP_CP,   1      ; $B9
        db      OP_CP,   1      ; $BA
        db      OP_CP,   1      ; $BB
        db      OP_CP,   1      ; $BC
        db      OP_CP,   1      ; $BD
        db      OP_CP,   1      ; $BE
        db      OP_CP,   1      ; $BF
        db      OP_RET,  1      ; $C0
        db      OP_POP,  1      ; $C1
        db      OP_JP,   3      ; $C2
        db      OP_JP,   3      ; $C3
        db      OP_CALL, 3      ; $C4
        db      OP_PUSH, 1      ; $C5
        db      OP_ADD,  2      ; $C6
        db      OP_RST,  1      ; $C7
        db      OP_RET,  1      ; $C8
        db      OP_RET,  1      ; $C9
        db      OP_JP,   3      ; $CA
        db      OP_INV,  0      ; $CB
        db      OP_CALL, 3      ; $CC
        db      OP_CALL, 3      ; $CD
        db      OP_ADC,  2      ; $CE
        db      OP_RST,  1      ; $CF
        db      OP_RET,  1      ; $D0
        db      OP_POP,  1      ; $D1
        db      OP_JP,   3      ; $D2
        db      OP_OUT,  2      ; $D3
        db      OP_CALL, 3      ; $D4
        db      OP_PUSH, 1      ; $D5
        db      OP_SUB,  2      ; $D6
        db      OP_RST,  1      ; $D7
        db      OP_RET,  1      ; $D8
        db      OP_EXX,  1      ; $D9
        db      OP_JP,   3      ; $DA
        db      OP_IN,   2      ; $DB
        db      OP_CALL, 3      ; $DC
        db      OP_INV,  0      ; $DD
        db      OP_SBC,  2      ; $DE
        db      OP_RST,  1      ; $DF
        db      OP_RET,  1      ; $E0
        db      OP_POP,  1      ; $E1
        db      OP_JP,   3      ; $E2
        db      OP_EX,   1      ; $E3
        db      OP_CALL, 3      ; $E4
        db      OP_PUSH, 1      ; $E5
        db      OP_AND,  2      ; $E6
        db      OP_RST,  1      ; $E7
        db      OP_RET,  1      ; $E8
        db      OP_JP,   1      ; $E9
        db      OP_JP,   3      ; $EA
        db      OP_EX,   1      ; $EB
        db      OP_CALL, 3      ; $EC
        db      OP_INV,  0      ; $ED
        db      OP_XOR,  2      ; $EE
        db      OP_RST,  1      ; $EF
        db      OP_RET,  1      ; $F0
        db      OP_POP,  1      ; $F1
        db      OP_JP,   3      ; $F2
        db      OP_DI,   1      ; $F3
        db      OP_CALL, 3      ; $F4
        db      OP_PUSH, 1      ; $F5
        db      OP_OR,   2      ; $F6
        db      OP_RST,  1      ; $F7
        db      OP_RET,  1      ; $F8
        db      OP_LD,   1      ; $F9
        db      OP_JP,   3      ; $FA
        db      OP_EI,   1      ; $FB
        db      OP_CALL, 3      ; $FC
        db      OP_INV,  0      ; $FD
        db      OP_CP,   2      ; $FE
        db      OP_RST,  1      ; $FF

; Lookup table of opcodes and instruction lengths for multibyte
; instructions: 0xcb, 0xdd, 0xed, 0xfd. We can combine 0xdd and 0xfd
; since instructions are the same.

CBOPCODES:
        db      OP_RLC,  2      ; $CB00
        db      OP_RLC,  2      ; $CB01
        db      OP_RLC,  2      ; $CB02
        db      OP_RLC,  2      ; $CB03
        db      OP_RLC,  2      ; $CB04
        db      OP_RLC,  2      ; $CB05
        db      OP_RLC,  2      ; $CB06
        db      OP_RLC,  2      ; $CB07
        db      OP_RRC,  2      ; $CB08
        db      OP_RRC,  2      ; $CB09
        db      OP_RRC,  2      ; $CB0A
        db      OP_RRC,  2      ; $CB0B
        db      OP_RRC,  2      ; $CB0C
        db      OP_RRC,  2      ; $CB0D
        db      OP_RRC,  2      ; $CB0E
        db      OP_RRC,  2      ; $CB0F
        db      OP_RL,   2      ; $CB10
        db      OP_RL,   2      ; $CB11
        db      OP_RL,   2      ; $CB12
        db      OP_RL,   2      ; $CB13
        db      OP_RL,   2      ; $CB14
        db      OP_RL,   2      ; $CB15
        db      OP_RL,   2      ; $CB16
        db      OP_RL,   2      ; $CB17
        db      OP_RR,   2      ; $CB18
        db      OP_RR,   2      ; $CB19
        db      OP_RR,   2      ; $CB1A
        db      OP_RR,   2      ; $CB1B
        db      OP_RR,   2      ; $CB1C
        db      OP_RR,   2      ; $CB1D
        db      OP_RR,   2      ; $CB1E
        db      OP_RR,   2      ; $CB1F
        db      OP_SLA,  2      ; $CB20
        db      OP_SLA,  2      ; $CB21
        db      OP_SLA,  2      ; $CB22
        db      OP_SLA,  2      ; $CB23
        db      OP_SLA,  2      ; $CB24
        db      OP_SLA,  2      ; $CB25
        db      OP_SLA,  2      ; $CB26
        db      OP_SLA,  2      ; $CB27
        db      OP_SRA,  2      ; $CB28
        db      OP_SRA,  2      ; $CB29
        db      OP_SRA,  2      ; $CB2A
        db      OP_SRA,  2      ; $CB2B
        db      OP_SRA,  2      ; $CB2C
        db      OP_SRA,  2      ; $CB2D
        db      OP_SRA,  2      ; $CB2E
        db      OP_SRA,  2      ; $CB2F
        db      OP_SRL,  2      ; $CB38
        db      OP_SRL,  2      ; $CB39
        db      OP_SRL,  2      ; $CB3A
        db      OP_SRL,  2      ; $CB3B
        db      OP_SRL,  2      ; $CB3C
        db      OP_SRL,  2      ; $CB3D
        db      OP_SRL,  2      ; $CB3E
        db      OP_SRL,  2      ; $CB3F
        db      OP_BIT,  2      ; $CB40
        db      OP_BIT,  2      ; $CB41
        db      OP_BIT,  2      ; $CB42
        db      OP_BIT,  2      ; $CB43
        db      OP_BIT,  2      ; $CB44
        db      OP_BIT,  2      ; $CB45
        db      OP_BIT,  2      ; $CB46
        db      OP_BIT,  2      ; $CB47
        db      OP_BIT,  2      ; $CB48
        db      OP_BIT,  2      ; $CB49
        db      OP_BIT,  2      ; $CB4A
        db      OP_BIT,  2      ; $CB4B
        db      OP_BIT,  2      ; $CB4C
        db      OP_BIT,  2      ; $CB4D
        db      OP_BIT,  2      ; $CB4E
        db      OP_BIT,  2      ; $CB4F
        db      OP_BIT,  2      ; $CB50
        db      OP_BIT,  2      ; $CB51
        db      OP_BIT,  2      ; $CB52
        db      OP_BIT,  2      ; $CB53
        db      OP_BIT,  2      ; $CB54
        db      OP_BIT,  2      ; $CB55
        db      OP_BIT,  2      ; $CB56
        db      OP_BIT,  2      ; $CB57
        db      OP_BIT,  2      ; $CB58
        db      OP_BIT,  2      ; $CB59
        db      OP_BIT,  2      ; $CB5A
        db      OP_BIT,  2      ; $CB5B
        db      OP_BIT,  2      ; $CB5C
        db      OP_BIT,  2      ; $CB5D
        db      OP_BIT,  2      ; $CB5E
        db      OP_BIT,  2      ; $CB5F
        db      OP_BIT,  2      ; $CB60
        db      OP_BIT,  2      ; $CB61
        db      OP_BIT,  2      ; $CB62
        db      OP_BIT,  2      ; $CB63
        db      OP_BIT,  2      ; $CB64
        db      OP_BIT,  2      ; $CB65
        db      OP_BIT,  2      ; $CB66
        db      OP_BIT,  2      ; $CB67
        db      OP_BIT,  2      ; $CB68
        db      OP_BIT,  2      ; $CB69
        db      OP_BIT,  2      ; $CB6A
        db      OP_BIT,  2      ; $CB6B
        db      OP_BIT,  2      ; $CB6C
        db      OP_BIT,  2      ; $CB6D
        db      OP_BIT,  2      ; $CB6E
        db      OP_BIT,  2      ; $CB6F
        db      OP_BIT,  2      ; $CB70
        db      OP_BIT,  2      ; $CB71
        db      OP_BIT,  2      ; $CB72
        db      OP_BIT,  2      ; $CB73
        db      OP_BIT,  2      ; $CB74
        db      OP_BIT,  2      ; $CB75
        db      OP_BIT,  2      ; $CB76
        db      OP_BIT,  2      ; $CB77
        db      OP_BIT,  2      ; $CB78
        db      OP_BIT,  2      ; $CB79
        db      OP_BIT,  2      ; $CB7A
        db      OP_BIT,  2      ; $CB7B
        db      OP_BIT,  2      ; $CB7C
        db      OP_BIT,  2      ; $CB7D
        db      OP_BIT,  2      ; $CB7E
        db      OP_BIT,  2      ; $CB7F
        db      OP_RES,  2      ; $CB80
        db      OP_RES,  2      ; $CB81
        db      OP_RES,  2      ; $CB82
        db      OP_RES,  2      ; $CB83
        db      OP_RES,  2      ; $CB84
        db      OP_RES,  2      ; $CB85
        db      OP_RES,  2      ; $CB86
        db      OP_RES,  2      ; $CB87
        db      OP_RES,  2      ; $CB88
        db      OP_RES,  2      ; $CB89
        db      OP_RES,  2      ; $CB8A
        db      OP_RES,  2      ; $CB8B
        db      OP_RES,  2      ; $CB8C
        db      OP_RES,  2      ; $CB8D
        db      OP_RES,  2      ; $CB8E
        db      OP_RES,  2      ; $CB8F
        db      OP_RES,  2      ; $CB90
        db      OP_RES,  2      ; $CB91
        db      OP_RES,  2      ; $CB92
        db      OP_RES,  2      ; $CB93
        db      OP_RES,  2      ; $CB94
        db      OP_RES,  2      ; $CB95
        db      OP_RES,  2      ; $CB96
        db      OP_RES,  2      ; $CB97
        db      OP_RES,  2      ; $CB98
        db      OP_RES,  2      ; $CB99
        db      OP_RES,  2      ; $CB9A
        db      OP_RES,  2      ; $CB9B
        db      OP_RES,  2      ; $CB9C
        db      OP_RES,  2      ; $CB9D
        db      OP_RES,  2      ; $CB9E
        db      OP_RES,  2      ; $CB9F
        db      OP_RES,  2      ; $CBA0
        db      OP_RES,  2      ; $CBA1
        db      OP_RES,  2      ; $CBA2
        db      OP_RES,  2      ; $CBA3
        db      OP_RES,  2      ; $CBA4
        db      OP_RES,  2      ; $CBA5
        db      OP_RES,  2      ; $CBA6
        db      OP_RES,  2      ; $CBA7
        db      OP_RES,  2      ; $CBA8
        db      OP_RES,  2      ; $CBA9
        db      OP_RES,  2      ; $CBAA
        db      OP_RES,  2      ; $CBAB
        db      OP_RES,  2      ; $CBAC
        db      OP_RES,  2      ; $CBAD
        db      OP_RES,  2      ; $CBAE
        db      OP_RES,  2      ; $CBAF
        db      OP_RES,  2      ; $CBB0
        db      OP_RES,  2      ; $CBB1
        db      OP_RES,  2      ; $CBB2
        db      OP_RES,  2      ; $CBB3
        db      OP_RES,  2      ; $CBB4
        db      OP_RES,  2      ; $CBB5
        db      OP_RES,  2      ; $CBB6
        db      OP_RES,  2      ; $CBB7
        db      OP_RES,  2      ; $CBB8
        db      OP_RES,  2      ; $CBB9
        db      OP_RES,  2      ; $CBBA
        db      OP_RES,  2      ; $CBBB
        db      OP_RES,  2      ; $CBBC
        db      OP_RES,  2      ; $CBBD
        db      OP_RES,  2      ; $CBBE
        db      OP_RES,  2      ; $CBBF
        db      OP_SET,  2      ; $CBC0
        db      OP_SET,  2      ; $CBC1
        db      OP_SET,  2      ; $CBC2
        db      OP_SET,  2      ; $CBC3
        db      OP_SET,  2      ; $CBC4
        db      OP_SET,  2      ; $CBC5
        db      OP_SET,  2      ; $CBC6
        db      OP_SET,  2      ; $CBC7
        db      OP_SET,  2      ; $CBC8
        db      OP_SET,  2      ; $CBC9
        db      OP_SET,  2      ; $CBCA
        db      OP_SET,  2      ; $CBCB
        db      OP_SET,  2      ; $CBCC
        db      OP_SET,  2      ; $CBCD
        db      OP_SET,  2      ; $CBCE
        db      OP_SET,  2      ; $CBCF
        db      OP_SET,  2      ; $CBD0
        db      OP_SET,  2      ; $CBD1
        db      OP_SET,  2      ; $CBD2
        db      OP_SET,  2      ; $CBD3
        db      OP_SET,  2      ; $CBD4
        db      OP_SET,  2      ; $CBD5
        db      OP_SET,  2      ; $CBD6
        db      OP_SET,  2      ; $CBD7
        db      OP_SET,  2      ; $CBD8
        db      OP_SET,  2      ; $CBD9
        db      OP_SET,  2      ; $CBDA
        db      OP_SET,  2      ; $CBDB
        db      OP_SET,  2      ; $CBDC
        db      OP_SET,  2      ; $CBDD
        db      OP_SET,  2      ; $CBDE
        db      OP_SET,  2      ; $CBDF
        db      OP_SET,  2      ; $CBE0
        db      OP_SET,  2      ; $CBE1
        db      OP_SET,  2      ; $CBE2
        db      OP_SET,  2      ; $CBE3
        db      OP_SET,  2      ; $CBE4
        db      OP_SET,  2      ; $CBE5
        db      OP_SET,  2      ; $CBE6
        db      OP_SET,  2      ; $CBE7
        db      OP_SET,  2      ; $CBE8
        db      OP_SET,  2      ; $CBE9
        db      OP_SET,  2      ; $CBEA
        db      OP_SET,  2      ; $CBEB
        db      OP_SET,  2      ; $CBEC
        db      OP_SET,  2      ; $CBED
        db      OP_SET,  2      ; $CBEE
        db      OP_SET,  2      ; $CBEF
        db      OP_SET,  2      ; $CBF0
        db      OP_SET,  2      ; $CBF1
        db      OP_SET,  2      ; $CBF2
        db      OP_SET,  2      ; $CBF3
        db      OP_SET,  2      ; $CBF4
        db      OP_SET,  2      ; $CBF5
        db      OP_SET,  2      ; $CBF6
        db      OP_SET,  2      ; $CBF7
        db      OP_SET,  2      ; $CBF8
        db      OP_SET,  2      ; $CBF9
        db      OP_SET,  2      ; $CBFA
        db      OP_SET,  2      ; $CBFB
        db      OP_SET,  2      ; $CBFC
        db      OP_SET,  2      ; $CBFD
        db      OP_SET,  2      ; $CBFE
        db      OP_SET,  2      ; $CBFF

DDOPCODES:
        db      OP_ADD,  2      ; $DD09
        db      OP_ADD,  2      ; $DD19
        db      OP_LD,   4      ; $DD21
        db      OP_LD,   4      ; $DD22
        db      OP_INC,  2      ; $DD23
        db      OP_ADD,  2      ; $DD29
        db      OP_LD,   4      ; $DD2A
        db      OP_DEC,  2      ; $DD2B
        db      OP_INC,  3      ; $DD34
        db      OP_DEC,  3      ; $DD35
        db      OP_LD,   4      ; $DD36
        db      OP_ADD,  2      ; $DD39
        db      OP_LD,   3      ; $DD46
        db      OP_LD,   3      ; $DD4E
        db      OP_LD,   3      ; $DD56
        db      OP_LD,   3      ; $DD5E
        db      OP_LD,   3      ; $DD66
        db      OP_LD,   3      ; $DD6E
        db      OP_LD,   3      ; $DD70
        db      OP_LD,   3      ; $DD71
        db      OP_LD,   3      ; $DD72
        db      OP_LD,   3      ; $DD73
        db      OP_LD,   3      ; $DD74
        db      OP_LD,   3      ; $DD75
        db      OP_LD,   3      ; $DD77
        db      OP_LD,   3      ; $DD7E
        db      OP_ADD,  3      ; $DD86
        db      OP_ADC,  3      ; $DD8E
        db      OP_SUB,  3      ; $DD96
        db      OP_SBC,  3      ; $DD9E
        db      OP_AND,  3      ; $DDA6
        db      OP_XOR,  3      ; $DDAE
        db      OP_OR,   3      ; $DDB6
        db      OP_CP,   3      ; $DDBE
        db      OP_ADC,  3      ; $DD8E

EDOPCODES:
        db      OP_IN,   2      ; $ED40
        db      OP_OUT,  2      ; $ED41
        db      OP_SBC,  2      ; $ED42
        db      OP_LD,   4      ; $ED43
        db      OP_NEG,  2      ; $ED44
        db      OP_RETN, 2      ; $ED45
        db      OP_IM,   2      ; $ED46
        db      OP_LD,   2      ; $ED47
        db      OP_IN,   2      ; $ED48
        db      OP_OUT,  2      ; $ED49
        db      OP_ADC,  2      ; $ED4A
        db      OP_LD,   4      ; $ED4B
        db      OP_RETI, 2      ; $ED4D
        db      OP_LD,   2      ; $ED4F
        db      OP_IN,   2      ; $ED50
        db      OP_OUT,  2      ; $ED51
        db      OP_SBC,  2      ; $ED52
        db      OP_LD,   4      ; $ED53
        db      OP_IM,   2      ; $ED56
        db      OP_LD,   2      ; $ED57
        db      OP_IN,   2      ; $ED58
        db      OP_OUT,  2      ; $ED59
        db      OP_ADC,  2      ; $ED5A
        db      OP_LD,   4      ; $ED5B
        db      OP_IM,   2      ; $ED5E
        db      OP_LD,   2      ; $ED5F
        db      OP_IN,   2      ; $ED60
        db      OP_OUT,  2      ; $ED61
        db      OP_SBC,  2      ; $ED62
        db      OP_RRD,  2      ; $ED67
        db      OP_IN,   2      ; $ED68
        db      OP_OUT,  2      ; $ED69
        db      OP_ADC,  2      ; $ED6A
        db      OP_RLD,  2      ; $ED6F
        db      OP_SBC,  2      ; $ED72
        db      OP_LD,   4      ; $ED73
        db      OP_IN,   2      ; $ED76
        db      OP_OUT,  2      ; $ED79
        db      OP_ADC,  2      ; $ED7A
        db      OP_LD,   4      ; $ED7B
        db      OP_LDI,  2      ; $EDA0
        db      OP_CPI,  2      ; $EDA1
        db      OP_INI,  2      ; $EDA2
        db      OP_OUTI, 2      ; $EDA3
        db      OP_LDD,  2      ; $EDA8
        db      OP_CPD,  2      ; $EDA9
        db      OP_IND,  2      ; $EDAA
        db      OP_OUTD, 2      ; $EDAB
        db      OP_LDIR, 2      ; $EDB0
        db      OP_CPIR, 2      ; $EDB1
        db      OP_INIR, 2      ; $EDB2
        db      OP_OTIR, 2      ; $EDB3
        db      OP_LDDR, 2      ; $EDB8
        db      OP_CPDR, 2      ; $EDB9
        db      OP_INDR, 2      ; $EDBA
        db      OP_OTDR, 2      ; $EDBB

; Disasemble pseudocode

; Get instruction at current address
; Read OPCODES table to get instruction and length
; Get mnemonic string using instruction to index into MNEMONICS table
; Print address, length bytes, opcode string
; Increment instruction address by length
; e.g.
; 0122 01           NOP
; 0123 ED 5F        LD
; 0125 32 09 FF     LD
; 0128 DD 22 0E FF  LD
; 012C FD 22 10 FF  LD
; 0130 F5           PUSH
; 0131 C1           POP
; 0132 79           LD
; 0133 32 01 FF     LD
; 0136 21 00 F0     LD
; 0139 7C           LD
; 013A 32 0A FF     LD

ADDRESS:  DS    2
OPCODE:   DS    1
MNEMONIC: DS    1   
LEN:      DS    1

        ld      hl,$0100        ; Start address to disassemble
        ld      (ADDRESS),hl

        ld      hl,(ADDRESS)    ; Get address of instruction, e.g. $0100
        ld      b,0             ; Clear upper byte of BC
        ld      c,(hl)          ; Get the opcode, e.g. $00 = NOP
        sla     c               ; Multiply by 2 because 2 bytes per entry
        ld      hl,OPCODES      ; Get start address of opcode table
        add     hl,bc           ; Add opcode
        ld      a,(hl)          ; Get the opcode, e.g. OP_NOP
        ld      (OPCODE),a      ; Save it

        inc     hl              ; Advance to instruction length entry in table
        ld      a,(hl)          ; Get length
        ld      (LEN),a         ; Save it

        ld      hl,MNEMONICS    ; Get start address of mnemonics table
        ld      b,0             ; Clear upper byte of BC
        ld      c,(hl)          ; Get the mnemonic, e.g. $23 = OP_NOP
        sla     c               ; Multiply by 4 because 4 bytes per entry
        sla     c
        add     hl,bc           ; Add index to address of table
        ld      (MNEMONIC),hl   ; Save address of mnemonic string
