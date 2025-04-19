### Flow of Execution in STM32 (or most ARM Cortex-M MCUs):

1. **Microcontroller resets** → it looks at the **vector table** at address `0x08000000` (start of Flash).
2. The **first entry** in the vector table is the initial  **stack pointer** .
3. The **second entry** is the address of the **Reset_Handler** — this is where execution  *really starts* .

### In the startup file (usually in assembly)

```
Reset_Handler:
    // Set up the stack
    // Copy .data section from Flash to RAM
    // Zero out the .bss section
    // Call SystemInit() if using CMSIS
    bl main           // <- this is where it jumps to your main()
```
