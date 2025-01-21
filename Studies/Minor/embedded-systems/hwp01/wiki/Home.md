<!-- LTeX: language=nl -->

# Programmeerbare Hardware

In dit repository zijn de cursushandleiding, de opdrachten en de PowerPoint presentaties opgenomen die bij de cursus HWP01 (Hardware Programming) van de minor Embedded Systems van de Hogeschool Rotterdam gebruikt worden.

De informatie in dit repository is zoals alle mensenwerk niet foutloos, verbeteringen en suggesties zijn altijd welkom! Maak, als je ons feedback wilt geven, een [issue](https://bitbucket.org/HR_ELEKTRO/hwp01/issues) aan.

## Cursushandleiding

- [Cursushandleiding_HWP01_ebook.pdf](Cursushandleiding/Cursushandleiding_HWP01_ebook.pdf) om online te bekijken.
- [Cursushandleiding_HWP01.pdf](Cursushandleiding/Cursushandleiding_HWP01.pdf) om dubbelzijdig af te drukken.

## Voor je begint: pas je browserinstellingen aan!

In de pdf-bestanden die je op deze wiki vindt, wordt veel gebruik gemaakt van links naar specifieke locaties in andere pdf-bestanden. Om dit te laten werken is het nodig om je browserinstellingen aan te passen.

- Microsoft Edge: Installeer deze extensie: [https://microsoftedge.microsoft.com/addons/detail/pdf-reader/nhppiemcomgngbgdeffdgkhnkjlgpcdi](https://microsoftedge.microsoft.com/addons/detail/pdf-reader/nhppiemcomgngbgdeffdgkhnkjlgpcdi).

- Google Chrome: Installeer deze extensie: [https://chrome.google.com/webstore/detail/pdf-reader/ieepebpjnkhaiioojkepfniodjmjjihl](https://chrome.google.com/webstore/detail/pdf-reader/ieepebpjnkhaiioojkepfniodjmjjihl).

- Firefox: Type `about:config` in de adresbalk, zoek naar `browser.download.open_pdf_attachments_inline` en  zet deze optie op `true`.

## Benodigde software

We maken bij HWP01 gebruik van de volgende software:
- Quartus Prime Lite Edition versie 18.1 met Cyclone V device support. Let op! Dit is niet de laatste versie, maar we gebruiken deze versie omdat we die bij het vervolgvak CSC10 nodig hebben.
- ModelSim - Intel FPGA Edition.
- Intel FPGA Academic Program.

Hoe je deze software kunt installeren vind je [hier](installatie_software).

## Benodigde hardware

We maken bij HWP01 gebruik van de [DE1-SoC van Terasic](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=836). Deze krijg je te leen gedurende de hele minor.

[DE1-SoC Board resources](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=167&No=836&PartNo=4)

- [DE1-SoC User Manual revisie C](docs/DE1-SoC_User_manual_revc.pdf) borden 1 t/m 15.
- [DE1-SoC Schematics revisie C](docs/DE1-SoC_schematics_revc.pdf) borden 1 t/m 15.
- [DE1-SoC User Manual revisie G](docs/DE1-SoC_User_manual_revf.pdf) borden 16 t/m 50.
- [DE1-SoC Schematics revisie G](docs/DE1-SoC_Schematics_revf.pdf) borden 16 t/m 50.
- [DE1-SoC User Manual revisie H](docs/DE1-SoC_User_manual_revh.pdf) borden 51 t/m 75.
- [DE1-SoC Schematics revisie H](docs/DE1-SoC_Schematics_revh.pdf) borden 51 t/m 75.



## Lab Work Handbook

- [Lab_Work_Handbook_ebook.pdf](Lab_Work_Handbook/Lab_Work_Handbook.pdf) om online te bekijken.
- [Lab_Work_Handbook.pdf](Lab_Work_Handbook/Lab_Work_Handbook.pdf) om dubbelzijdig af te drukken.

## Weekplanning

| Week    | PowerPoint                                    | Pdf                                         | Opdrachten                                                                   | Opmerkingen en verwijzingen                               |
| ------- | --------------------------------------------- | ------------------------------------------- | ---------------------------------------------------------------------------- | --------------------------------------------------------- |
| 1       | [HWP01_WK1.pptx](presentaties/HWP01_WK1.pptx) | [HWP01_WK1.pdf](presentaties/HWP01_WK1.pdf) | [Lab_Work_Handbook_ebook.pdf](Lab_Work_Handbook/Lab_Work_Handbook_ebook.pdf) |                                                           |
| 2       | [HWP01_WK2.pptx](presentaties/HWP01_WK2.pptx) | [HWP01_WK2.pdf](presentaties/HWP01_WK2.pdf) | [Assignments_Week_2.pdf](Assignments/Assignments_Week_2.pdf)                 |                                                           |
| 3       | [HWP01_WK3.pptx](presentaties/HWP01_WK3.pptx) | [HWP01_WK3.pdf](presentaties/HWP01_WK3.pdf) | [Assignments_Week_3.pdf](Assignments/Assignments_Week_3.pdf)                 |                                                           |
| 4       | [HWP01_WK4.pptx](presentaties/HWP01_WK4.pptx) | [HWP01_WK4.pdf](presentaties/HWP01_WK4.pdf) | [Assignments_Week_4.pdf](Assignments/Assignments_Week_4.pdf)                 |                                                           |
| 5       | [HWP01_WK5.pptx](presentaties/HWP01_WK5.pptx) | [HWP01_WK5.pdf](presentaties/HWP01_WK5.pdf) | [Assignments_Week_5.pdf](Assignments/Assignments_Week_5.pdf)                 | [fsm_egg_timer.vhd](uitleg/fsm_egg_timer.vhd)             |
| 6 t/m 8 |                                               |                                             | Zie: Eindopdrachten                                                          | In week 6 t/m 8 wordt geen nieuwe theorie meer behandeld. |

## Eindopdrachten

Eindopdracht (ook te vinden in [BrightSpace](https://brightspace.hr.nl/d2l/home/112075)): *Volgt nog* <!--[Assignments_Final.pdf](Assignments/Assignments_Final.pdf)--> met [Nakijkmodel_2024.pdf](beoordeling/Nakijkmodel_2024.pdf).

## Extra Informatie

- Informatie over het koppelen van Quartus met Modelsim [Integratie_quartus_met_modelsim.pdf](todo)
- FPGA pin assignments "made easy" : [DE1_SoC.qsf](https://bitbucket.org/HR_ELEKTRO/hwp01/raw/65adfd4a8783c0012592a079cff2deea63366d33/progs/DE1_SoC.qsf). Te gebruiken om de I/O poortnamen van je top-level design te koppelen aan de pinnen van je FPGA.
- Template voor een Finite State Machine: [FSM_template](uitleg/FSM_template.txt).
- [Why latches are bad and how to avoid them](https://vhdlwhiz.com/why-latches-are-bad/).
- [Understanding Metastability in FPGAs](https://www.altera.com/en_US/pdfs/literature/wp/wp-01082-quartus-ii-metastability.pdf).
- [SignalTap Embedded Logic Analyzer](https://ftp.intel.com/Public/Pub/fpgaup/pub/Teaching_Materials/current/Tutorials/VHDL/SignalTap.pdf).
- ...

<!-- 

http://g2384.github.io/work/VHDLformatter.html

http://vhdl.lapinoo.net/testbench/tb.php -->