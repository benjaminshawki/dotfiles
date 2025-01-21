FYI, in je vakantie is er:
- een update naar productie gedaan ivm met bundled producten die niet werden gecached in apollo voor producten die in strapi gezet worden en uit magento opgehaald moeten worden. (PLK-824)
- in postman de magento variabele verplaats van productie naar de individuele
- in postman de NextStaging environment toegevoegd met de bijbehorende magento
- voor PLK-730 heb ik je code van DM stockdate geuncomment, de naam `firstPickupDate` verandert naar `stockdate` (wat DM moet hebben) en de back_order_status toegevoegd aan de gql query
- voor PLK-730, werkt er iet ivm met de weergave van de back in stock date niet, het beste kun je dit even met Alan bespreken.

