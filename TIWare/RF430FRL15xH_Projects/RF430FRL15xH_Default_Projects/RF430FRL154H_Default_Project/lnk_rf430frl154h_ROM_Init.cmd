/* ============================================================================ */
/* Copyright (c) 2014, Texas Instruments Incorporated                           */
/*  All rights reserved.                                                        */
/*                                                                              */
/*  Redistribution and use in source and binary forms, with or without          */
/*  modification, are permitted provided that the following conditions          */
/*  are met:                                                                    */
/*                                                                              */
/*  *  Redistributions of source code must retain the above copyright           */
/*     notice, this list of conditions and the following disclaimer.            */
/*                                                                              */
/*  *  Redistributions in binary form must reproduce the above copyright        */
/*     notice, this list of conditions and the following disclaimer in the      */
/*     documentation and/or other materials provided with the distribution.     */
/*                                                                              */
/*  *  Neither the name of Texas Instruments Incorporated nor the names of      */
/*     its contributors may be used to endorse or promote products derived      */
/*     from this software without specific prior written permission.            */
/*                                                                              */
/*  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" */
/*  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,       */
/*  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR      */
/*  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR            */
/*  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,       */
/*  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,         */
/*  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; */
/*  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,    */
/*  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR     */
/*  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,              */
/*  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                          */
/* ============================================================================ */

/******************************************************************************/
/* lnk_rf430frl154h.cmd - LINKER COMMAND FILE FOR LINKING RF430FRL154H PROGRAMS     */
/*                                                                            */
/*   Usage:  lnk430 <obj files...>    -o <out file> -m <map file> lnk.cmd     */
/*           cl430  <src files...> -z -o <out file> -m <map file> lnk.cmd     */
/*                                                                            */
/*----------------------------------------------------------------------------*/
/* These linker options are for command line linking only.  For IDE linking,  */
/* you should set your linker options in Project Properties                   */
/* -c                                               LINK USING C CONVENTIONS  */
/* -stack  0x0100                                   SOFTWARE STACK SIZE       */
/* -heap   0x0100                                   HEAP AREA SIZE            */
/*                                                                            */
/*----------------------------------------------------------------------------*/
/* Version: 1.154    (Beta-Build-Tag: #0017)                                  */
/*----------------------------------------------------------------------------*/

/****************************************************************************/
/* Specify the system memory map                                            */
/****************************************************************************/

MEMORY
{
    SFR                     : origin = 0x0000, length = 0x0010
    PERIPHERALS_8BIT        : origin = 0x0010, length = 0x00F0
    PERIPHERALS_16BIT       : origin = 0x0100, length = 0x0100
    RAM                     : origin = 0x1C00, length = 0x1000

    //ROM ISRs, starting points, lengths not correct, needed to force correct compilation
    RFPMM_ROM_ISR			: origin = 0x5BB8, length = 0x0002
    PORT1_ROM_ISR			: origin = 0x59C0, length = 0x0002
    USCI_B0_ROM_ISR			: origin = 0x488A, length = 0x0002
    RF13M_ROM_ISR			: origin = 0x54D0, length = 0x0002
    WDT_ROM_ISR				: origin = 0x5E48, length = 0x0002
    TIMER_A1_ROM_ISR		: origin = 0x5E2A, length = 0x0002
    TIMER_A0_ROM_ISR		: origin = 0x4E76, length = 0x0002
    UNMI_ROM_ISR			: origin = 0x5E42, length = 0x0002
    SYSNMI_ROM_ISR			: origin = 0x5E44, length = 0x0002
    RESET_ROM_ISR			: origin = 0x5012, length = 0x0002

    /* FRAM + DRIVER_CODE must equal 0x790 */
    FRAM                    : origin = 0xF840, length = 0x0490	// FRAM sensor data logging space
    FRAM_CODE               : origin = 0xFCD0, length = 0x0300  // Drive FRAM code space

    JTAGSIGNATURE           : origin = 0xFFD0, length = 0x0004, fill = 0xFFFF
    BSLSIGNATURE            : origin = 0xFFD4, length = 0x0004, fill = 0xFFFF
    INT00                   : origin = 0xFFE0, length = 0x0002
    INT01                   : origin = 0xFFE2, length = 0x0002
    INT02                   : origin = 0xFFE4, length = 0x0002
    INT03                   : origin = 0xFFE6, length = 0x0002
    INT04                   : origin = 0xFFE8, length = 0x0002
    INT05                   : origin = 0xFFEA, length = 0x0002
    INT06                   : origin = 0xFFEC, length = 0x0002
    INT07                   : origin = 0xFFEE, length = 0x0002
    INT08                   : origin = 0xFFF0, length = 0x0002
    INT09                   : origin = 0xFFF2, length = 0x0002
    INT10                   : origin = 0xFFF4, length = 0x0002
    INT11                   : origin = 0xFFF6, length = 0x0002
    INT12                   : origin = 0xFFF8, length = 0x0002
    INT13                   : origin = 0xFFFA, length = 0x0002
    INT14                   : origin = 0xFFFC, length = 0x0002
    RESET                   : origin = 0xFFFE, length = 0x0002
}

/****************************************************************************/
/* Specify the sections allocation into memory                              */
/****************************************************************************/

SECTIONS
{
    GROUP(ALL_FRAM)
    {
       GROUP(READ_WRITE_MEMORY)
       {
          .TI.persistent : {}                /* For #pragma persistent            */
       }

       GROUP(READ_ONLY_MEMORY)
       {
          .cinit      : {}                   /* Initialization tables             */
          .pinit      : {}                   /* C++ constructor tables            */
          .init_array : {}                   /* C++ constructor tables            */
          .mspabi.exidx : {}                 /* C++ constructor tables            */
          .mspabi.extab : {}                 /* C++ constructor tables            */
          .const      : {}                   /* Constant data                     */
       }

       GROUP(EXECUTABLE_MEMORY)
       {
          .text       : {}                   /* Code                              */
       }
    } > FRAM_CODE

	//ROM ISRs
    //.rom_isr 			: {} > ROM_ISR  type = DSECT
    .rfpmm_rom_isr		: {} > RFPMM_ROM_ISR type = DSECT
    .port1_rom_isr		: {} > PORT1_ROM_ISR type = DSECT
    .usci_b0_rom_isr	: {} > USCI_B0_ROM_ISR  type = DSECT
    .rf13m_rom_isr		: {} > RF13M_ROM_ISR type = DSECT
    .wdt_rom_isr		: {} > WDT_ROM_ISR	type = DSECT
    .timer_a1_rom_isr	: {} > TIMER_A1_ROM_ISR type = DSECT
    .timer_a0_rom_isr 	: {} > TIMER_A0_ROM_ISR type = DSECT
    .unmi_rom_isr 		: {} > UNMI_ROM_ISR type = DSECT
    .sysnmi_rom_isr		: {} > SYSNMI_ROM_ISR type = DSECT
    .reset_rom_isr		: {} > RESET_ROM_ISR type = DSECT

    .fram_driver_code   	: {} > FRAM_CODE

    .jtagsignature : {} > JTAGSIGNATURE   /* JTAG Signature                    */
    .bslsignature  : {} > BSLSIGNATURE    /* BSL Signature                     */
    .jtagpassword                         /* JTAG Password                     */

    .bss        : {} > RAM                /* Global & static vars              */
    .data       : {} > RAM                /* Global & static vars              */
    .TI.noinit  : {} > RAM                /* For #pragma noinit                */
    .cio        : {} > RAM                /* C I/O buffer                      */
    .sysmem     : {} > RAM                /* Dynamic memory allocation area    */
    .stack      : {} > RAM (HIGH)         /* Software system stack             */


    /* MSP430 Interrupt vectors          */
    .int00       : {}               > INT00
    .int01       : {}               > INT01
    .int02       : {}               > INT02
    .int03       : {}               > INT03
    .int04       : {}               > INT04
    RFPMM        : { * ( .int05 ) } > INT05 type = VECT_INIT
    PORT1        : { * ( .int06 ) } > INT06 type = VECT_INIT
    .int07       : {}               > INT07
    USCI_B0      : { * ( .int08 ) } > INT08 type = VECT_INIT
    ISO          : { * ( .int09 ) } > INT09 type = VECT_INIT
    WDT          : { * ( .int10 ) } > INT10 type = VECT_INIT
    TIMER0_A1    : { * ( .int11 ) } > INT11 type = VECT_INIT
    TIMER0_A0    : { * ( .int12 ) } > INT12 type = VECT_INIT
    UNMI         : { * ( .int13 ) } > INT13 type = VECT_INIT
    SYSNMI       : { * ( .int14 ) } > INT14 type = VECT_INIT
    //.reset       : {}               > RESET  /* MSP430 Reset vector         */
    RESET_V      : { * ( .int15 ) } > RESET type = VECT_INIT  /* MSP430 Reset vector         */
}

/****************************************************************************/
/* Include peripherals memory map                                           */
/****************************************************************************/

-l rf430frl154h.cmd

