Wat is een singleton?
=====================
Een singleton is een design pattern dat ervoor zorgt dat er maar één instantie van een klasse kan bestaan. Dit is handig wanneer je bijvoorbeeld een klasse hebt die een verbinding maakt met een database. Je wilt niet dat er meerdere verbindingen tegelijkertijd open staan, dus zorg je ervoor dat er maar één instantie van de klasse kan bestaan.

Hoe maak je een singleton?
--------------------------
Een singleton maak je door de constructor van de klasse private te maken. Vervolgens maak je een static methode aan die een instantie van de klasse teruggeeft. Deze methode controleert of er al een instantie van de klasse bestaat. Zo ja, dan wordt deze teruggegeven. Zo nee, dan wordt er een nieuwe instantie aangemaakt en teruggegeven.

> Singleton
> 
> ---
> 
> -<u>instance</u>:Singleton
>
> ---
> 
> -Singleton()
> 
> +<u>getInstance()</u>:Singleton
>
> ---
> 
> Arrow naar zichzelf


```javascript

uml underline is Static.

```javascript
private static insance singleton;