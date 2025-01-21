# Hearthbleed
https://heartbleed.com/

Written in C

## Buffer overflow
Did not check if if it was allocated

# Doelen van de les
- Informatiebeveiliging en de CIA driehoek (infosec-proces)

# Opdrachten
 
## Zoek op google naar de zogeheten heartblead bug. Wat was het gevolg van deze bug? Hoe is deze bug ontstaan?

De hearthbleed bug maakte het mogelijk voor iedereen om de memory van systemen te lezen die gebruik maakte van bepaalde versies van de OpenSSL software.
Dit was mogelijk door een buffer overflow in de software.
De bug was ontstaan doordat de software niet controleerde of de data die werd gelezen wel de juiste lengte had.

## Kun je ook iets vertellen over het stuxnet virus? Hoe heeft dit virus zich initieel verspreid. Wat was het doel van dit virus? ( kijk op google ).
Stuxnet is een virus die specifiek is ontworpen programmerbare logische controllers (PLC) te infecteren. Het virus verspreide zich voornamelijk via geïnfecteerde USB sticks.

Het doel van het virus was om SCADA systemen te infecteren. Deze systemen worden gebruikt om industriële processen te automatiseren.
Zonder dat de landen het openlijk toegeven wordt er vanuit gegaan dat het virus is ontwikkeld door de Verenigde Staten en Israël.
Het virus was specifiek ontworpen om de centrifuges van een Iraanse kerncentrale te infecteren.
 
## Wat doe jij zelf aan informatiebeveiliging. Vind jij dat voldoende?  Stel zoveel mogelijk punten voor jezelf op. 

- Gebruik van een password manager
- Gebruik van 2FA
- Gebruik van een VPN
- Encryptie van mijn harde schijf
 
## Verklaar de CIA driehoek. Beschrijf de doelen hiervan en leg uit wat deze betekenen, bij voorkeur met een voorbeeld. 
De CIA driehoek staat voor Confidentiality, Integrity en Availability.

### Confidentiality
Confidentiality betekent dat informatie alleen toegankelijk is voor degenen die toegang hebben tot de informatie.

### Integrity
Integrity betekent dat de informatie die wordt opgeslagen of verstuurd niet wordt aangepast door onbevoegden.

### Availability
Availability betekent dat de informatie beschikbaar is voor degenen die toegang hebben tot de informatie.
 
## Hoe kunnen de doelen van de CIA driehoek worden geborgd ( of worden waargemaakt ). Beschrijf deze per component. 

### Vertrouwelijkheid 
Door bijvoorbeeld gebruik te maken van encryptie. Encryptie zorgt ervoor dat de data niet leesbaar is voor onbevoegden.

### Integriteit 
Door bijvoorbeeld gebruik te maken van checksums. Een checksum is een waarde die wordt berekend over een bestand. Als het bestand wordt aangepast zal de checksum veranderen.

### Bereikbaarheid 
Door het gebruik maken van bijvoorbeeld een load balancer kan de bereikbaarheid van een systeem worden verhoogd. Een load balancer zorgt ervoor dat de belasting over meerdere servers wordt verdeeld.

- Hot stand by and cold stand by
 
## Met behulp van de drie P’s kunnen wij informatiebeveiliging realiseren, waar staan deze 3 P’s voor.  Omschrijf wat de p’s betekenen en geef een voorbeeld per p. 

### Primitives
Wiskundige tak, encryptie, hashing, checksums

### Policy
Afspraken die je maakt met een bedrijf.

### Products
Software, hardware, firewalls, VPN, antivirus software, password managers, 2FA, VPN, encryptie

<!-- ### Perimeter -->
<!-- Een perimeter is een grens die wordt gesteld om een systeem. Dit kan bijvoorbeeld een firewall zijn. Een firewall zorgt ervoor dat alleen bepaalde verkeer wordt toegelaten. -->
<!---->
<!-- ### Policy -->
<!-- Een policy is een set van regels die worden opgesteld om de informatiebeveiliging te waarborgen. Een voorbeeld van een policy is dat medewerkers hun wachtwoord elke 3 maanden moeten wijzigen. -->
<!---->
<!-- ### People -->
<!-- Mensen zijn een belangrijk onderdeel van informatiebeveiliging. Mensen kunnen bijvoorbeeld worden getraind om phishing mails te herkennen. -->
 
## Welke componenten horen bij welk doel van de CIA driehoek. 
 
- Bereikbaarheid
Load-balancer 

- Vertrouwelijkheid
Bestandsrechten 

- Integriteit
Checksum 

- Bereikbaarheid / Availability
Backup 

- Availability
Ring netwerk 

- Bereikbaarheid
Redundante RAID array  

- Vertrouwelijkheid 
AES Encryptie 

- Integriteit
Read-only opslag. 
 
## Kun je meten, zien of weten dat een bedrijf afdoende aan infosec doet? Leg uit en omschrijf hoe. 

Ja, dit kan door bijvoorbeeld een audit uit te voeren. Een audit is een controle op de informatiebeveiliging van een bedrijf.
En bedreiven kunnen ook een certificaat behalen zoals de ISO 27001 certificaat. Dit certificaat geeft aan dat een bedrijf voldoet aan de eisen die worden gesteld aan informatiebeveiliging.
