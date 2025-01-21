# Les
Generic used for constants in declaring global constants

# Gastcollege Gerke Stoevelaar Fox-Crypto & FPGA's

## uitzoeken todo
TODO: uitzoeken  Hardware intrusion detection Side Channel, TEMPESt attacks

(Post quantum)
AES-256
CMAC

kaiber?

Vault injections

## Con of asymetric encryption
You decipher to check if the message is correct, you can have any input and check if the output is correct.
Difi hellman is not post crypto.


## Fox-Cyrpto
Ze bouwen Data Diode


## Onze producten FPGA's
### Ruggized IP-cypto for military environments
- Secret and confidential levels
- Ad-hoc networking; switch between availible radio, mobile and satalite networks
- Static infrastructure and mobile deplooyment in vehicles

Rugged turn-key cyrpto applciations
- High-end mechanics, hardware , embedded software & firmawre (VHDL)

### Defense: Electronic Key Management
- System
    - Key management servers
    - Secure Workstations HSM module

Electronic Fill device Rugged "secure tablet"
Key loader tablet


## Uitdagingen
### Hardware security Tamper detection + response
Intrusion detection
    

## Design Flow

## Example JTAG guard
What is JTAG?
Meeste datalekken zitten in JTAG

Waarom is JTAG een probleem?

Hoe kunnen we dit oplossen?

```vhdl
generic(
    NUMBER_OF_PINPAIRS: integer range 0 to 255 := 11;
)
```

## Coding standards

Als je het in een if else kan doen doe het

-  All reolution functions mmust be commutative
- Shared varables (dont use)
- avoid floating points
- prevent model intercommunication throu fiiles

- Do not use absolutie path names in fils
- Do not rename declarations by wrapping hten in new declaration
- do not redefine which is predefined
