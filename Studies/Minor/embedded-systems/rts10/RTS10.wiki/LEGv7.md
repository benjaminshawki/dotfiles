# LEGv7 Pinky instructieset

De LEGv7 Pinky instructieset is een kleine subset van de ARMv7 16-bit Thumb instructieset. 

Een uitgebreide beschrijving van de LEGv7 architectuur en de Pinky instructieset vind je in dit document: 

- [De LEGv7 architectuur en de Pinky instructieset](LEGv7/LEGv7-Pinky_ebook.pdf) om online te bekijken;
- [De LEGv7 architectuur en de Pinky instructieset](LEGv7/LEGv7-Pinky.pdf) om dubbelzijdig af te drukken.

Op deze pagina vind je een (zeer) korte samenvatting van dit document met links naar de brondocumentatie de [Arm v7-M Architecture Reference Manual](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f).

Programma's geschreven in LEGv7 Pinky kunnen geassembleerd worden in de STM32Cube IDE met de daarin aanwezige [GNU assembler](https://sourceware.org/binutils/docs-2.38/as.pdf) en uitgevoerd worden op een STM32.
Alle instructies in deze instructieset eindigen op `.N` dit zorgt ervoor dat de assembler een foutmelding geeft als de instructie niet in 16 bits past.
De instructie `CMP.N` en alle instructies die eindigen op `S.N` werken de flags in het CPSR register bij.
De overige instructies werken de flags niet bij. 

## Registers

Alleen de registers R0 t/m R7 en SP, LR, PC en CPSR zijn bruikbaar in de ARMv7 16-bit Thumb instructieset. Regsisters R8 t/m R12 kunnen dus niet gebruikt worden. De encoding van de ARMv7 16-bit Thumb instructieset kun je vinden op p. 129 van de Arm v7-M Architecture Reference Manual: [https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#page=129](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#page=129).

De LEGv7 Pinlky instructieset bevat 33 instructies ingedeeld in de volgende instructiegroepen:

## Rekenkundige berekeningen

- ADD
  
     - `ADDS.N <Rd>, <Rn>, <Rm>` [Add (register)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABHBCEE)
  
     - `ADDS.N <Rd>, <Rn>, #<imm3>` [Add (3-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABIACEB)
  
     - `ADDS.N <Rdn>, #<imm8>` [Add (8-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABIACEB)

- SUB
  
     - `SUBS.N <Rd>, <Rn>, <Rm>` [Subtract (register)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABFGCAF)
  
     - `SUBS.N <Rd>, <Rn>, #<imm3>` [Subtract (3-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABEDJGF)
  
     - `SUBS.N <Rdn>, #<imm8>` [Subtract (8-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABEDJGF)

## Logische bewerkingen

- `ANDS.N <Rdn>, <Rm>` [Bitwise AND](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.Chddbdhf)

- `ORRS.N <Rdn>, <Rm>` [Bitwise OR](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABCDIJJ)

- `EORS.N <Rdn>, <Rm>` [Bitwise EXOR](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABHJDCJ)

## Schuif-bewerkingen

- `LSLS.N <Rd>, <Rm>, #<imm5>` [Logical Shift Left (5-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABBDBAJ)

- `LSRS.N <Rd>, <Rm>, #<imm5>` [Logical Shift Right (5-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABJHFCB)

## Kopiëren

- `MOVS.N <Rd>, <Rm>` [Move (register)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABJFFII)

- `MOVS.N <Rd>, #<imm8>` [Move (8-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABCDEDI)

## Vergelijken met nul en spring voorwaarts

- `CBZ.N <Rn>, <label>` [Compare and Branch on Zero](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABHABJG)

- `CBNZ.N <Rn>, <label>` [Compare and Branch on Non-Zero](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABHABJG)

## Springen

- `B.N <label>` [Branch](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABEDEEJ)

## Vergelijken en springen als ...

- `CMP.N <Rn>, <Rm>` [Compare (register)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABFGDAI)

- `CMP.N <Rn>, #<imm8>` [Compare (8-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABJEHHE)

- `B<c>.N <label>` [Branch](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABEDEEJ)
  `<c>` =  [conditie](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#G11.4949511):
  
     - `EQ` Equal, Z == 1
     - `NE` Not Equal, Z == 0
     - `CS (HS)` Carry Set (unsigned Higher or Same), C == 1
     - `CC (LO)` Carry Clear (unsigned LOwer), C == 0
     - `MI` MInus, N == 1
     - `PL` PLus, N == 0
     - `VS` Overflow Set, V == 1
     - `VC` Overflow Clear, V == 0
     - `HI` unsigned HIgher, C == 1 and Z == 0
     - `LS` unsigned Lower or Same, C == 0 or Z == 1
     - `GE` signed Greater than or Equal, N == V
     - `LT` signed Less Than, N != V
     - `GT` signed Greater Than, Z == 0 and N == V
     - `LE` signed Less than or Equal, Z == 1 or N != V
     - `None (AL)` Always (unconditional) 

## Lezen en schrijven in het geheugen

- `LDR.N <Rt>, [<Rn>, <Rm>]` [Load Register (register) ](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABHDCDB)

- `LDR.N <Rt>, [<Rn>, #<imm7>]` [Load Register (7-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABHCCAG)

- `LDR.N <Rt>, =<label>` [Load Register (literal)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABIFAFG)

- `STR.N <Rt>, [<Rn>, <Rm>]` [Store Register (register)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABFAAHB)

- `STR.N <Rt>, [<Rn>, #<imm7>]` [Store Register (7-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABBECBC)

## Doe niets

- `NOP.N` [No Operation](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABJFGFI)

## Spring naar subroutine en return

- `BLX.N <Rm>` [Branch with Link and Exchange](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABCHBJH)

- `BX.N LR` [Branch and Exchange Link Register](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABEJAHC)

## Stack bewerkingen

- `PUSH.N {<register list>}` [Push Multiple Registers](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABBFBDF)

- `POP.N {<register list>}` [Pop Multiple Registers](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABEAAEJ)

- `LDR.N <Rt>, [SP, #<imm10>]` [Load Register (10-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABHCCAG)

- `STR.N <Rt>, [SP, #<imm10>]` [Store Register (10-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABBECBC)

- `SUB.N SP, SP, #<imm9>` [Subtract (SP minus 9-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABDJDIA)

- `ADD.N SP, SP, #<imm9>` [Add (SP plus 9-bit immediate)](https://documentation-service.arm.com/static/606dc36485368c4c2b1bf62f#E11.BABFIGFA)