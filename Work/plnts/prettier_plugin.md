*The following examples are snippets from the codebase and they each have their own maximum access space until they reach the maximum line length of 100, in addition the whitespace is not 1:1 for these examples. I'll also number all the examples so it easier to reference them in the comments*

---

Couple of things to note:
---

**Firstly:**

This cannot be done anymore
```jsx
// Example 1
<div
    className="
        max-w-[1033px] 3xl:max-w-full
        flex flex-row flex-nowrap gap-3
        scrollbar-fix overflow-x-scroll snap-x snap-proximity
        before:content-[''] before:-my-px before:w-px before:snap-start
        after:content-[''] after:-my-px after:w-px after:snap-start
    "
>
```

The order will change and the className should now be like this:
```jsx
// Example 2
<div
    className="
      scrollbar-fix flex max-w-[1033px] snap-x snap-proximity flex-row flex-nowrap gap-3
      overflow-x-scroll before:-my-px before:w-px before:snap-start before:content-['']
      after:-my-px after:w-px after:snap-start after:content-[''] 3xl:max-w-full
    "
>
```


--- 

**Secondly:**

If we split up a string inside a cn(...), each part will be ordered on its own instead of ordering the whole string.

i.e.:
```jsx
// Example 3
<div
    className={cn(
      className,
      'grid-container px-3 md:px-0 mt-7 md:mt-14 mb-7 md:mb-14',
      'flex flex-col md:flex-row',
      'divide-y md:divide-y-0 md:divide-x divide-black/30',
      'overflow-hidden',
    )}
>
```

The plugin does this:
```jsx
// Example 4
<div
    className={cn(
      className,
      'grid-container mt-7 mb-7 px-3 md:mt-14 md:mb-14 md:px-0',
      'flex flex-col md:flex-row',
      'divide-y divide-black/30 md:divide-y-0 md:divide-x',
      'overflow-hidden',
    )}
>
```

and it should be something like this:
```jsx
// Example 5
<div
    className={cn(
      className,
      'grid-container mt-7 mb-7 flex flex-col divide-y divide-black/30 overflow-hidden px-3',
      'md:mt-14 md:mb-14 md:flex-row md:divide-y-0 md:divide-x md:px-0',
    )}
>
```
This is done by putting the whole string between 2 single quotes, then let the plugin order it and the manually split it up again to keep the maximum line length. Which is a bit of a hassle.

Another solution woud be to use backticks instead of using quotes, which causes the plugin to order the whole string.

it would look like something like this:

```jsx
// Example 6
<div
    className={cn(
      className,
        `
          grid-container mt-7 mb-7 flex flex-col divide-y divide-black/30 overflow-hidden px-3
          md:mt-14 md:mb-14 md:flex-row md:divide-y-0 md:divide-x md:px-0
        `,  
    )}
>
```
I think using backtick in this case is a bit cleaner, but I'm not sure if this is the best solution.

For cases like this:
```jsx
// Example 7
<ul
  className={cn('text-white md:space-y-2', {
    'mt-12 space-y-3 md:px-20': variantType === 'sidebar',
    'flex flex-row flex-nowrap justify-between gap-[1px] bg-account-dark p-px md:mt-12 md:block md:bg-transparent md:px-4 xl:px-12 3xl:px-20':
      variantType === 'page',
  })}
>
```

Could be replaced with:
```jsx
// Example 8
<ul
    className={cn('text-white md:space-y-2', {
        'mt-12 space-y-3 md:px-20': variantType === 'sidebar',
        [`
          flex flex-row flex-nowrap justify-between gap-[1px] bg-account-dark p-px
          md:mt-12 md:block md:bg-transparent md:px-4 xl:px-12 3xl:px-20
        `]: variantType === 'page',
    })}
>
```

---
**Thirdly:**

A general question on how to hard the maximum line length should be enforced. In some cases the overall readability is better when the line length is a bit longer. Is it ok for me to judge this on case by case basis or should we have a hard limit? Or are there some other guidelines for this?

---

**Fourthly:**

I'm not sure if this is a bug or a feature, but the plugin orders the following like this:
```jsx
// Example 9
<li
    key={`usps-block-${usp.id}`}
    className="
           xl:justify-left before:mr-2 before:text-primary before:content-['\2713']
           sm:text-sm md:flex lg:text-base xl:flex xl:w-auto xl:items-center xl:text-left
        "
>
```

And it also does this:
```jsx
// Example 10
<div
  className="
    before:content-[' '] after:content-[' '] scrollbar-fix mt-3 grid w-full
    grid-cols-topStars gap-3 overflow-x-scroll before:whitespace-pre after:whitespace-pre
    lg:grid-cols-topStarsLg lg:before:hidden lg:after:hidden
  "
>
```
