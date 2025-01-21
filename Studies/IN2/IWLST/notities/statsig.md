Continue reading -> https://statsig.com/blog/product-experimentation-best-practices
Continue reading -> https://docs.statsig.com/metrics/console

> ### User vs Device-level expiriment
> 
> Most experiments randomize the users that are exposed to different variants. We call these [user-level experiments](https://docs.statsig.com/guides/abn-tests). To randomize based on devices, say when you don't yet have a userID (e.g. for unregistered users), consider a [Device-level Experiment](https://docs.statsig.com/guides/first-device-level-experiment).

> ### CMS Integration
> 
> [The Guide](https://docs.statsig.com/guides/cms-integrations) recommends using [Layers](https://docs.statsig.com/layers)
> 
> - What layers would we have?
>   - Main-menu
>   - Homepage
>   - Shop-page
>   - Product Detail page
>   - Checkout process
> 
> #### [A quick note about billing & layers](https://docs.statsig.com/layers#a-word-on-exposures)
> 
> - If the user is assigned to an experiment within the Layer, the statsig::layer_exposure exposure event is billable.
> - If the user is not assigned an experiment within the Layer, the statsig::layer_exposure exposure event is not billable.

> ### What do we want to test?
> 
> ---
> 
> #### Device Based
> Phone and desktop need to be tested separately. Some element might preform better on desktop than on mobile and vice versa.
> This needs to be included into two different metrics. For this to work our we need to apply some logic based on the users device.
> - Q. For the different type of devices the best way in the PLNTS ecosystem is to use the tailwind breakpoints.
> - Q. Is it necessary to test the different breakpoints separately?
> - Q. Do we need different layers for this?
> 
> ---
> 
>  - Homepage


> ### How do I effectively test in a development environment?
> 
> Since running experiments, calculating metric both require a large flow of data I need a way to mock user behaviour.
> 
> 


Give users the option to compare different views "list view or Grid view" And do some metrics based on that