
;CodeVisionAVR C Compiler V3.51 Evaluation
;(C) Copyright 1998-2023 Pavel Haiduc, HP InfoTech S.R.L.
;http://www.hpinfotech.ro

;Build configuration    : Debug
;Chip type              : ATmega164A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega164A
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU SPMCSR=0x37
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x04FF
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.EQU __FLASH_PAGE_SIZE=0x40
	.EQU __EEPROM_PAGE_SIZE=0x04

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETW1P
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETD1P_INC
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	.ENDM

	.MACRO __GETD1P_DEC
	LD   R23,-X
	LD   R22,-X
	LD   R31,-X
	LD   R30,-X
	.ENDM

	.MACRO __PUTDP1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTDP1_DEC
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __CPD10
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	.ENDM

	.MACRO __CPD20
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	.ENDM

	.MACRO __ADDD12
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	.ENDM

	.MACRO __ADDD21
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	.ENDM

	.MACRO __SUBD12
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	.ENDM

	.MACRO __SUBD21
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	.ENDM

	.MACRO __ANDD12
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	.ENDM

	.MACRO __ORD12
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	.ENDM

	.MACRO __XORD12
	EOR  R30,R26
	EOR  R31,R27
	EOR  R22,R24
	EOR  R23,R25
	.ENDM

	.MACRO __XORD21
	EOR  R26,R30
	EOR  R27,R31
	EOR  R24,R22
	EOR  R25,R23
	.ENDM

	.MACRO __COMD1
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	.ENDM

	.MACRO __MULD2_2
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	.ENDM

	.MACRO __LSRD1
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	.ENDM

	.MACRO __LSLD1
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	.ENDM

	.MACRO __ASRB4
	ASR  R30
	ASR  R30
	ASR  R30
	ASR  R30
	.ENDM

	.MACRO __ASRW8
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	.ENDM

	.MACRO __LSRD16
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	.ENDM

	.MACRO __LSLD16
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	.ENDM

	.MACRO __CWD1
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	.ENDM

	.MACRO __CWD2
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	.ENDM

	.MACRO __SETMSD1
	SER  R31
	SER  R22
	SER  R23
	.ENDM

	.MACRO __ADDW1R15
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	.ENDM

	.MACRO __ADDW2R15
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	.ENDM

	.MACRO __EQB12
	CP   R30,R26
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __NEB12
	CP   R30,R26
	LDI  R30,1
	BRNE PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12
	CP   R30,R26
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12
	CP   R26,R30
	LDI  R30,1
	BRGE PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12
	CP   R26,R30
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12
	CP   R30,R26
	LDI  R30,1
	BRLT PC+2
	CLR  R30
	.ENDM

	.MACRO __LEB12U
	CP   R30,R26
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __GEB12U
	CP   R26,R30
	LDI  R30,1
	BRSH PC+2
	CLR  R30
	.ENDM

	.MACRO __LTB12U
	CP   R26,R30
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __GTB12U
	CP   R30,R26
	LDI  R30,1
	BRLO PC+2
	CLR  R30
	.ENDM

	.MACRO __CPW01
	CLR  R0
	CP   R0,R30
	CPC  R0,R31
	.ENDM

	.MACRO __CPW02
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	.ENDM

	.MACRO __CPD12
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	.ENDM

	.MACRO __CPD21
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	.ENDM

	.MACRO __BSTB1
	CLT
	TST  R30
	BREQ PC+2
	SET
	.ENDM

	.MACRO __LNEGB1
	TST  R30
	LDI  R30,1
	BREQ PC+2
	CLR  R30
	.ENDM

	.MACRO __LNEGW1
	OR   R30,R31
	LDI  R30,1
	BREQ PC+2
	LDI  R30,0
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETW1Z
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CALL __GETD1Z
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETW2X
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __GETD2X
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _twi_int_handler
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x0:
	.DB  0x58,0x2D,0x61,0x78,0x69,0x73,0x20,0x61
	.DB  0x63,0x63,0x65,0x6C,0x65,0x72,0x61,0x74
	.DB  0x69,0x6F,0x6E,0x3A,0x20,0x25,0x64,0x3B
	.DB  0x0,0xD,0xA,0x0
_0x2000003:
	.DB  0x7

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _twi_result
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0x00

	.DSEG
	.ORG 0x200

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
;void switchLed(int led_no){
; 0000 0018 void switchLed(int led_no){

	.CSEG
_switchLed:
; .FSTART _switchLed
; 0000 0019 if(led_no==0){
	ST   -Y,R17
	ST   -Y,R16
	MOVW R16,R26
;	led_no -> R16,R17
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x3
; 0000 001A led0=1;
	SBI  0x5,0
; 0000 001B }else{
	RJMP _0x6
_0x3:
; 0000 001C led0=0;
	CBI  0x5,0
; 0000 001D }
_0x6:
; 0000 001E if(led_no==1){
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x9
; 0000 001F led1=1;
	SBI  0x5,1
; 0000 0020 }else{
	RJMP _0xC
_0x9:
; 0000 0021 led1=0;
	CBI  0x5,1
; 0000 0022 }
_0xC:
; 0000 0023 if(led_no==2){
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0xF
; 0000 0024 led2=1;
	SBI  0x5,2
; 0000 0025 }else{
	RJMP _0x12
_0xF:
; 0000 0026 led2=0;
	CBI  0x5,2
; 0000 0027 }
_0x12:
; 0000 0028 if(led_no==3){
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x15
; 0000 0029 led3=1;
	SBI  0x5,3
; 0000 002A }else{
	RJMP _0x18
_0x15:
; 0000 002B led3=0;
	CBI  0x5,3
; 0000 002C }
_0x18:
; 0000 002D if(led_no==4){
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x1B
; 0000 002E led4=1;
	SBI  0x5,4
; 0000 002F }else{
	RJMP _0x1E
_0x1B:
; 0000 0030 led4=0;
	CBI  0x5,4
; 0000 0031 }
_0x1E:
; 0000 0032 if(led_no==5){
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x21
; 0000 0033 led5=1;
	SBI  0x5,5
; 0000 0034 }else{
	RJMP _0x24
_0x21:
; 0000 0035 led5=0;
	CBI  0x5,5
; 0000 0036 }
_0x24:
; 0000 0037 if(led_no==6){
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x27
; 0000 0038 led6=1;
	SBI  0x5,6
; 0000 0039 }else{
	RJMP _0x2A
_0x27:
; 0000 003A led6=0;
	CBI  0x5,6
; 0000 003B }
_0x2A:
; 0000 003C }
	RJMP _0x2080003
; .FEND
;void calibrateAxis(int y_axis){
; 0000 003D void calibrateAxis(int y_axis){
_calibrateAxis:
; .FSTART _calibrateAxis
; 0000 003E //-17 <=> 17
; 0000 003F y_axis+=17;
	ST   -Y,R17
	ST   -Y,R16
	MOVW R16,R26
;	y_axis -> R16,R17
	__ADDWRN 16,17,17
; 0000 0040 // 0<=>34
; 0000 0041 if(y_axis<=5)
	__CPWRN 16,17,6
	BRGE _0x2D
; 0000 0042 switchLed(6);
	LDI  R26,LOW(6)
	RJMP _0x42
; 0000 0043 else if(y_axis<=10)
_0x2D:
	__CPWRN 16,17,11
	BRGE _0x2F
; 0000 0044 switchLed(5);
	LDI  R26,LOW(5)
	RJMP _0x42
; 0000 0045 else if(y_axis<=15)
_0x2F:
	__CPWRN 16,17,16
	BRGE _0x31
; 0000 0046 switchLed(4);
	LDI  R26,LOW(4)
	RJMP _0x42
; 0000 0047 else if(y_axis<=20)
_0x31:
	__CPWRN 16,17,21
	BRGE _0x33
; 0000 0048 switchLed(3);
	LDI  R26,LOW(3)
	RJMP _0x42
; 0000 0049 else if(y_axis<=25)
_0x33:
	__CPWRN 16,17,26
	BRGE _0x35
; 0000 004A switchLed(2);
	LDI  R26,LOW(2)
	RJMP _0x42
; 0000 004B else if(y_axis<=30)
_0x35:
	__CPWRN 16,17,31
	BRGE _0x37
; 0000 004C switchLed(1);
	LDI  R26,LOW(1)
	RJMP _0x42
; 0000 004D else if(y_axis<=35)
_0x37:
	__CPWRN 16,17,36
	BRGE _0x39
; 0000 004E switchLed(0);
	LDI  R26,LOW(0)
_0x42:
	LDI  R27,0
	RCALL _switchLed
; 0000 004F }
_0x39:
_0x2080003:
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;void main(void)
; 0000 0051 {
_main:
; .FSTART _main
; 0000 0052 // Declare your local variables here
; 0000 0053 int x_accel, y_accel, z_accel;
; 0000 0054 unsigned char accel_data[6];
; 0000 0055 unsigned char  accel_reg;
; 0000 0056 int counter=0;
; 0000 0057 // Configure MPU6050
; 0000 0058 unsigned char config_data[] = { 0x6B, 0x00 }; // Set PWR_MGMT_1 register to 0x00 to wake up the sensor
; 0000 0059 // Crystal Oscillator division factor: 1
; 0000 005A #pragma optsize-
; 0000 005B CLKPR=(1<<CLKPCE);
	SBIW R28,11
	LDI  R30,LOW(107)
	ST   Y,R30
	LDI  R30,LOW(0)
	STD  Y+1,R30
	STD  Y+2,R30
	STD  Y+3,R30
;	x_accel -> R16,R17
;	y_accel -> R18,R19
;	z_accel -> R20,R21
;	accel_data -> Y+5
;	accel_reg -> Y+4
;	counter -> Y+2
;	config_data -> Y+0
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 005C CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 005D #ifdef _OPTIMIZE_SIZE_
; 0000 005E #pragma optsize+
; 0000 005F #endif
; 0000 0060 
; 0000 0061 // Input/Output Ports initialization
; 0000 0062 // Port A initialization
; 0000 0063 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0064 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	OUT  0x1,R30
; 0000 0065 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0066 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x2,R30
; 0000 0067 
; 0000 0068 // Port B initialization
; 0000 0069 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 006A DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
	LDI  R30,LOW(255)
	OUT  0x4,R30
; 0000 006B // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 006C PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x5,R30
; 0000 006D 
; 0000 006E // Port C initialization
; 0000 006F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0070 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x7,R30
; 0000 0071 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0072 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x8,R30
; 0000 0073 
; 0000 0074 // Port D initialization
; 0000 0075 // Function: Bit7=In Bit6=Out Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0076 DDRD=(0<<DDD7) | (1<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	LDI  R30,LOW(64)
	OUT  0xA,R30
; 0000 0077 // State: Bit7=T Bit6=0 Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0078 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 0079 
; 0000 007A // Timer/Counter 0 initialization
; 0000 007B // Clock source: System Clock
; 0000 007C // Clock value: Timer 0 Stopped
; 0000 007D // Mode: Normal top=0xFF
; 0000 007E // OC0A output: Disconnected
; 0000 007F // OC0B output: Disconnected
; 0000 0080 TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
	OUT  0x24,R30
; 0000 0081 TCCR0B=(0<<WGM02) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x25,R30
; 0000 0082 TCNT0=0x00;
	OUT  0x26,R30
; 0000 0083 OCR0A=0x00;
	OUT  0x27,R30
; 0000 0084 OCR0B=0x00;
	OUT  0x28,R30
; 0000 0085 
; 0000 0086 // Timer/Counter 1 initialization
; 0000 0087 // Clock source: System Clock
; 0000 0088 // Clock value: Timer1 Stopped
; 0000 0089 // Mode: Normal top=0xFFFF
; 0000 008A // OC1A output: Disconnected
; 0000 008B // OC1B output: Disconnected
; 0000 008C // Noise Canceler: Off
; 0000 008D // Input Capture on Falling Edge
; 0000 008E // Timer1 Overflow Interrupt: Off
; 0000 008F // Input Capture Interrupt: Off
; 0000 0090 // Compare A Match Interrupt: Off
; 0000 0091 // Compare B Match Interrupt: Off
; 0000 0092 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	STS  128,R30
; 0000 0093 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	STS  129,R30
; 0000 0094 TCNT1H=0x00;
	STS  133,R30
; 0000 0095 TCNT1L=0x00;
	STS  132,R30
; 0000 0096 ICR1H=0x00;
	STS  135,R30
; 0000 0097 ICR1L=0x00;
	STS  134,R30
; 0000 0098 OCR1AH=0x00;
	STS  137,R30
; 0000 0099 OCR1AL=0x00;
	STS  136,R30
; 0000 009A OCR1BH=0x00;
	STS  139,R30
; 0000 009B OCR1BL=0x00;
	STS  138,R30
; 0000 009C 
; 0000 009D // Timer/Counter 2 initialization
; 0000 009E // Clock source: System Clock
; 0000 009F // Clock value: Timer2 Stopped
; 0000 00A0 // Mode: Normal top=0xFF
; 0000 00A1 // OC2A output: Disconnected
; 0000 00A2 // OC2B output: Disconnected
; 0000 00A3 ASSR=(0<<EXCLK) | (0<<AS2);
	STS  182,R30
; 0000 00A4 TCCR2A=(0<<COM2A1) | (0<<COM2A0) | (0<<COM2B1) | (0<<COM2B0) | (0<<WGM21) | (0<<WGM20);
	STS  176,R30
; 0000 00A5 TCCR2B=(0<<WGM22) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	STS  177,R30
; 0000 00A6 TCNT2=0x00;
	STS  178,R30
; 0000 00A7 OCR2A=0x00;
	STS  179,R30
; 0000 00A8 OCR2B=0x00;
	STS  180,R30
; 0000 00A9 
; 0000 00AA // Timer/Counter 0 Interrupt(s) initialization
; 0000 00AB TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (0<<TOIE0);
	STS  110,R30
; 0000 00AC 
; 0000 00AD // Timer/Counter 1 Interrupt(s) initialization
; 0000 00AE TIMSK1=(0<<ICIE1) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);
	STS  111,R30
; 0000 00AF 
; 0000 00B0 // Timer/Counter 2 Interrupt(s) initialization
; 0000 00B1 TIMSK2=(0<<OCIE2B) | (0<<OCIE2A) | (0<<TOIE2);
	STS  112,R30
; 0000 00B2 
; 0000 00B3 // External Interrupt(s) initialization
; 0000 00B4 // INT0: Off
; 0000 00B5 // INT1: Off
; 0000 00B6 // INT2: Off
; 0000 00B7 // Interrupt on any change on pins PCINT0-7: Off
; 0000 00B8 // Interrupt on any change on pins PCINT8-15: Off
; 0000 00B9 // Interrupt on any change on pins PCINT16-23: Off
; 0000 00BA // Interrupt on any change on pins PCINT24-31: Off
; 0000 00BB EICRA=(0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	STS  105,R30
; 0000 00BC EIMSK=(0<<INT2) | (0<<INT1) | (0<<INT0);
	OUT  0x1D,R30
; 0000 00BD PCICR=(0<<PCIE3) | (0<<PCIE2) | (0<<PCIE1) | (0<<PCIE0);
	STS  104,R30
; 0000 00BE 
; 0000 00BF // USART0 initialization
; 0000 00C0 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 00C1 // USART0 Receiver: On
; 0000 00C2 // USART0 Transmitter: On
; 0000 00C3 // USART0 Mode: Asynchronous
; 0000 00C4 // USART0 Baud Rate: 9600
; 0000 00C5 UCSR0A=(0<<RXC0) | (0<<TXC0) | (0<<UDRE0) | (0<<FE0) | (0<<DOR0) | (0<<UPE0) | (0<<U2X0) | (0<<MPCM0);
	STS  192,R30
; 0000 00C6 UCSR0B=(0<<RXCIE0) | (0<<TXCIE0) | (0<<UDRIE0) | (1<<RXEN0) | (1<<TXEN0) | (0<<UCSZ02) | (0<<RXB80) | (0<<TXB80);
	LDI  R30,LOW(24)
	STS  193,R30
; 0000 00C7 UCSR0C=(0<<UMSEL01) | (0<<UMSEL00) | (0<<UPM01) | (0<<UPM00) | (0<<USBS0) | (1<<UCSZ01) | (1<<UCSZ00) | (0<<UCPOL0);
	LDI  R30,LOW(6)
	STS  194,R30
; 0000 00C8 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  197,R30
; 0000 00C9 UBRR0L=0x81;
	LDI  R30,LOW(129)
	STS  196,R30
; 0000 00CA 
; 0000 00CB // USART1 initialization
; 0000 00CC // USART1 disabled
; 0000 00CD UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	LDI  R30,LOW(0)
	STS  201,R30
; 0000 00CE 
; 0000 00CF // Analog Comparator initialization
; 0000 00D0 // Analog Comparator: Off
; 0000 00D1 // The Analog Comparator's positive input is
; 0000 00D2 // connected to the AIN0 pin
; 0000 00D3 // The Analog Comparator's negative input is
; 0000 00D4 // connected to the AIN1 pin
; 0000 00D5 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 00D6 ADCSRB=(0<<ACME);
	LDI  R30,LOW(0)
	STS  123,R30
; 0000 00D7 // Digital input buffer on AIN0: On
; 0000 00D8 // Digital input buffer on AIN1: On
; 0000 00D9 DIDR1=(0<<AIN0D) | (0<<AIN1D);
	STS  127,R30
; 0000 00DA 
; 0000 00DB // ADC initialization
; 0000 00DC // ADC disabled
; 0000 00DD ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	STS  122,R30
; 0000 00DE 
; 0000 00DF // SPI initialization
; 0000 00E0 // SPI disabled
; 0000 00E1 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0x2C,R30
; 0000 00E2 
; 0000 00E3 // TWI initialization
; 0000 00E4 // Mode: TWI Master
; 0000 00E5 // Bit Rate: 96 kHz
; 0000 00E6 twi_master_init(96);
	LDI  R26,LOW(96)
	LDI  R27,0
	RCALL _twi_master_init
; 0000 00E7 
; 0000 00E8 // Globally enable interrupts
; 0000 00E9 #asm("sei")
	SEI
; 0000 00EA 
; 0000 00EB twi_master_trans(MPU6050_ADDR, config_data, 2, NULL, 0); // Write to MPU6050
	LDI  R30,LOW(104)
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _twi_master_trans
; 0000 00EC 
; 0000 00ED // Read accelerometer data
; 0000 00EE accel_reg = 0x3B;
	LDI  R30,LOW(59)
	STD  Y+4,R30
; 0000 00EF // Starting register address for accelerometer data
; 0000 00F0 
; 0000 00F1 while (1) {
_0x3A:
; 0000 00F2 
; 0000 00F3 // read accelerometer data from MPU 6050
; 0000 00F4 twi_master_trans(MPU6050_ADDR, &accel_reg, 1, accel_data, 6); // Read from MPU6050
	LDI  R30,LOW(104)
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,5
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,9
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(6)
	RCALL _twi_master_trans
; 0000 00F5 
; 0000 00F6 // Interpret the data
; 0000 00F7 x_accel = (short)((accel_data[0] << 8) | accel_data[1]);
	LDI  R30,0
	LDD  R31,Y+5
	MOVW R26,R30
	LDD  R30,Y+6
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R16,R30
; 0000 00F8 y_accel = (short)((accel_data[2] << 8) | accel_data[3]);
	LDI  R30,0
	LDD  R31,Y+7
	MOVW R26,R30
	LDD  R30,Y+8
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R18,R30
; 0000 00F9 z_accel = (short)((accel_data[4] << 8) | accel_data[5]);
	LDI  R30,0
	LDD  R31,Y+9
	MOVW R26,R30
	LDD  R30,Y+10
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R20,R30
; 0000 00FA led_button=1;
	SBI  0xB,6
; 0000 00FB // print the accelerometer data
; 0000 00FC printf("X-axis acceleration: %d;", y_accel);
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R18
	__CWD1
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
; 0000 00FD if(counter<5){
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,5
	BRGE _0x3F
; 0000 00FE counter++;}
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	STD  Y+2,R30
	STD  Y+2+1,R31
; 0000 00FF printf("\r\n");
_0x3F:
	__POINTW1FN _0x0,25
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
; 0000 0100 if(counter==5){
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,5
	BRNE _0x40
; 0000 0101 calibrateAxis(y_accel/1000);
	MOVW R26,R18
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	RCALL __DIVW21
	MOVW R26,R30
	RCALL _calibrateAxis
; 0000 0102 counter=0;}
	LDI  R30,LOW(0)
	STD  Y+2,R30
	STD  Y+2+1,R30
; 0000 0103 }
_0x40:
	RJMP _0x3A
; 0000 0104 }
_0x41:
	RJMP _0x41
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.DSEG

	.CSEG
_twi_master_init:
; .FSTART _twi_master_init
	RCALL __SAVELOCR4
	MOVW R18,R26
	SBI  0x1E,1
	LDI  R30,LOW(7)
	STS  _twi_result,R30
	LDI  R30,LOW(0)
	STS  _twi_slave_rx_handler_G100,R30
	STS  _twi_slave_rx_handler_G100+1,R30
	STS  _twi_slave_tx_handler_G100,R30
	STS  _twi_slave_tx_handler_G100+1,R30
	CBI  0x8,1
	CBI  0x8,0
	STS  188,R30
	LDS  R30,185
	ANDI R30,LOW(0xFC)
	STS  185,R30
	MOVW R30,R18
	LDI  R26,LOW(4000)
	LDI  R27,HIGH(4000)
	RCALL __DIVW21U
	MOV  R17,R30
	CPI  R17,8
	BRLO _0x2000006
	SUBI R17,LOW(8)
_0x2000006:
	STS  184,R17
	LDS  R30,188
	ANDI R30,LOW(0x80)
	ORI  R30,LOW(0x45)
	STS  188,R30
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
_twi_master_trans:
; .FSTART _twi_master_trans
	SBIW R28,4
	RCALL __SAVELOCR6
	MOV  R17,R26
	__GETWRS 18,19,10
	LDD  R16,Y+12
	__GETWRS 20,21,13
	SBIS 0x1E,1
	RJMP _0x2000007
	LDD  R30,Y+15
	LSL  R30
	STS  _slave_address_G100,R30
	__PUTWMRN _twi_tx_buffer_G100,0,20,21
	LDI  R30,LOW(0)
	STS  _twi_tx_index,R30
	STS  _bytes_to_tx_G100,R16
	__PUTWMRN _twi_rx_buffer_G100,0,18,19
	STS  _twi_rx_index,R30
	STS  _bytes_to_rx_G100,R17
	LDI  R30,LOW(6)
	STS  _twi_result,R30
	SEI
	CPI  R16,0
	BREQ _0x2000008
	MOV  R0,R20
	OR   R0,R21
	BREQ _0x2080002
	CPI  R17,0
	BREQ _0x200000B
	CLR  R0
	CP   R0,R18
	CPC  R0,R19
	BREQ _0x200000C
_0x200000B:
	RJMP _0x200000A
_0x200000C:
	RJMP _0x2080002
_0x200000A:
	SBI  0x1E,0
	RJMP _0x200000F
_0x2000008:
	CPI  R17,0
	BREQ _0x2000010
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x2080002
	LDS  R30,_slave_address_G100
	ORI  R30,1
	STS  _slave_address_G100,R30
	CBI  0x1E,0
_0x200000F:
	CBI  0x1E,1
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xA0)
	STS  188,R30
	__GETD1N 0x7A120
	RCALL SUBOPT_0x0
_0x2000016:
	SBIC 0x1E,1
	RJMP _0x2000018
	__GETD1S 6
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	RCALL SUBOPT_0x0
	BRNE _0x2000019
	LDI  R30,LOW(5)
	STS  _twi_result,R30
	SBI  0x1E,1
	RJMP _0x2080002
_0x2000019:
	RJMP _0x2000016
_0x2000018:
_0x2000010:
	LDS  R26,_twi_result
	LDI  R30,LOW(0)
	__EQB12
	RJMP _0x2080001
_0x2000007:
_0x2080002:
	LDI  R30,LOW(0)
_0x2080001:
	RCALL __LOADLOCR6
	ADIW R28,16
	RET
; .FEND
_twi_int_handler:
; .FSTART _twi_int_handler
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	ST   -Y,R21
	ST   -Y,R20
	ST   -Y,R19
	ST   -Y,R18
	ST   -Y,R17
	ST   -Y,R16
	LDS  R17,_twi_rx_index
	LDS  R16,_twi_tx_index
	LDS  R19,_bytes_to_tx_G100
	LDS  R18,_twi_result
	MOV  R30,R17
	LDS  R26,_twi_rx_buffer_G100
	LDS  R27,_twi_rx_buffer_G100+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R20,R30
	LDS  R30,185
	ANDI R30,LOW(0xF8)
	CPI  R30,LOW(0x8)
	BRNE _0x2000023
	LDI  R18,LOW(0)
	RJMP _0x2000024
_0x2000023:
	CPI  R30,LOW(0x10)
	BRNE _0x2000025
_0x2000024:
	LDS  R30,_slave_address_G100
	RJMP _0x2000080
_0x2000025:
	CPI  R30,LOW(0x18)
	BREQ _0x2000029
	CPI  R30,LOW(0x28)
	BRNE _0x200002A
_0x2000029:
	CP   R16,R19
	BRSH _0x200002B
	MOV  R30,R16
	SUBI R16,-1
	LDS  R26,_twi_tx_buffer_G100
	LDS  R27,_twi_tx_buffer_G100+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
_0x2000080:
	STS  187,R30
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	STS  188,R30
	RJMP _0x200002C
_0x200002B:
	LDS  R30,_bytes_to_rx_G100
	CP   R17,R30
	BRSH _0x200002D
	LDS  R30,_slave_address_G100
	ORI  R30,1
	STS  _slave_address_G100,R30
	CBI  0x1E,0
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xA0)
	STS  188,R30
	RJMP _0x2000022
_0x200002D:
	RJMP _0x2000030
_0x200002C:
	RJMP _0x2000022
_0x200002A:
	CPI  R30,LOW(0x50)
	BRNE _0x2000031
	LDS  R30,187
	MOVW R26,R20
	ST   X,R30
	SUBI R17,-LOW(1)
	RJMP _0x2000032
_0x2000031:
	CPI  R30,LOW(0x40)
	BRNE _0x2000033
_0x2000032:
	LDS  R30,_bytes_to_rx_G100
	SUBI R30,LOW(1)
	CP   R17,R30
	BRLO _0x2000034
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	RJMP _0x2000081
_0x2000034:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
_0x2000081:
	STS  188,R30
	RJMP _0x2000022
_0x2000033:
	CPI  R30,LOW(0x58)
	BRNE _0x2000036
	LDS  R30,187
	MOVW R26,R20
	ST   X,R30
	SUBI R17,-LOW(1)
	RJMP _0x2000037
_0x2000036:
	CPI  R30,LOW(0x20)
	BRNE _0x2000038
_0x2000037:
	RJMP _0x2000039
_0x2000038:
	CPI  R30,LOW(0x30)
	BRNE _0x200003A
_0x2000039:
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x48)
	BRNE _0x200003C
_0x200003B:
	CPI  R18,0
	BRNE _0x200003D
	SBIS 0x1E,0
	RJMP _0x200003E
	CP   R16,R19
	BRLO _0x2000040
	RJMP _0x2000041
_0x200003E:
	LDS  R30,_bytes_to_rx_G100
	CP   R17,R30
	BRSH _0x2000042
_0x2000040:
	LDI  R18,LOW(4)
_0x2000042:
_0x2000041:
_0x200003D:
_0x2000030:
	RJMP _0x2000082
_0x200003C:
	CPI  R30,LOW(0x38)
	BRNE _0x2000045
	LDI  R18,LOW(2)
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	RJMP _0x2000083
_0x2000045:
	CPI  R30,LOW(0x68)
	BREQ _0x2000048
	CPI  R30,LOW(0x78)
	BRNE _0x2000049
_0x2000048:
	LDI  R18,LOW(2)
	RJMP _0x200004A
_0x2000049:
	CPI  R30,LOW(0x60)
	BREQ _0x200004D
	CPI  R30,LOW(0x70)
	BRNE _0x200004E
_0x200004D:
	LDI  R18,LOW(0)
_0x200004A:
	LDI  R17,LOW(0)
	CBI  0x1E,0
	LDS  R30,_twi_rx_buffer_size_G100
	CPI  R30,0
	BRNE _0x2000051
	LDI  R18,LOW(1)
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	RJMP _0x2000084
_0x2000051:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
_0x2000084:
	STS  188,R30
	RJMP _0x2000022
_0x200004E:
	CPI  R30,LOW(0x80)
	BREQ _0x2000054
	CPI  R30,LOW(0x90)
	BRNE _0x2000055
_0x2000054:
	SBIS 0x1E,0
	RJMP _0x2000056
	LDI  R18,LOW(1)
	RJMP _0x2000057
_0x2000056:
	LDS  R30,187
	MOVW R26,R20
	ST   X,R30
	SUBI R17,-LOW(1)
	LDS  R30,_twi_rx_buffer_size_G100
	CP   R17,R30
	BRSH _0x2000058
	LDS  R30,_twi_slave_rx_handler_G100
	LDS  R31,_twi_slave_rx_handler_G100+1
	SBIW R30,0
	BRNE _0x2000059
	LDI  R18,LOW(6)
	RJMP _0x2000057
_0x2000059:
	LDI  R26,LOW(0)
	__CALL1MN _twi_slave_rx_handler_G100,0
	CPI  R30,0
	BREQ _0x200005A
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	STS  188,R30
	RJMP _0x2000022
_0x200005A:
	RJMP _0x200005B
_0x2000058:
	SBI  0x1E,0
_0x200005B:
	RJMP _0x200005E
_0x2000055:
	CPI  R30,LOW(0x88)
	BRNE _0x200005F
_0x200005E:
	RJMP _0x2000060
_0x200005F:
	CPI  R30,LOW(0x98)
	BRNE _0x2000061
_0x2000060:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
	STS  188,R30
	RJMP _0x2000022
_0x2000061:
	CPI  R30,LOW(0xA0)
	BRNE _0x2000062
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	STS  188,R30
	SBI  0x1E,1
	LDS  R30,_twi_slave_rx_handler_G100
	LDS  R31,_twi_slave_rx_handler_G100+1
	SBIW R30,0
	BREQ _0x2000065
	LDI  R26,LOW(1)
	__CALL1MN _twi_slave_rx_handler_G100,0
	RJMP _0x2000066
_0x2000065:
	LDI  R18,LOW(6)
_0x2000066:
	RJMP _0x2000022
_0x2000062:
	CPI  R30,LOW(0xB0)
	BRNE _0x2000067
	LDI  R18,LOW(2)
	RJMP _0x2000068
_0x2000067:
	CPI  R30,LOW(0xA8)
	BRNE _0x2000069
_0x2000068:
	LDS  R30,_twi_slave_tx_handler_G100
	LDS  R31,_twi_slave_tx_handler_G100+1
	SBIW R30,0
	BREQ _0x200006A
	LDI  R26,LOW(0)
	__CALL1MN _twi_slave_tx_handler_G100,0
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x200006C
	LDI  R18,LOW(0)
	RJMP _0x200006D
_0x200006A:
_0x200006C:
	LDI  R18,LOW(6)
	RJMP _0x2000057
_0x200006D:
	LDI  R16,LOW(0)
	CBI  0x1E,0
	RJMP _0x2000070
_0x2000069:
	CPI  R30,LOW(0xB8)
	BRNE _0x2000071
_0x2000070:
	SBIS 0x1E,0
	RJMP _0x2000072
	LDI  R18,LOW(1)
	RJMP _0x2000057
_0x2000072:
	MOV  R30,R16
	SUBI R16,-1
	LDS  R26,_twi_tx_buffer_G100
	LDS  R27,_twi_tx_buffer_G100+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	STS  187,R30
	CP   R16,R19
	BRSH _0x2000073
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	RJMP _0x2000085
_0x2000073:
	SBI  0x1E,0
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,0x80
_0x2000085:
	STS  188,R30
	RJMP _0x2000022
_0x2000071:
	CPI  R30,LOW(0xC0)
	BREQ _0x2000078
	CPI  R30,LOW(0xC8)
	BRNE _0x2000079
_0x2000078:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xC0)
	STS  188,R30
	LDS  R30,_twi_slave_tx_handler_G100
	LDS  R31,_twi_slave_tx_handler_G100+1
	SBIW R30,0
	BREQ _0x200007A
	LDI  R26,LOW(1)
	__CALL1MN _twi_slave_tx_handler_G100,0
_0x200007A:
	RJMP _0x2000043
_0x2000079:
	CPI  R30,0
	BRNE _0x2000022
	LDI  R18,LOW(3)
_0x2000057:
_0x2000082:
	LDS  R30,188
	ANDI R30,LOW(0xF)
	ORI  R30,LOW(0xD0)
_0x2000083:
	STS  188,R30
_0x2000043:
	SBI  0x1E,1
_0x2000022:
	STS  _twi_rx_index,R17
	STS  _twi_tx_index,R16
	STS  _twi_result,R18
	STS  _bytes_to_tx_G100,R19
	LD   R16,Y+
	LD   R17,Y+
	LD   R18,Y+
	LD   R19,Y+
	LD   R20,Y+
	LD   R21,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
_putchar:
; .FSTART _putchar
	ST   -Y,R17
	MOV  R17,R26
_0x2020006:
	LDS  R30,192
	ANDI R30,LOW(0x20)
	BREQ _0x2020006
	STS  198,R17
	LD   R17,Y+
	RET
; .FEND
_put_usart_G101:
; .FSTART _put_usart_G101
	RCALL __SAVELOCR4
	MOVW R16,R26
	LDD  R19,Y+4
	MOV  R26,R19
	RCALL _putchar
	MOVW R26,R16
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RCALL __LOADLOCR4
	ADIW R28,5
	RET
; .FEND
__print_G101:
; .FSTART __print_G101
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x202001C:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x202001E
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x2020022
	CPI  R18,37
	BRNE _0x2020023
	LDI  R17,LOW(1)
	RJMP _0x2020024
_0x2020023:
	RCALL SUBOPT_0x1
_0x2020024:
	RJMP _0x2020021
_0x2020022:
	CPI  R30,LOW(0x1)
	BRNE _0x2020025
	CPI  R18,37
	BRNE _0x2020026
	RCALL SUBOPT_0x1
	RJMP _0x20200D2
_0x2020026:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2020027
	LDI  R16,LOW(1)
	RJMP _0x2020021
_0x2020027:
	CPI  R18,43
	BRNE _0x2020028
	LDI  R20,LOW(43)
	RJMP _0x2020021
_0x2020028:
	CPI  R18,32
	BRNE _0x2020029
	LDI  R20,LOW(32)
	RJMP _0x2020021
_0x2020029:
	RJMP _0x202002A
_0x2020025:
	CPI  R30,LOW(0x2)
	BRNE _0x202002B
_0x202002A:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x202002C
	ORI  R16,LOW(128)
	RJMP _0x2020021
_0x202002C:
	RJMP _0x202002D
_0x202002B:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x2020021
_0x202002D:
	CPI  R18,48
	BRLO _0x2020030
	CPI  R18,58
	BRLO _0x2020031
_0x2020030:
	RJMP _0x202002F
_0x2020031:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x2020021
_0x202002F:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x2020035
	RCALL SUBOPT_0x2
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x3
	RJMP _0x2020036
_0x2020035:
	CPI  R30,LOW(0x73)
	BRNE _0x2020038
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x4
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x2020039
_0x2020038:
	CPI  R30,LOW(0x70)
	BRNE _0x202003B
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x4
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2020039:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x202003C
_0x202003B:
	CPI  R30,LOW(0x64)
	BREQ _0x202003F
	CPI  R30,LOW(0x69)
	BRNE _0x2020040
_0x202003F:
	ORI  R16,LOW(4)
	RJMP _0x2020041
_0x2020040:
	CPI  R30,LOW(0x75)
	BRNE _0x2020042
_0x2020041:
	LDI  R30,LOW(_tbl10_G101*2)
	LDI  R31,HIGH(_tbl10_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x2020043
_0x2020042:
	CPI  R30,LOW(0x58)
	BRNE _0x2020045
	ORI  R16,LOW(8)
	RJMP _0x2020046
_0x2020045:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2020077
_0x2020046:
	LDI  R30,LOW(_tbl16_G101*2)
	LDI  R31,HIGH(_tbl16_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x2020043:
	SBRS R16,2
	RJMP _0x2020048
	RCALL SUBOPT_0x2
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2020049
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2020049:
	CPI  R20,0
	BREQ _0x202004A
	SUBI R17,-LOW(1)
	RJMP _0x202004B
_0x202004A:
	ANDI R16,LOW(251)
_0x202004B:
	RJMP _0x202004C
_0x2020048:
	RCALL SUBOPT_0x2
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	__GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
_0x202004C:
_0x202003C:
	SBRC R16,0
	RJMP _0x202004D
_0x202004E:
	CP   R17,R21
	BRSH _0x2020050
	SBRS R16,7
	RJMP _0x2020051
	SBRS R16,2
	RJMP _0x2020052
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x2020053
_0x2020052:
	LDI  R18,LOW(48)
_0x2020053:
	RJMP _0x2020054
_0x2020051:
	LDI  R18,LOW(32)
_0x2020054:
	RCALL SUBOPT_0x1
	SUBI R21,LOW(1)
	RJMP _0x202004E
_0x2020050:
_0x202004D:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x2020055
_0x2020056:
	CPI  R19,0
	BREQ _0x2020058
	SBRS R16,3
	RJMP _0x2020059
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x202005A
_0x2020059:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x202005A:
	RCALL SUBOPT_0x1
	CPI  R21,0
	BREQ _0x202005B
	SUBI R21,LOW(1)
_0x202005B:
	SUBI R19,LOW(1)
	RJMP _0x2020056
_0x2020058:
	RJMP _0x202005C
_0x2020055:
_0x202005E:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x2020060:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x2020062
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x2020060
_0x2020062:
	CPI  R18,58
	BRLO _0x2020063
	SBRS R16,3
	RJMP _0x2020064
	SUBI R18,-LOW(7)
	RJMP _0x2020065
_0x2020064:
	SUBI R18,-LOW(39)
_0x2020065:
_0x2020063:
	SBRC R16,4
	RJMP _0x2020067
	CPI  R18,49
	BRSH _0x2020069
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2020068
_0x2020069:
	RJMP _0x20200D3
_0x2020068:
	CP   R21,R19
	BRLO _0x202006D
	SBRS R16,0
	RJMP _0x202006E
_0x202006D:
	RJMP _0x202006C
_0x202006E:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x202006F
	LDI  R18,LOW(48)
_0x20200D3:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x2020070
	ANDI R16,LOW(251)
	ST   -Y,R20
	RCALL SUBOPT_0x3
	CPI  R21,0
	BREQ _0x2020071
	SUBI R21,LOW(1)
_0x2020071:
_0x2020070:
_0x202006F:
_0x2020067:
	RCALL SUBOPT_0x1
	CPI  R21,0
	BREQ _0x2020072
	SUBI R21,LOW(1)
_0x2020072:
_0x202006C:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x202005F
	RJMP _0x202005E
_0x202005F:
_0x202005C:
	SBRS R16,0
	RJMP _0x2020073
_0x2020074:
	CPI  R21,0
	BREQ _0x2020076
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x3
	RJMP _0x2020074
_0x2020076:
_0x2020073:
_0x2020077:
_0x2020036:
_0x20200D2:
	LDI  R17,LOW(0)
_0x2020021:
	RJMP _0x202001C
_0x202001E:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X+
	LD   R31,X+
	RCALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_printf:
; .FSTART _printf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,4
	__ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	__ADDW2R15
	LD   R30,X+
	LD   R31,X+
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_usart_G101)
	LDI  R31,HIGH(_put_usart_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G101
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	POP  R15
	RET
; .FEND

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG

	.DSEG
_twi_tx_index:
	.BYTE 0x1
_twi_rx_index:
	.BYTE 0x1
_twi_result:
	.BYTE 0x1
_slave_address_G100:
	.BYTE 0x1
_twi_tx_buffer_G100:
	.BYTE 0x2
_bytes_to_tx_G100:
	.BYTE 0x1
_twi_rx_buffer_G100:
	.BYTE 0x2
_bytes_to_rx_G100:
	.BYTE 0x1
_twi_rx_buffer_size_G100:
	.BYTE 0x1
_twi_slave_rx_handler_G100:
	.BYTE 0x2
_twi_slave_tx_handler_G100:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x1:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x2:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x3:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x4:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	LD   R30,X+
	LD   R31,X+
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	NEG  R27
	NEG  R26
	SBCI R27,0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

;END OF CODE MARKER
__END_OF_CODE:
