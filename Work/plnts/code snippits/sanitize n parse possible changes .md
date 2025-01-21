```js

import DOMPurify from 'isomorphic-dompurify';
import parseHtml, { domToReact } from 'html-react-parser';

/**
 * Take a string that has html content, sanitize it with an optional allowTags list.
 *
 * @param {string} htmlString - The string to process.
 * @param  {array} allowedTags - Array with objects on what tags to allow and what config goes with it.
 * @returns {object} - An React node.
 */
export function sanitizeAndParse(
  htmlString = null,
  allowedTags = [{ tag: '', options: { className: '' } }],
) {
  if (!htmlString || typeof htmlString !== 'string') {
    return '';
  }

  const sanitizedString = DOMPurify.sanitize(htmlString || '', { ALLOWED_TAGS: allowedTags });
  const parseOptions = {
    replace(domNode) {
      for (let i = 0; i < allowedTags.length; i++) {
        if (domNode.name === allowedTags[i].tag) {
          const Tag = allowedTags[i].tag;
          return (
            <Tag className={allowedTags[i].options.className}>
              {domToReact(domNode.children, parseOptions)}
            </Tag>
          );
        }
        // if (domNode.name === 'strong') {
        //   return <strong className="font-bold">{domToReact(domNode.children, parseOptions)}</strong>;
        // }
      }
    },
  };
  return parseHtml(sanitizedString.replace(/ /g, '\u00A0'), parseOptions);
}

```


```js

function UniqueSellingPoints({ className }) {
    const uniqueSellingPoints = useStrapiApi(
      `/unique-selling-points/product-detail-page?randomizeUsps=3`,
    );
    return (
      <ul className={cn(`space-y-2`, className)}>
        {uniqueSellingPoints.usps?.map((usp) => {
          return (
            <li
              key={`usps-block-${usp.id}`}
              className="before:content-['\2713'] before:mr-2 before:text-primary
                          xl:flex xl:items-center xl:justify-left xl:text-left xl:w-auto
                          lg:text-base md:flex sm:text-sm"
            >
              {sanitizeAndParse(usp.usp, [{ tag: 'strong', options: { className: 'font-bold' } }])}
            </li>
          );
        })}
      </ul>
    );
  
```