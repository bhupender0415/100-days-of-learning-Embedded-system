/* Define memory regions */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 64K   /* 64KB Flash */
  RAM   (rwx) : ORIGIN = 0x20000000, LENGTH = 20K   /* 20KB RAM */
}

/* Define entry point */
ENTRY(Reset_Handler)

SECTIONS
{
  /* Place vector table and code in FLASH */
  .text :
  {
    KEEP(*(.isr_vector))        /* Interrupt vector table */
    *(.text*)                   /* Application code */
    *(.rodata*)                 /* Read-only data (const) */
    KEEP(*(.init))
    KEEP(*(.fini))
  } > FLASH

  /* Initialized data section: copied from Flash to RAM */
  .data : AT(ADDR(.text) + SIZEOF(.text))
  {
    _sdata = .;
    *(.data*)
    _edata = .;
  } > RAM

  /* Uninitialized data section: just reserved in RAM */
  .bss :
  {
    _sbss = .;
    *(.bss*)
    *(COMMON)
    _ebss = .;
  } > RAM

  /* Stack top */
  . = ALIGN(8);
  _estack = ORIGIN(RAM) + LENGTH(RAM);
}
