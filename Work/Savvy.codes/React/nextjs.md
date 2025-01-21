# nextjs
Fast Search Engine Optimization with 0 configuration

Used for renndering content in advance on the server

Data fetching (SSG vs SSR vs ISR)

SSG
    Static generation (prerender, build time) 
    cons
        -data may become stale
        -hard to scale

SSR
    Server-Side Rendering
    generate each page at request time
    cons
        -slower
        -innefficient data caching
    
ISR
    Incremental Static Regeneration
    re-generate single pages in the     background
    
Server side data fetching