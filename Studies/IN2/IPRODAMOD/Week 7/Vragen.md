![img.png](img.png)
Moet UserRole nog een id hebben? deze wordt dan de PK
</br>
</br>
<h4>Voorbeeld: kleding/broeken</h4>
id: 1, name: kleding, parent_id: NULL
</br>
id:2, name: broeken, parent_id: 1
</br>
</br>
Is deze manier van nested catogory mapping goed?
</br>
![img_1.png](img_1.png)
</br>
</br>

<h4>Klopt deze crow feet notation?</h4>
users zijn gesplit in employee en customer. 
</br>
![img_2.png](img_2.png)
</br>
</br>
![img_3.png](img_3.png)
</br>
toen ik de address tabel toevoegde kwam ik erachter dat ik meerdere foreign keys heb die naar dezelfde tabel verwijzen. 
Ik snap dat dit mogelijk is maar is dit een goed idee?

Een optie is om nogeen aantal tabellen toe te voegen met leveranciers of iets van "shipment_info"
Mijn initiele gedachte was dat Griixs (de webshop) deze zelf verzend vanuit hun kantoor. Wat dus ook kan  is een office tabel toevoegen. 
![img_4.png](img_4.png)

of

![img_5.png](img_5.png)






