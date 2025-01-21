# First note
Kubernetes is a tool for running a bunch of different containers

We give it some configuration to describe how we want our containers to run and interact with eachother
![](vx_images/574633300247404.png)

![](vx_images/539265114226351.png)
![](vx_images/5045614242630.png)
![](vx_images/95265814235675.png)
![](vx_images/466400015232442.png)
```apiVersion: v1
kind: Pod
metadata:
  name: posts
spec:
  containers:
    - name: posts
      image: bluejund/posts:0.0.1
```
![](vx_images/475540915240816.png)
![](vx_images/480991115246571.png)
![](vx_images/406721215247203.png)
![](vx_images/53221715237939.png)
![](vx_images/228401715230798.png)
Deployment has a set of pods

![](vx_images/242603515249607.png)
![](vx_images/298314915244715.png)
![](vx_images/546545115252226.png)
![](vx_images/233185215251237.png)
![](vx_images/525535215238577.png)

![](vx_images/444015821225568.png)
![](vx_images/240650122236045.png)
![](vx_images/540770822228615.png)
#Deployment
![](vx_images/474162722249157.png)



