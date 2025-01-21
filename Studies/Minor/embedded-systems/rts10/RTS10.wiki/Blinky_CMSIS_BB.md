# Using bit-banding in Cortex-M4 microcontrollers; CMSIS style

Cortex-M4 processors optionally have a memory map in which so-called "bit-banding" is included. If this is the case, then certain parts of the memory map can also be addressed on a bit-by-bit basis. Each bit in e.g. the `AHB1ENR` register is then readable or writable through another so-called alias address. The necessary information can be found in [Section 2.3.3 of RM0383](https://www.st.com/resource/en/reference_manual/rm0383-stm32f411xce-advanced-armbased-32bit-mcus-stmicroelectronics.pdf#%5B%7B%22num%22%3A43%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C67%2C420%2Cnull%5D). More extensive information can be found in [Section 2.2.5 of the Cortex-M4 Devices Generic User Guide](https://documentation-service.arm.com/static/5f2ac76d60a93e65927bbdc5#G5.1049941) from Arm<sup>1</sup>. 

Arm defined the [CMSIS](https://arm-software.github.io/CMSIS_5/General/html/index.html) (Common Microcontroller Software Interface Standard). This API enables consistent device support by providing simple software interfaces to the processor and the peripherals. But as far as I know, it doesn't support bit-banding.

There is a relatively easy way to expand the CMSIS [Core(M)](https://arm-software.github.io/CMSIS_5/Core/html/index.html) include files to support bit-banding. As an example I will present a simple program that makes the blue LED blink on the [STM32F411E-DISCO](https://www.st.com/resource/en/user_manual/dm00148985-discovery-kit-with-stm32f411ve-mcu-stmicroelectronics.pdf) board. The microcontroller on this board, the STM32F411VET6, has support for bit-banding. The program needs to execute the following steps:

1. enable the clock of the GPIOD module by setting the `GPIODEN` bit within the `AHB1ENR` register of the RCC (Reset and clock control) module;

2. configure I/O pin PD15 as an output by setting one bit, and clearing one bit in the `MODER` register of the GPIOD module;

3. turn the LED on by setting bit 15 of the `ODR` register of the GPIOD module;

4. repeat forever:
   
      4a. wait a moment;
   
      4b. toggle the LED by inverting the value of bit 15 of the `ODR` register of the GPIOD module.

If we don't want to affect the other bits in the `AHB1ENR` register of the RCC module we can set the `GPIODEN` bit within this register using CMSIS, as follows:

```c
RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
```

This instruction reads the `AHB1ENR` register, performs a bitwise OR, and finally writes the result back to the `AHB1ENR` register. Using bit-banding we could achieve the same with a single write to the alias address of the `GPIODEN` bit within the `AHB1ENR` register. Unfortunately, CMSIS doesn't natively support this. It is relatively easy to add bit-banding support. The procedure is as follows:

1. find the type of the pointer `RCC` in the CMSIS header file: `((RCC_TypeDef *) RCC_BASE`;

2. find and copy the `typedef` for `RCC_TypeDef `and call this new type `RCC_BB_TypeDef`, BB stands for bit-banding;

3. change all members in the struct into arrays with 32 elements (the 32 bits in each register), as follows:

```c
   typedef struct {
       __IO uint32_t CR[32];            /*!< RCC clock control register,                                  Address offset: 0x00 */
       __IO uint32_t PLLCFGR[32];       /*!< RCC PLL configuration register,                              Address offset: 0x04 */
       __IO uint32_t CFGR[32];          /*!< RCC clock configuration register,                            Address offset: 0x08 */
       __IO uint32_t CIR[32];           /*!< RCC clock interrupt register,                                Address offset: 0x0C */
       __IO uint32_t AHB1RSTR[32];      /*!< RCC AHB1 peripheral reset register,                          Address offset: 0x10 */
       __IO uint32_t AHB2RSTR[32];      /*!< RCC AHB2 peripheral reset register,                          Address offset: 0x14 */
       __IO uint32_t AHB3RSTR[32];      /*!< RCC AHB3 peripheral reset register,                          Address offset: 0x18 */
       uint32_t      RESERVED0[32];     /*!< Reserved, 0x1C                                                                    */
       __IO uint32_t APB1RSTR[32];      /*!< RCC APB1 peripheral reset register,                          Address offset: 0x20 */
       __IO uint32_t APB2RSTR[32];      /*!< RCC APB2 peripheral reset register,                          Address offset: 0x24 */
       uint32_t      RESERVED1[2][32];  /*!< Reserved, 0x28-0x2C                                                               */
       __IO uint32_t AHB1ENR[32];       /*!< RCC AHB1 peripheral clock register,                          Address offset: 0x30 */
       __IO uint32_t AHB2ENR[32];       /*!< RCC AHB2 peripheral clock register,                          Address offset: 0x34 */
       __IO uint32_t AHB3ENR[32];       /*!< RCC AHB3 peripheral clock register,                          Address offset: 0x38 */
       uint32_t      RESERVED2[32];     /*!< Reserved, 0x3C                                                                    */
       __IO uint32_t APB1ENR[32];       /*!< RCC APB1 peripheral clock enable register,                   Address offset: 0x40 */
       __IO uint32_t APB2ENR[32];       /*!< RCC APB2 peripheral clock enable register,                   Address offset: 0x44 */
       uint32_t      RESERVED3[2][32];  /*!< Reserved, 0x48-0x4C                                                               */
       __IO uint32_t AHB1LPENR[32];     /*!< RCC AHB1 peripheral clock enable in low power mode register, Address offset: 0x50 */
       __IO uint32_t AHB2LPENR[32];     /*!< RCC AHB2 peripheral clock enable in low power mode register, Address offset: 0x54 */
       __IO uint32_t AHB3LPENR[32];     /*!< RCC AHB3 peripheral clock enable in low power mode register, Address offset: 0x58 */
       uint32_t      RESERVED4[32];     /*!< Reserved, 0x5C                                                                    */
       __IO uint32_t APB1LPENR[32];     /*!< RCC APB1 peripheral clock enable in low power mode register, Address offset: 0x60 */
       __IO uint32_t APB2LPENR[32];     /*!< RCC APB2 peripheral clock enable in low power mode register, Address offset: 0x64 */
       uint32_t      RESERVED5[2][32];  /*!< Reserved, 0x68-0x6C                                                               */
       __IO uint32_t BDCR[32];          /*!< RCC Backup domain control register,                          Address offset: 0x70 */
       __IO uint32_t CSR[32];           /*!< RCC clock control & status register,                         Address offset: 0x74 */
       uint32_t      RESERVED6[2][32];  /*!< Reserved, 0x78-0x7C                                                               */
       __IO uint32_t SSCGR[32];         /*!< RCC spread spectrum clock generation register,               Address offset: 0x80 */
       __IO uint32_t PLLI2SCFGR[32];    /*!< RCC PLLI2S configuration register,                           Address offset: 0x84 */
       uint32_t      RESERVED7[1][32];  /*!< Reserved, 0x88                                                                    */
       __IO uint32_t DCKCFGR[32];       /*!< RCC Dedicated Clocks configuration register,                 Address offset: 0x8C */
   } RCC_BB_TypeDef;
```

4. define the address of the `RCC_ALIAS_BASE`, as follows:

```c
#define RCC_ALIAS_BASE (PERIPH_BB_BASE + (RCC_BASE - PERIPH_BASE) * 32)
```

The addresses `PERIPH_BB_BASE`, `RCC_BASE`, and `PERIPH_BASE` are already defined in the CMSIS header file.

5. define a pointer called `RCC_BB` to this address, as follows:

```c
#define RCC_BB ((RCC_BB_TypeDef *) RCC_ALIAS_BASE)
```

We can now set the `GPIODEN` bit within the `AHB1ENR` register without affecting the other bits in CMSIS style:

```c
RCC_BB->AHB1ENR[RCC_AHB1ENR_GPIODEN_Pos] = 1;
```

The constant `RCC_AHB1ENR_GPIODEN_Pos`, the bit position of the `GPIODEN` bit within the `AHB1ENR` register, is already defined in the CMSIS header file.

We can enable bit-banding for the GPIO modules using the same procedure as described above:

```c
typedef struct
{
  __IO uint32_t MODER[32];    /*!< GPIO port mode register,               Address offset: 0x00      */
  __IO uint32_t OTYPER[32];   /*!< GPIO port output type register,        Address offset: 0x04      */
  __IO uint32_t OSPEEDR[32];  /*!< GPIO port output speed register,       Address offset: 0x08      */
  __IO uint32_t PUPDR[32];    /*!< GPIO port pull-up/pull-down register,  Address offset: 0x0C      */
  __IO uint32_t IDR[32];      /*!< GPIO port input data register,         Address offset: 0x10      */
  __IO uint32_t ODR[32];      /*!< GPIO port output data register,        Address offset: 0x14      */
  __IO uint32_t BSRR[32];     /*!< GPIO port bit set/reset register,      Address offset: 0x18      */
  __IO uint32_t LCKR[32];     /*!< GPIO port configuration lock register, Address offset: 0x1C      */
  __IO uint32_t AFR[2][32];   /*!< GPIO alternate function registers,     Address offset: 0x20-0x24 */
} GPIO_BB_TypeDef;

#define GPIOA_ALIAS_BASE (PERIPH_BB_BASE + (GPIOA_BASE - PERIPH_BASE) * 32)
#define GPIOB_ALIAS_BASE (PERIPH_BB_BASE + (GPIOB_BASE - PERIPH_BASE) * 32)
#define GPIOC_ALIAS_BASE (PERIPH_BB_BASE + (GPIOC_BASE - PERIPH_BASE) * 32)
#define GPIOD_ALIAS_BASE (PERIPH_BB_BASE + (GPIOD_BASE - PERIPH_BASE) * 32)
#define GPIOE_ALIAS_BASE (PERIPH_BB_BASE + (GPIOE_BASE - PERIPH_BASE) * 32)
#define GPIOH_ALIAS_BASE (PERIPH_BB_BASE + (GPIOH_BASE - PERIPH_BASE) * 32)
#define GPIOA_BB ((GPIO_BB_TypeDef *) GPIOA_ALIAS_BASE)
#define GPIOB_BB ((GPIO_BB_TypeDef *) GPIOB_ALIAS_BASE)
#define GPIOC_BB ((GPIO_BB_TypeDef *) GPIOC_ALIAS_BASE)
#define GPIOD_BB ((GPIO_BB_TypeDef *) GPIOD_ALIAS_BASE)
#define GPIOE_BB ((GPIO_BB_TypeDef *) GPIOE_ALIAS_BASE)
#define GPIOH_BB ((GPIO_BB_TypeDef *) GPIOH_ALIAS_BASE)
```

The program that makes the blue LED blink, using bit-banding, can now be coded as follows:

```c
int main(void)
{
    // GPIO Port D Clock Enable
    RCC_BB->AHB1ENR[RCC_AHB1ENR_GPIODEN_Pos] = 1;
    // GPIO Port D Pin 15 to Push/Pull Output
    GPIOD_BB->MODER[GPIO_MODER_MODER15_Pos] = 1;
    GPIOD_BB->MODER[GPIO_MODER_MODER15_Pos + 1] = 0;
    // Set blue LED
    GPIOD_BB->ODR[GPIO_ODR_OD15_Pos] = 1;
    // Do forever:
    while (1)
    {
        // Wait a moment
        for (volatile int32_t i = 0; i < 1000000; i++);
        // Flip blue LED
        GPIOD_BB->ODR[GPIO_ODR_OD15_Pos] ^= 1;
    }
}
```

<sup>1</sup> There is an error in Table 2-14 “Peripheral memory bit-banding regions”. The names of the “Memory regions” are interchanged. So the “address range” 0x40000000 – 0x400FFFFF is the “Peripheral bit-band region” and the “address range” 0x42000000 – 0x43FFFFFF is the “Peripheral bit-band alias”.