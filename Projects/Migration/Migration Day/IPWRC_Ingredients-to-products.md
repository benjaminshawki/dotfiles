TODO

> ***1)*** **Renaming Process**
> 
> - [ ] Scan the parts that need to be copied.
> 
> ---
> 
> ***2)*** **Config files**
> 
> ---
> 
> ***3)*** **What features need to be added**
>   
> - [x] a service worker 
> 
> - [ ] springboot backend
> 
>
> ---
> 
> 
> ***4)*** **What features need to be modified**
> 
>  - [ ] add ingredients should be variations, then you need to be able to select and add a specific variation to the cart
> 
> ---
>
> 
> ***5)*** **OWASP TOP 10**
> 
> - [ ] The following features need to be Checked and Features need to be added to ***3)***
> 
> https://owasp.org/www-project-top-ten/
> 
> <ul>
>  <li><a href="https://owasp.org/Top10/A01_2021-Broken_Access_Control/"><strong>A01:2021-Broken Access Control</strong></a> moves up from the fifth position; 94% of applications were tested for some form of broken access control. The 34 Common Weakness Enumerations (CWEs) mapped to Broken Access Control had more occurrences in applications than any other category.</li>
>  <li><a href="https://owasp.org/Top10/A02_2021-Cryptographic_Failures/"><strong>A02:2021-Cryptographic Failures</strong></a> shifts up one position to #2, previously known as Sensitive Data Exposure, which was broad symptom rather than a root cause. The renewed focus here is on failures related to cryptography which often leads to sensitive data exposure or system compromise.</li>
>  <li><a href="https://owasp.org/Top10/A03_2021-Injection/"><strong>A03:2021-Injection</strong></a> slides down to the third position.  94% of the applications were tested for some form of injection, and the 33 CWEs mapped into this category have the second most occurrences in applications. Cross-site Scripting is now part of this category in this edition.</li>
>  <li><a href="https://owasp.org/Top10/A04_2021-Insecure_Design/"><strong>A04:2021-Insecure Design</strong></a> is a new category for 2021, with a focus on risks related to design flaws. If we genuinely want to “move left” as an industry, it calls for more use of threat modeling, secure design patterns and principles, and reference architectures.</li>
>  <li><a href="https://owasp.org/Top10/A05_2021-Security_Misconfiguration/"><strong>A05:2021-Security Misconfiguration</strong></a> moves up from #6 in the previous edition; 90% of applications were tested for some form of misconfiguration. With more shifts into highly configurable software, it’s not surprising to see this category move up. The former category for XML External Entities (XXE) is now part of this category.</li>
>  <li><a href="https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/"><strong>A06:2021-Vulnerable and Outdated Components</strong></a> was previously titled Using Components with Known Vulnerabilities and is #2 in the Top 10 community survey, but also had enough data to make the Top 10 via data analysis. This category moves up from #9 in 2017 and is a known issue that we struggle to test and assess risk. It is the only category not to have any Common Vulnerability and Exposures (CVEs) mapped to the included CWEs, so a default exploit and impact weights of 5.0 are factored into their scores.</li>
>  <li><a href="https://owasp.org/Top10/A07_2021-Identification_and_Authentication_Failures/"><strong>A07:2021-Identification and Authentication Failures</strong></a> was previously Broken Authentication and is sliding down from the second position, and now includes CWEs that are more related to identification failures. This category is still an integral part of the Top 10, but the increased availability of standardized frameworks seems to be helping.</li>
>  <li><a href="https://owasp.org/Top10/A08_2021-Software_and_Data_Integrity_Failures/"><strong>A08:2021-Software and Data Integrity Failures</strong></a> is a new category for 2021, focusing on making assumptions related to software updates, critical data, and CI/CD pipelines without verifying integrity. One of the highest weighted impacts from Common Vulnerability and Exposures/Common Vulnerability Scoring System (CVE/CVSS) data mapped to the 10 CWEs in this category. Insecure Deserialization from 2017 is now a part of this larger category.</li>
>  <li><a href="https://owasp.org/Top10/A09_2021-Security_Logging_and_Monitoring_Failures/"><strong>A09:2021-Security Logging and Monitoring Failures</strong></a> was previously Insufficient Logging &amp; Monitoring and is added from the industry survey (#3), moving up from #10 previously. This category is expanded to include more types of failures, is challenging to test for, and isn’t well represented in the CVE/CVSS data. However, failures in this category can directly impact visibility, incident alerting, and forensics.</li>
>  <li><a href="https://owasp.org/Top10/A10_2021-Server-Side_Request_Forgery_%28SSRF%29/"><strong>A10:2021-Server-Side Request Forgery</strong></a> is added from the Top 10 community survey (#1). The data shows a relatively low incidence rate with above average testing coverage, along with above-average ratings for Exploit and Impact potential. This category represents the scenario where the security community members are telling us this is important, even though it’s not illustrated in the data at this time.</li>
> </ul>
> 
> ---
> 